library(ggpubr)
data.amygdala<- read.csv("amygdala.txt",header=TRUE, row.names=1,sep="\t")
#amygdala.cor<-ggscatter(data.amygdala,x= "HBP", y= "GTEx",color="HBP",add="reg.line",size=1, conf.int=TRUE,cor.coef = TRUE,cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_Amygdala",ylab="GTEx_Amygdala")
amygdala.cor<-ggscatter(data.amygdala,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE,cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_Amygdala",ylab="GTEx_Amygdala")
amy<-amygdala.cor+gradient_color(c("black","blue", "red","darkred"))

data.acc<- read.csv("acc.txt",header=TRUE, row.names=1, sep="\t")
acc.cor<- ggscatter(data.acc,x= "HBP", y= "GTEx",color="HBP", size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_ACC",ylab="GTEx_ACC")
acc<-acc.cor+gradient_color(c("black","blue", "red","darkred"))

data.cn<- read.csv("caudate_nucleus.txt",header=TRUE, row.names=1,sep="\t")
cn.cor<- ggscatter(data.cn,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_C_Nucleus",ylab="GTEx_C_Nucleus")
cn<-cn.cor+gradient_color(c("black","blue", "red","darkred"))

data.cr<- read.csv("cerebellum.txt",header=TRUE, row.names=1,sep="\t")
cr.cor<- ggscatter(data.cr,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_Cerebellum",ylab="GTEx_Cerebellum")
cr<-cr.cor+gradient_color(c("black","blue", "red","darkred"))

data.fc<- read.csv("frontal_cortex.txt",header=TRUE, row.names=1,sep="\t")
fc.cor<- ggscatter(data.fc,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_F_Cortex",ylab="GTEx_F_Cortex")
fc<-fc.cor+gradient_color(c("black","blue", "red","darkred"))

data.h<- read.csv("hippocampus.txt",header=TRUE, row.names=1,sep="\t")
h.cor<- ggscatter(data.h,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_Hippocampus",ylab="GTEx_Hippocampus")
h<-h.cor+gradient_color(c("black","blue", "red","darkred"))

data.p<- read.csv("putamen.txt",header=TRUE, row.names=1,sep="\t")
p.cor<- ggscatter(data.p,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_Putamen",ylab="GTEx_Putamen")
p<-p.cor+gradient_color(c("black","blue", "red","darkred"))

data.sn<- read.csv("substantia_nigra.txt",header=TRUE, row.names=1,sep="\t")
sn.cor<- ggscatter(data.sn,x= "HBP", y= "GTEx",color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_S_nigra",ylab="GTEx_S_nigra")
sn<-sn.cor+gradient_color(c("black","blue", "red","darkred"))

data.cc<- read.csv("cervical_cord.txt",header=TRUE, row.names=1,sep="\t")
cc.cor<- ggscatter(data.cc,x= "HBP", y= "GTEx", color="HBP",size=1, conf.int=TRUE,cor.coef = TRUE, cor.coef.coord=c(2,4), cor.method = "spearman",xlab="HBP_C_cord",ylab="GTEx_C_cord")
cc<-cc.cor+gradient_color(c("black","blue", "red","darkred"))

ggarrange(amygdala.cor,acc.cor,cn.cor,cr.cor,fc.cor,h.cor,p.cor,sn.cor,cc.cor, labels = c("A","B","C","D","E","F","G","H","I"),ncol=3, nrow = 3,heights=3)
ggarrange(amy,acc,cn,cr,fc,h,p,sn,cc, labels = c("A","B","C","D","E","F","G","H","I"),ncol=3, nrow = 3,heights=3)