library('Rtsne')
## Read the comma-separated file with the "label" column for group, here it contains additional label as "Age"
train<- read.csv(file.choose())
Labels<-train$label
train$label<-as.factor(train$label)
colors = rainbow(length(unique(train$label)))
names(colors) = unique(train$label)
## Select perplexity based on the row number (perplexity*3 < rownumber-1)
tsne <- Rtsne(train[,c(-1,-2)], dims = 2, perplexity=11, verbose=TRUE, max_iter = 1000)
exeTimeTsne<- system.time(Rtsne(train[,c(-1,-2)], dims = 2, perplexity=11, verbose=TRUE, max_iter = 1000))

## Plot type 1
#tsne$Y
#plot(tsne$Y, t='n', main="tSNE")
#text(tsne$Y, labels=train$Age, col=colors[train$label])
#train$Age

## Plot type 2
plot(tsne$Y,main="tSNE",pch=19,col=colors[train$label],cex=2.0)
text(tsne$Y, labels=train$Age,pos=1)
