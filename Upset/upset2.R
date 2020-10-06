library(UpSetR)
library(ggplotify)


myData1 <- read.csv("Endosperm_merged_trinityEdited_count_upset.txt",sep="\t",header=TRUE)
myData2 <- read.csv("FemaleFlower_merged_count_upset.txt",sep="\t",header=TRUE)
myData3 <- read.csv("Leaf_merged_count_upset.txt",sep="\t",header=TRUE)
myData4 <- read.csv("MaleFlower_merged_count_upset.txt",sep="\t",header=TRUE)


upset(myData1,keep.order = F, sets = c("CGD_Endosperm","CGD_RESISTANT_LEAF","CGD_SUSCEPTIBLE_LEAF","LEAF","WCT_CALLUS"), sets.bar.color = c("darkgreen"),
      att.color = c("red"),matrix.color="darkgreen",
      order.by = "freq", empty.intersections = "on",point.size = 5,line.size=1,text.scale=1.5)
upset(myData2,keep.order = F, sets = c("CGD_Endosperm","CGD_RESISTANT_LEAF","CGD_SUSCEPTIBLE_LEAF","LEAF","WCT_CALLUS"), sets.bar.color = c("darkgreen"),
      att.color = c("red"),matrix.color="darkgreen",
      order.by = "freq", empty.intersections = "on",point.size = 5,line.size=1,text.scale=1.5)
upset(myData3,keep.order = F, sets = c("CGD_Endosperm","CGD_RESISTANT_LEAF","CGD_SUSCEPTIBLE_LEAF","LEAF","WCT_CALLUS"), sets.bar.color = c("darkgreen"),
      att.color = c("red"),matrix.color="darkgreen",
      order.by = "freq", empty.intersections = "on",point.size = 5,line.size=1,text.scale=1.5)
upset(myData4,keep.order = F, sets = c("CGD_Endosperm","CGD_RESISTANT_LEAF","CGD_SUSCEPTIBLE_LEAF","LEAF","WCT_CALLUS"), sets.bar.color = c("darkgreen"),
      att.color = c("red"),matrix.color="darkgreen",
      order.by = "freq", empty.intersections = "on",point.size = 5,line.size=1,text.scale=1.5)


par(mfrow = c(2, 2))
p1
p2
p3
p4
