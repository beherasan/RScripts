data2Use = read.table("normalized.txt", sep="\t",stringsAsFactors=T,header=T)
rownames(data2Use) = data2Use[,1]
data2Use = data2Use[,-1]

sampleInfo = read.table("annotation.txt", sep="\t",stringsAsFactors=T,header=T)
p = prcomp(data2Use)
use = p$rotation

require(ggplot2); require(reshape2)
toplot = cbind(sampleInfo[match(rownames(use), sampleInfo$ColumnName), ], use)
pdf("all_PCs.pdf")
ggplot(melt(toplot[,1:6],id.vars=1:2), aes(x=SampleType, y=value, col=SampleType)) +geom_boxplot() +geom_point() +facet_wrap(~variable,scales="free_y") +ylab("PC loading")
dev.off()

ggplot(toplot, aes(x=PC1, y=PC4, col=SampleType)) +geom_point(aes(size=2))
#ggplot(toplot, aes(x=PC3, y=PC4, col=SampleType)) +geom_point(aes(size=2))

d <- as.matrix(data2Use)

dimm <- dim(d)
toPlot = data.frame()
for (i in 1:dimm[1]){
  c.median = mean(d[i,1:3])
  t.median = mean(d[i,4:6])
  new.c <- c.median/(max(c(c.median,t.median)))
  new.t <- t.median/(max(c(c.median,t.median)))
  #toPlot <- rbind(toPlot,c(c.median,t.median))
  toPlot <- rbind(toPlot,c(new.c,new.t))
}
row.names(toPlot) <- row.names(d)
colnames(toPlot) <- c("Control","Treated")
toPlot <- as.matrix(toPlot)

library(gplots)
pdf("heatmap.pdf")
heatmap.2( toPlot,
           col = colorpanel(200,"orange","red","darkred"),
           trace = "none", 
           symbreaks = min(toPlot, na.rm=TRUE),
           na.color="white",
           cexRow = 1.0, cexCol = 0.8,
           key = TRUE,keysize = 1,
           main = "Control Vs Treated Expression", 
           dendrogram = "row",
           sepwidth=c(0.001,0.001),
           sepcolor="black",
           colsep=0:ncol(toPlot),
           rowsep=0:nrow(toPlot),
           Colv = FALSE, Rowv = TRUE)
dev.off()
