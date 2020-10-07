## Load required libraries
library(devtools)
library(Biobase)
library(preprocessCore)
library(sva)


## Function for converting Matrix values to log10
log10scale<-function(x){
  dimm=dim(x)
  for(i in 1:dimm[1]){
    x[i,]=log10(x[i,])
  }
  return(x)
}

## Read the file .csv 
data <- read.csv("DBP_TMT_Cerebellum_Proteins_0removed_all9.txt", sep = "\t", header= TRUE, row.names= 1)
data.m<-as.matrix(data)
data.m
data.logm<-log10scale(data.m)
data.logm

## Quantile normalization 
norm_edata = normalize.quantiles(data.logm)

## 
par(mfrow=c(1,2))
colramp = colorRampPalette(c(3,"white",2))(10)

# dim(data.logm)
plot(density(data.logm[,1]),col=colramp[1],lwd=3,ylim=c(0,1.0))
for(i in 2:27){lines(density(data.logm[,i]),lwd=3,col=colramp[i])}
#for(i in 2:4){lines(density(data[i,]),lwd=3,col=colramp[i])}

plot(density(norm_edata[,1]),col=colramp[1],lwd=3,ylim=c(0,1.0))
for(i in 2:27){lines(density(norm_edata[,i]),lwd=3,col=colramp[i])}

## norm_edata
## class(norm_edata)
colnames(norm_edata)
colnames(norm_edata)<-colnames(data.logm)
rownames(norm_edata)<-rownames(data.logm)
## colnames(norm_edata)
## colnames(data.logm)
## rownames(data.logm)

## Read the batch detail file
mat_val_b <- read.table("batch.csv", header = T, sep=",", row.names=1)

## Set the matrix model for Batch correction
modcombat = model.matrix(~1, data=mat_val_b)

## Combat for Batch correction
combat_edata = ComBat(dat=norm_edata, batch = mat_val_b$batch, mod=modcombat, par.prior=TRUE, prior.plots=FALSE)
combat_edata

## Set the plotting area into a 1*2 array
par(mfrow=c(1,2))

## Boxplot of Before and after batch correction
boxplot.matrix(norm_edata,ylim=c(2,9),
               col = c("yellow","yellow","yellow","red","red","red","green","green","green","blue","blue","blue","orange","orange","orange","pink","pink","pink","brown","brown","brown","cyan","cyan","cyan","darkmagenta","darkmagenta","darkmagenta"),pch = 5,cex=0.2,main="Before Batch Correction",las=2,cex.axis=0.7)
boxplot.matrix(as.matrix(combat_edata),ylim=c(2,9),
               col = c("yellow","yellow","yellow","red","red","red","green","green","green","blue","blue","blue","orange","orange","orange","pink","pink","pink","brown","brown","brown","cyan","cyan","cyan","darkmagenta","darkmagenta","darkmagenta"),pch = 5,cex=0.2,main="After Batch Correction",las=2,cex.axis=0.7)

## Write the batch corrected matrix to a file
write.table(combat_edata,file="DBP_TMT_cerebellum_all9_QN_BC.txt",sep=",")
