## Load required packages
library(dplyr)
library(devtools)
library(Biobase)
library(preprocessCore)
library(sva)
library(qsmooth)
#########################

## Load the data and select appropriate columns for the further analysis
data2use = read.csv("GastricCancerPTM_TP_PXD003115_Peptide_Groups.txt", sep="\t", header=T)
colnames(data2use)
a <- subset(data2use, select=c("Annotated.Sequence", "Modifications.in.Master.Proteins","Master.Protein.Accessions","Abundance..F1..114..Control..P1","Abundance..F2..114..Control..P2","Abundance..F3..114..Control..P3","Abundance..F1..115..Sample..P1","Abundance..F2..115..Sample..P2","Abundance..F3..115..Sample..P3","Abundance..F1..116..Control..P1","Abundance..F2..116..Control..P2","Abundance..F3..116..Control..P3","Abundance..F1..117..Sample..P1","Abundance..F2..117..Sample..P2","Abundance..F3..117..Sample..P3"))
head(a)
colnames(a) <- c("sequence","mod","master","C1","C2","C3","S1","S2","S3","C4","C5","C6","S4","S5","S6")
head(a)

## Extract the rows with at least one non-zero value
a$new <- rowSums(a[,4:15])
head(a)
a.extracted <- a[which(a$new > 0),]
dim(a.extracted)

## Add a unique number to each row as id and prepare a matrix
uniq.id <-c(1:length(a.extracted$new))
a.extracted <- cbind(a.extracted,uniq.id)
row.names(a.extracted) <- t(a.extracted[ncol(a.extracted)])
a.mat <- a.extracted[,4:15]
rownames(a.mat) <- rownames(a.extracted)
data.m <- as.matrix(a.mat)

## Smooth Quantile Normalization with grouping information, and extract the normalized matrix
group_factor <- rep(c(1,2,1,2),each=3)
group_factor
qs <- qsmooth(object = data.m, group_factor = group_factor)
qs.data <- qsmoothData(qs)

## Density plot for before and after normalization
par(mfrow=c(1,2))
colramp = colorRampPalette(c(3,"white",2))(10)
plot(density(data.m[,1]),col=colramp[1],lwd=3,xlim=c(0,5e+5),ylim=c(0,0.000001),main="Before smooth QN")
for(i in 2:ncol(data.m)){lines(density(data.m[,i]),lwd=3,col=colramp[i])}
plot(density(qs.data[,1]),col=colramp[1],lwd=3,xlim=c(0,5e+5),ylim=c(0,0.000001),main="After smooth QN")
for(i in 2:ncol(qs.data)){lines(density(qs.data[,i]),lwd=3,col=colramp[i])}

## Boxplot for the normalized data
par(mfrow=c(1,1))
boxplot(qs.data, ylim=c(10,1500),col= rep(c("red","green","blue"),each=3))

## Batch effect correction
# Read the batch detail file
#mat_val_b <- read.table("batch.csv", header = T, sep=",", row.names=1)
# Set the matrix model for Batch correction
#modcombat <- model.matrix(~1, data=mat_val_b)
# Combat for Batch correction
#combat_edata <- ComBat(dat=qs.data, batch = mat_val_b$batch, mod=modcombat, par.prior=TRUE, prior.plots=FALSE)
combat_edata <- qs.data
## boxplot for before and after batch correction
#par(mfrow=c(1,2))
#boxplot(qs.data, ylim=c(1e+3,1e+6),col= rep(c("red","green","blue"),each=3), main="Before batch correction")
#boxplot(combat_edata,ylim=c(1e+3,6e+5),col=rep(c("red","green","blue"),each=3),main="After batch correction")

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

## Separate out Light vs Heavy and Medium vs Heavy
matCS <- combat_edata
dim(matCS)

## Dataframe for Volcano plot for Light vs Heavy
toVolcano.CS<-c()
n1 <- c()
re1 <- c()
fc1 <- c()
for(i in 1:139455){
  x<-c(matCS[i,c(4,5,6,10,11,12)])
  y<-c(matCS[i,c(1,2,3,7,8,9)])
  n<-rownames(matCS)[i]
  re<-my.p.value(x,y)
  m1 <- mean(matCS[i,c(4,5,6,10,11,12)])
  m2 <- mean(matCS[i,c(1,2,3,7,8,9)])
  fc <- m1/m2
  n1 <- c(n1,n)
  re1 <- c(re1,re)
  fc1 <- c(fc1,fc)
}
re1<- as.numeric(re1)
fc1 <- as.numeric(fc1)
toVolcano.CS <- (data.frame(n1,re1,fc1))
class(toVolcano.CS$re1)
toVolcano.CS$re1
## dataframe for Volcano plot for Medium vs Heavy
#toVolcano.MH<-c()
#n1 <- c()
#re1 <- c()
#fc1 <- c()
#for(i in 1:2634){
#  x<-c(mat.mediumHeavy[i,1:3])
#  y<-c(mat.mediumHeavy[i,4:6])
#  n<-rownames(mat.mediumHeavy)[i]
#  re<-my.p.value(x,y)
#  m1 <- mean(mat.mediumHeavy[i,1:3])
#  m2 <- mean(mat.mediumHeavy[i,4:6])
#  fc <- m1/m2
#  n1 <- c(n1,n)
#  re1 <- c(re1,re)
#  fc1 <- c(fc1,fc)
#}
#toVolcano.MH <- (data.frame(n1,re1,fc1))

