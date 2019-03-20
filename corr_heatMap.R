library(corrplot)
library(gplots)


mat_val <- read.table("merged4regions_average_scaled_052218.csv", header = T, sep="\t", row.names=1)
data.m <- as.matrix(mat_val)

col <- colorRampPalette(c("white","darkblue","blue", "lightgreen","yellow", "orange","darkorange","red","darkred"))(100)
corr_mat=cor(data.m)
tiff("corrplot_merged4regions_scaled.jpg",units="in",width=15,height=15,res=300)
heatmap.2(corr_mat,col= col,dendrogram ="both",trace='none',margin = c(8,8),keysize = 0.5)
dev.off()
heatmap(corr_mat,col=col,symm=TRUE)
corrplot(corr_mat,method="color",order="hclust",col=col,cl.lim=c(-0.6,1))
