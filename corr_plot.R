library(ggpubr)
data.amygdala<- read.csv("amygdala.txt",header=TRUE, row.names=1,sep="\t")
ggscatter(data.amygdala,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE,cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_Amygdala",ylab="GTEx_Amygdala")
