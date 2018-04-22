data<-read.csv("Urine_4plex.csv",sep=",",header=TRUE,row.names=1)
data.m<-as.matrix(data)
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
newC<-file("Urine_4plex_pValues.txt","a")
sink(newC)
for(i in 1:300){
  x<-c(data.m[i,1],data.m[i,2])
  #x<-log2(x)
  y<-c(data.m[i,3],data.m[i,4])
  #m<-data.m[i,1]+1
  n<-rownames(data.m)[i]
  #p<-t.test(x,y,alternative = "greater",mu=0,paired = TRUE)$p.value
  #all<-c(data.m[i,1],data.m[i,2],data.m[i,3],data.m[i,4])
  #line<-paste(all,"p-value",p,sep = "\t")
  #print(c(n,"p-value",t.test(x,y,alternative = "greater",mu=0,paired = TRUE)$p.value))
  #print(x)
  re<-my.p.value(x,y)
  print(c(n,re))
  #cat(x,y,"p-value",t.test(x,y,alternative = "greater",mu=0,paired = TRUE)$p.value,file=new1,append=TRUE,fill=FALSE)
  #print(y)
  #print(line)
  #writeLines(p,con=newC)  
}
close(newC)
