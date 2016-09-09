D12 = read.csv(file = "2012utf.csv")[,c("procode","q101d1")]

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2011Data.csv")
Dis = read.csv("Distances.csv")

GDP = subset(Data,select = c(Code,GDP_PC))

Henan = data.frame(toCode,rate, amount)

#Initialization
fromCode = c()
toCode = c()
rate = NULL
dis = NULL
orgGDP = NULL
amount = NULL
combData = data.frame(fromCode,toCode,rate,dis,orgGDP,amount)
#Where to go
for (i in 1:31){ #from
  from = subset(D12,q101d1 == x[i])
  from = na.omit(from)
  for (j in 1:31){ #to
    if(i == j){
    }
    else{
      to = subset(from,procode == x[j])
      fromCode = x[i]
      toCode = x[j]
      rate = nrow(to) / nrow(from)
      amount = nrow(to)
      
      if(from[2] == 41){
        tmp = data.frame(toCode,rate, amount)
        Henan = rbind(Henan,tmp)
      }
      
      #Retrieve loc in Dis Dataframe
      for(k1 in 1:31){
        if(x[i] == DisCode[k1]){
          break;
        }
      }
      for(k2 in 1:31){
        if(x[j] == DisCode[k2]){
          break;
        }
      }
      #Retriving end
      
      dis = Dis[k1,k2+1]
      orgGDP = GDP[which(GDP$Code==fromCode),2]
      tmp = NULL
      tmp = data.frame(fromCode,toCode,rate,dis,orgGDP,amount)
      tmp = merge(tmp, Data,by.x = ("toCode"),by.y = ("Code"))
      combData = rbind(combData,tmp)
    }
  }
}

write.csv(combData,"2012CombData.csv")

write.csv(Henan,"2012fromHenan.csv")

#correlation

source("MINE.r")

MINE("2011Data.csv",6)


#inner out
D12 = read.csv(file = "2012utf.csv")
subD12 = subset(D12, select = c(q101d1, q101k1))
Data = read.csv("2011Data.csv")
name = read.csv("provinces.csv")
innRate = array();
outRate = array(); #外省迁入人口率
totalnum = array();
x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
for (i in 1:31){
  migration = subset(subD12, q101d1 == x[i])
  out = subset(migration, q101k1 == 1)
  inn = subset(migration, q101k1 == 2 | q101k1 == 3)
  outRate[i] = nrow(out) / Data$Population[i]
  innRate[i] = (nrow(inn)) /Data$Population[i]
  migration = subset(D12, procode == x[i])
  totalnum[i] = nrow(migration)
}
output = data.frame(name$eng,x[1:31],innRate,outRate)

write.csv(output,'innOut12.csv')

#Inter
D12 = read.csv(file = "2012utf.csv")

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2011Data.csv")
Dis = read.csv("Distances.csv")
DataY = read.csv("DataY.csv")

Area = read.csv("area.csv")


GDP = subset(Data,select = c(Code,GDP_PC))

Henan = data.frame(toCode,rate, amount)

#Initialization
fromCode = c()
toCode = c()
rate = NULL
dis = NULL
orgGDP = NULL
amount = NULL
combData = data.frame(fromCode,toCode,rate,dis,orgGDP,amount)
#Where to go
for (i in 1:19){ #from
  from = subset(D12,q101d1 == x[i])
  from = subset(from, q101k1 == 1)
  from = subset(from, select = c(procode, q101d1))
  from = na.omit(from)
  for (j in 1:31){ #to
    if(i == j){
    }
    else{
      to = subset(from,procode == x[j])
      fromCode = x[i]
      toCode = x[j]
      rate = nrow(to) / Data$Population[i]
      amount = nrow(to)
      
      if(from[2] == 41){
        tmp = data.frame(toCode,rate, amount)
        Henan = rbind(Henan,tmp)
      }
      
      #Retrieve loc in Dis Dataframe
      for(k1 in 1:31){
        if(x[i] == DisCode[k1]){
          break;
        }
      }
      for(k2 in 1:31){
        if(x[j] == DisCode[k2]){
          break;
        }
      }
      #Retriving end
      
      dis = Dis[k1,k2+1]
      orgGDP = GDP[which(GDP$Code==fromCode),2]
      areaX = Area$area[i];
      areaY = Area$area[j];
      tmp = NULL
      tmp = data.frame(fromCode,toCode,rate,dis,orgGDP,amount,areaX,areaY)
      tmp = merge(tmp, Data,by.x = ("toCode"),by.y = ("Code"))
      tmp = merge(tmp, DataY,by.x = ("fromCode"),by.y = ("Code"))
      combData = rbind(combData,tmp)
    }
  }
}

write.csv(combData,"2012InterCombData.csv")

#inner
D12 = read.csv(file = "2012utf.csv")

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2011Data.csv")
Dis = read.csv("Distances.csv")

Area = read.csv("area.csv")


GDP = subset(Data,select = c(Code,GDP_PC))
Area = read.csv("area.csv")

Henan = data.frame(toCode,rate, amount)

#Initialization
fromCode = c()
toCode = c()
rate = NULL
dis = NULL
orgGDP = NULL
amount = NULL
combData = data.frame(fromCode,toCode,rate,orgGDP,amount)
#Where to go
for (i in 1:19){ #from
  from = subset(D12,q101d1 == x[i])
  from = subset(from, q101k1 == 1)
  from = subset(from, select = c(procode, q101d1))
  from = na.omit(from)
  for (j in 1:31){ #to
    if(i == j){
      to = subset(from,procode == x[j])
      fromCode = x[i]
      toCode = x[j]
      rate = nrow(to) / Data$Population[i]
      amount = nrow(to)
      
      if(from[2] == 41){
        tmp = data.frame(toCode,rate, amount)
        Henan = rbind(Henan,tmp)
      }
      
      #Retrieve loc in Dis Dataframe
      for(k1 in 1:31){
        if(x[i] == DisCode[k1]){
          break;
        }
      }
      for(k2 in 1:31){
        if(x[j] == DisCode[k2]){
          break;
        }
      }
      #Retriving end
      
      dis = Dis[k1,k2+1]
      orgGDP = GDP[which(GDP$Code==fromCode),2]
      tmp = NULL
      areaX = Area$area[i]
      tmp = data.frame(fromCode,toCode,rate,orgGDP,amount,area)
      tmp = merge(tmp, Data,by.x = ("toCode"),by.y = ("Code"))
      combData = rbind(combData,tmp)
    }
    else{
     
    }
  }
}

write.csv(combData,"2012InnerCombData.csv")

