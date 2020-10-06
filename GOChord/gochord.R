library(GOplot)

data<-read.csv("chord.csv", header=TRUE, row.names=1)
data.m<-as.matrix(data)
data.m
GOChord(data.m, space = 0.02, gene.order = 'logFC', gene.space = 0.25, gene.size = 5)
