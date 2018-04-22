#res <- read.table("", header=TRUE)

res <- read.delim(file = "Urine_4plex_pValuesFC.txt",header = TRUE,sep = '\t')
#res<- read.csv("Urine_4plex_pValuesFC.txt",sep="\t",header = TRUE, row.names = 1)
head(res)

# Make a basic volcano plot
with(res, plot(log2(fc), -log10(pValue), pch=20, main="Volcano plot", xlim=c(-4.0,4.0)))

# Add colored points: red if padj<0.05, orange of log2FC>1, green if both)
#with(subset(res, -log10(pvalue)>1.3), points(log2(foldChage), -log10(pvalue), pch=20, col="orange"))
#with(subset(res, abs(log2(foldChage))> 1), points(log2(foldChage), -log10(pvalue), pch=20, col="red"))
#with(subset(res, -log10(pvalue) > 1.3 & abs(log2(foldChage))>1), points(log2(foldChage), -log10(pvalue), pch=20, col="green"))
with(subset(res, -log10(pValue) > 1.0 & log2(fc)>1.0), points(log2(fc), -log10(pValue), pch=25, col="green"))
with(subset(res, -log10(pValue) > 1.0 & log2(fc)<(-1.0)), points(log2(fc), -log10(pValue), pch=25, col="red"))
abline(h = 1.0, col = "blue", lty = 2, lwd = 1)
abline(v = c(-1.0,1.0), col = "blue", lty = 2, lwd = 1)

# Label points with the textxy function from the calibrate plot
library(calibrate)
with(subset(res, -log10(pValue) > 1 & log2(fc)>1.0), textxy(log2(fc), -log10(pValue), labs=Gene, cex=0.8, pos=4))
with(subset(res, -log10(pValue) > 1 & log2(fc)<(-1.0)), textxy(log2(fc), -log10(pValue), labs=Gene, cex=0.8, pos=2))
