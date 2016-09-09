setwd("~/Documents/AI/Proj/rkqy/raw data for IC")

install.packages("rJava") # 1-time initialization step
source("MINE.r")

pro = proc.time()

MINE("2014incomech.csv","one.pair",0,1)

pos = proc.time()



D10 = read.csv("2010-1stH.csv")

directions=subset(D10, select=c(city,q101))

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
#Pair city with provinces:
from = data.frame();
for (i in 1:106){
  from[i] = subset(D10,city==i)
}

directions_2 = subset(D10,city==2)


directions_1 = subset(D10,city==1)

dir_1_q101_m=rep(0,34)
dir_1_q101_rate=rep(0,34)
# population
Pop = read.csv("GDP2010.csv")
Pop = subset(Pop,select = c(Code,Population))


for (i in 1:34){
  q101 = subset(directions_1,q101 == x[i])
  dir_1_q101_m[i] <- nrow(q101)
  dir_1_q101_rate[i] <- 10000*dir_1_q101_m[i]/Pop[i,2]
}

write.csv(dir_1_q101_rate,'tmp.csv')




#MINE
install.packages("rJava") # 1-time initialization step
source("MINE.r")

pro = proc.time()

MINE("Data_Beijing.csv",3)




#OLD
D10q101 = subset(D10,select=c(q101))

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
q101m = rep(0,34)
for (i in 1:34)
{
  q101 = subset(D10q101,q101 == x[i])
  q101m[i] <- nrow(q101)
}
barplot.default(q101m,names.arg=x,xlab="ProvinceNo.",ylab="ExamplesNo.",main="ExamplesinProvinces")

D10spend = subset(D10,select = c("Q103","Q105","Q106","Q106_1","Q106_2","Q107"))
D10SpendSum = rowSums(D10spend)
length(D10SpendSum)
summary(D10)
nrow(D10)

D10 = merge(D10,D10)

GDP10 = read.csv("GDP2010.csv")

summary(D10)

D10GDP10 = merge(D10)
