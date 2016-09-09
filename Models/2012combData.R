
D12 = read.csv(file = "2012utf.csv")[,c("procode","q101d1")]

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2010-2014.csv")
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

write.csv(combData,"2014CombData.csv")


source("MINE.r")

MINE("2014CombData.csv",3)
