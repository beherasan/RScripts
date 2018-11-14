library(gplots)
library(RColorBrewer)
library(colorspace)

mat_val <- read.csv("Upregulated_genes.txt", sep="\t", header = T, row.names=1)
data.m <- as.matrix(mat_val)


#myCol <-colorRampPalette(c("red","orange", "yellow","green","blue","darkblue"))(n = 200)
#myCol <-colorRampPalette(c("khaki1","khaki2","yellow", "orange","red"))(n = 200)
#myCol <-colorRampPalette(c("darkblue","blue","lightblue","white","yellow","red","darkred"))(n = 200)
#myCol2 <-diverge_hcl(12,c=100,l=c(50,90),power=1)
#myCol3<-colorspace::diverge_hsv
myCol4 <-colorRampPalette(c("darkblue","blue","lightblue","yellow","red","darkred"))(n = 200)
##myCol <-colorRampPalette(c("Grey","white","black"))(n = 200)
tiff("delet18.png",units="in",width=20,height=20,res=900)

#svg(filename="Std_SVG.svg",width=20,height=80,pointsize=12)

heatmap.2(data.m,col= myCol4,dendrogram ="none",trace='none',Colv=FALSE, Rowv=FALSE,keysize = 0.5,
          #RowSideColors = c(rep("green",9),rep("red",11),rep("blue",29),rep("yellow",22)))
          RowSideColors = c(rep("green",16),rep("red",26),rep("blue",30),rep("yellow",11)))
dev.off()

#hm<-heatmap.2(data.m,col= myCol,dendrogram ="row",trace='none',keysize = 0.5)
#backEnd_data<-data.m[rev(hm$rowInd), hm$colInd]

#write.table(backEnd_data,file="backEnd_DBP_thalamus_PTM_ASOPvalues_4_0.25_0.05_100118_scaled.txt",sep=",")
