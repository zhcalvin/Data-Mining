GDP = subset(Data,select = c(Code,GDP_PC))

barplot(t(as.matrix(GDP)),main = "GDP Per Capita",xlab = "Province Code",ylab="GDP Per Capita")


source("MINE.r")

pro = proc.time()

MINE("2012_ToBeijing.csv",0)

pos = proc.time()



#q202:
D12 = read.csv(file = "2012utf.csv")
q202 = subset(D12,select=(c(q202)))
q202type = subset(q202,q202 == 1)
nrow(q202type)
q202type = subset(q202,q202 == 2)
nrow(q202type)
q202type = subset(q202,q202 == 3)
nrow(q202type)
q202type = subset(q202,q202 == 4)
nrow(q202type)
q202type = subset(q202,q202 == 5)
nrow(q202type)