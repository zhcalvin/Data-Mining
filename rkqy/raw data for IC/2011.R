setwd("~/Documents/AI/Proj/rkqy/raw data for IC")

install.packages("rJava") # 1-time initialization step
source("MINE.r")

pro = proc.time()

MINE("2012CombData.csv",3)

pos = proc.time()

D11 = read.csv("2013_wc.csv",header=TRUE,sep=",")
