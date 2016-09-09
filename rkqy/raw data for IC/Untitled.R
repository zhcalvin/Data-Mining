setwd("~/Documents/AI/Proj/rkqy/raw data for IC")

D11 = read.csv("2011_utf.csv")

x = c(11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82)
DisCode = c(11,12,31,50,15,65,54,64,45,23,22,21,13,41,37,14,62,61,63,51,42,34,32,33,35,36,43,52,53,44,46)

Data = read.csv("2011Data.csv")
Dis = read.csv("Distances.csv")


#Initialization
fromCode = c()
toCode = c()
rate = NULL
dis = NULL
combData = data.frame(fromCode,toCode,rate,dis)
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
     tmp = data.frame(fromCode,toCode,rate,dis)
     tmp = merge(tmp, Data,by.x = ("fromCode"),by.y = ("Code"))
     combData = rbind(combData,tmp)
   }
 }
}

write.csv(combData,"2011CombData")