## Volcano plot
#par(mfrow=c(1,2))
with(toVolcano.CS, plot(log2(fc1), -log10(re1), pch=20, col="grey",main="Volcano Plot", ylab="-log10(pValue)",xlab="log2(FoldChange)"))
#with(subset(toVolcano.CS, -log10(re1) > 1.3 & log2(fc1)>0.58), points(log2(fc1), -log10(re1), pch=25, col="green"))
with(subset(toVolcano.CS, -log10(re1) > 1.3 & log2(fc1)>0.58), points(log2(fc1), -log10(re1), pch=20, col="green"))
#with(subset(toVolcano.CS, -log10(re1) > 1.3 & log2(fc1)<(-0.58)), points(log2(fc1), -log10(re1), pch=25, col="red"))
with(subset(toVolcano.CS, -log10(re1) > 1.3 & log2(fc1)<(-0.58)), points(log2(fc1), -log10(re1), pch=20, col="red"))
abline(h = 1.3, col = "blue", lty = 2, lwd = 1)
abline(v = c(-0.58,0.58), col = "blue", lty = 2, lwd = 1)

#with(toVolcano.LH, plot(log2(fc1), -log10(re1), pch=20, main="Volcano plot Light vs Heavy", ylab="-log10(pvalue)"))
#with(subset(toVolcano.LH, -log10(re1) > 1.3 & log2(fc1)>0.58), points(log2(fc1), -log10(re1), pch=25, col="green"))
#with(subset(toVolcano.LH, -log10(re1) > 1.3 & log2(fc1)>0.58), points(log2(fc1), -log10(re1), pch=20, col="green"))
#with(subset(toVolcano.LH, -log10(re1) > 1.3 & log2(fc1)<(-0.58)), points(log2(fc1), -log10(re1), pch=25, col="red"))
#with(subset(toVolcano.LH, -log10(re1) > 1.3 & log2(fc1)<(-0.58)), points(log2(fc1), -log10(re1), pch=20, col="red"))
#abline(h = 1.3, col = "blue", lty = 2, lwd = 1)
#abline(v = c(-0.58,0.58), col = "blue", lty = 2, lwd = 1)

## Find the differentially expressed peptides Medium vs Heavy
CS.up <- rownames(toVolcano.CS[which(toVolcano.CS$fc1 > 1.5  & toVolcano.CS$re1 < 0.05),])
CS.down <- rownames(toVolcano.CS[which(toVolcano.CS$fc1 < 0.67  & toVolcano.CS$re1 < 0.05),])
CS.dex <- c(CS.up,CS.down)
CS.t <- cbind(a.extracted[match(row.names(combat_edata), rownames(a.extracted)), ], combat_edata)
CS.t1 <- cbind(CS.t[match(row.names(toVolcano.CS),CS.t$uniq.id),],toVolcano.CS)
CS.t2 <- CS.t1[match(CS.dex,CS.t1$uniq.id),]
write.table(CS.t2,file="CS_dex_all_070219.txt",sep="\t")

## Find the differentially expressed peptides Light vs Heavy
LH.up <- rownames(toVolcano.LH[which(toVolcano.LH$fc1 > 1.5  & toVolcano.LH$re1 < 0.05),])
LH.down <- rownames(toVolcano.LH[which(toVolcano.LH$fc1 < 0.67  & toVolcano.LH$re1 < 0.05),])
LH.dex <- c(LH.up,LH.down)
LH.t <- cbind(a.extracted[match(row.names(combat_edata), rownames(a.extracted)), ], combat_edata)
LH.t1 <- cbind(LH.t[match(row.names(toVolcano.LH),LH.t$uniq.id),],toVolcano.LH)
LH.t2 <- LH.t1[match(LH.dex,LH.t1$uniq.id),]
write.table(LH.t2,file="LH_dex_all_062619.txt",sep="\t")

## Gene Ontology
#MH.GO.master <- as.data.frame(MH.t2$master)
#MH.GO.master
#for (i in 1:dim(MH.GO.master)[1]){
#  strsplit(toString(MH.GO.master[i,1]), ";")
#}


#x <- sapply(MH.GO.master,split(x,f) )
#x <- lapply(MH.GO.master,function(id){unlist(strsplit(toString(id),";"))})
#class(x)
#as.data.frame(x)
