setwd("E:/Poornima/Projects/Dr_Rajesh_Shastry/Clusterplot")
## Load required libraries
library(devtools)
library(Biobase)
library(preprocessCore)
library(sva)
library(qsmooth)
library(ggplot2)
library(gplots)

## Read the file
data <- read.csv("FOR_CLUSTER_MC.txt",sep="\t",header=TRUE, row.names = 1)

### Smooth Qunatile normalization
group_factor <- rep(c(1:2),each=3)
qs <- qsmooth(object = data, group_factor = group_factor)
qs.data <- qsmoothData(qs)

### Batch correction
## Read the batch detail file
mat_val_b <- read.table("batch.csv", header = T, sep=",", row.names=1)
## Set the matrix model for Batch correction
modcombat = model.matrix(~1, data=mat_val_b)
## Combat for Batch correction
combat_edata = ComBat(dat=qs.data, batch = mat_val_b$batch, mod=modcombat, par.prior=TRUE, prior.plots=FALSE)


## function for t-test and return p-value for each row of a matrix
my.p.value<-function(a,b){
  obj<-try(t.test(x,y,alternative = "two.sided",mu=0,paired = FALSE,conf.level = 0.95),silent=TRUE)
  if(is(obj,"try-error"))
  {
    return("NA")
  }else
  {
    return(obj$p.value)
  }
}

n1 <- c()
re1 <- c()
for(i in 1:dim(combat_edata)[1]){
  x<-c(combat_edata[i,c(4,5,6)])
  y<-c(combat_edata[i,c(1,2,3)])
  n<-rownames(combat_edata)[i]
  re<-my.p.value(x,y)
  n1 <- c(n1,n)
  re1 <- c(re1,re)
  
}
re1<- as.numeric(re1)
res <- (data.frame(n1,re1))
res

pValues = as.data.frame(re1, row.names = n1) 
colnames(pValues) = c("Condition")
head(pValues)

pValThreshold = 0.05

sig <- row.names(pValues)[which(pValues[,1] < pValThreshold)]
toPlot <- combat_edata[match(sig, rownames(combat_edata)), ]


normalization<-function(x){
  dimm=dim(x)
  for(i in 1:dimm[1]){
    x[i,]=(x[i,]-mean(x[i,]))/sd(x[i,]) 
  }
  return(x)
}

toPlot.norm <- normalization(toPlot) 
toPlot.norm

### PheatMap
library(pheatmap)

H = pheatmap(toPlot.norm,cluster_cols = FALSE)
#rownames(toPlot.norm[H$tree_row[["order"]],])
hc_clust <- cutree(H$tree_row, k=5)
new_hc <- c()
for (i in 1:length(hc_clust)){
  new_hc[i] <- paste("Cluster ",hc_clust[i])
  names(new_hc)[i] <- names(hc_clust[i])
}

new_hc <- data.frame(new_hc)

colnames(new_hc) <- "Clusters"

newCols <- colorRampPalette(grDevices::rainbow(length(unique(new_hc$Clusters))))
mycolors <- newCols(length(unique(new_hc$Clusters)))
names(mycolors) <- unique(new_hc$Clusters)
mycolors <- list(Clusters = mycolors)

setEPS()
postscript("MC_CLUSTERS_5.eps")
pheatmap(toPlot.norm[H$tree_row$order,],cluster_cols = FALSE,cluster_rows = FALSE,cellwidth = 10,cutree_rows = 10,show_rownames = F, annotation_row = new_hc,annotation_colors = mycolors)
dev.off()

write.table(new_hc,file="MC_CLUSTERS_5.txt",sep="\t")
