library(gplots)
library(RColorBrewer)
library(colorspace)

#normalization<-function(x){
#  dimm=dim(x)
 # for(i in 1:dimm[1]){
  #  x[i,]=(x[i,]-mean(x[i,]))/sd(x[i,]) 
  #}
  #return(x)
#}

mat_val <- read.csv("DBP_cerebellum_ASOP_scaled.txt", sep=",", header = T, row.names=1)
data.m <- as.matrix(mat_val)
data.m

#data.m<-log2(data.m)
#data.norm<-normalization(data.m)

#myCol <-colorRampPalette(c("red","orange", "yellow","green","blue","darkblue"))(n = 200)
#myCol <-colorRampPalette(c("khaki1","khaki2","yellow", "orange","red"))(n = 200)
myCol <-colorRampPalette(c("darkblue","blue","lightblue","white","yellow","red","darkred"))(n = 200)
myCol2 <-diverge_hcl(12,c=100,l=c(50,90),power=1)
myCol3<-colorspace::diverge_hsv
myCol4 <-colorRampPalette(c("darkblue","blue","lightblue","yellow","red","darkred"))(n = 200)
##myCol <-colorRampPalette(c("Grey","white","black"))(n = 200)
tiff("delet17.png",units="in",width=20,height=20,res=600)

#svg(filename="Std_SVG.svg",width=20,height=80,pointsize=12)

heatmap.2(data.m,col= myCol4,dendrogram ="row",trace='none',Colv=FALSE, keysize = 0.5)
dev.off()

#hm<-heatmap.2(data.m,col= myCol,dendrogram ="row",trace='none',keysize = 0.5)
#backEnd_data<-data.m[rev(hm$rowInd), hm$colInd]

#write.table(backEnd_data,file="backEnd_DBP_thalamus_PTM_ASOPvalues_4_0.25_0.05_100118_scaled.txt",sep=",")
