library(GOplot)

data<-read.csv("InputMatrix.txt", header=TRUE, row.names=1, sep = "\t")
data.m<-as.matrix(data)

tiff("GOChord.png",units="in",width=8,height=8,res=300)
GOChord(data.m, space = 0.02, gene.order = 'logFC', gene.space = 0.2, gene.size = 3)
dev.off()
