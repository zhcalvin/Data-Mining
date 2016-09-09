setwd("~/Documents/AI/Proj/rkqy/raw data for IC")

D11 = read.csv("2011_utf.csv")

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2011Data.csv")
Dis = read.csv("Distances.csv")

GDP = subset(Data,select = c(Code,GDP_PC))


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
 from = subset(D11,Q101E1 == x[i])
 from = subset(from, select = c(Q101E1,ProCODE))
 from = na.omit(from)
 for (j in 1:31){ #to
   if(i == j){
   }
   else{
     to = subset(from,ProCODE == x[j])
     fromCode = x[i]
     toCode = x[j]
     rate = nrow(to) / nrow(from)
     amount = nrow(to)
     
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

write.csv(combData,"2011CombData.csv")


#MINE

install.packages("rJava") # 1-time initialization step
source("MINE.r")

pro = proc.time()

MINE("2011CombData.csv",3)

pos = proc.time()


#跨省流动与否
D11 = read.csv("2011_utf.csv")
Data = read.csv("2011Data.csv")
name = read.csv("provinces.csv")
innRate = array();
outRate = array(); #外省迁入人口率
totalnum = array();
x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
for (i in 1:31){
  migration = subset(D11,select = c(Q101E1, Q101I1))
  migration = subset(migration, Q101E1 == x[i])
  out = subset(migration, Q101I1 == 1)
  inn = subset(migration, Q101I1 == 2 | Q101I1 == 3)
  outRate[i] = nrow(out) / (Data$Population[i] * 10000)
  innRate[i] = (nrow(inn)) / (Data$Population[i] * 10000)
  migration = subset(D11, ProCODE == x[i])
  totalnum[i] = nrow(migration)
}
output = data.frame(name$eng,x[1:31],innRate,outRate)

write.csv(output,'innOut.csv')


#2011Inter Comb Data:
D11 = read.csv("2011_utf.csv")

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2010Data.csv")
Dis = read.csv("Distances.csv")

GDP = subset(Data,select = c(Code,GDP_PC))
DataY = read.csv("2010DataY.csv")
Area = read.csv("area.csv")

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
  tmpFrom = subset(D11,Q101E1 == x[i])
  from = subset(tmpFrom, Q101I1 == 1)
  from = subset(from, select = c(Q101E1,ProCODE))
  from = na.omit(from)
  for (j in 1:31){ #to
    if(i == j){
    }
    else{
      to = subset(from, ProCODE == x[j])
      fromCode = x[i]
      toCode = x[j]
      rate = nrow(to) / Data$Population[i]
      amount = nrow(to)
      
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
      areaX = Area$area[i];
      areaY = Area$area[j];
      tmp = data.frame(fromCode,toCode,rate,dis,orgGDP,amount,areaX,areaY)
      tmp = merge(tmp, Data,by.x = ("toCode"),by.y = ("Code"))
      #tmp = merge(tmp, DataY,by.x = ("fromCode"),by.y = ("Code"))
      combData = rbind(combData,tmp)
    }
  }
}

write.csv(combData,"2011InterCombData.csv")

#2011 Inner
D11 = read.csv("2011_utf.csv")

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2010Data.csv")

Dis = read.csv("Distances.csv")

Area = read.csv("area.csv")

GDP = subset(Data,select = c(Code,GDP_PC))


#Initialization
fromCode = c()
toCode = c()
rate = NULL
dis = NULL
orgGDP = NULL
amount = NULL
combData = data.frame(fromCode,toCode,rate,orgGDP,amount,amount)
#Where to go
for (i in 1:31){ #from
  tmpFrom = subset(D11,Q101E1 == x[i])
  from = subset(tmpFrom, Q101I1 == 2 | Q101I1 == 3)
  from = subset(from, select = c(Q101E1,ProCODE))
  from = na.omit(from)
  for (j in 1:31){ #to
    if(i == j){
      to = subset(from, ProCODE == x[j])
      fromCode = x[i]
      toCode = x[j]
      rate = nrow(to) / Data$Population[i]
      amount = nrow(to)
      
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
      area = Area$area[i]
      tmp = data.frame(fromCode,toCode,rate,orgGDP,amount,area)
      tmp = merge(tmp, Data,by.x = ("toCode"),by.y = ("Code"))
      combData = rbind(combData,tmp)
    }
    else{
      
    }
  }
}

write.csv(combData,"2011InnerCombData.csv")


