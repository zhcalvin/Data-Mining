D12 = read.csv(file = "2013utf.csv")[,c("q101h1","q101j1")]
Data = read.csv("2011Data.csv")
name = read.csv("provinces.csv")
innRate = array();
outRate = array(); #外省迁入人口率
totalnum = array();
x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
for (i in 1:31){
  #migration = subset(D12,select = c(procode, q101i1))
  migration = subset(D12, q101h1 == x[i])
  out = subset(migration, q101j1 == 1)
  inn = subset(migration, q101j1 == 2 | q101j1 == 3)
  outRate[i] = nrow(out) / Data$Population[i]
  innRate[i] = (nrow(inn)) /Data$Population[i]
}
output = data.frame(name$eng,x[1:31],innRate,outRate)

write.csv(output,'innOut13.csv')

D12 = read.csv(file = "2013utf.csv")
totalnum = array();
for(i in 1:31){
  migration = subset(D12, pcode == x[i])
  totalnum[i] = nrow(migration)
}