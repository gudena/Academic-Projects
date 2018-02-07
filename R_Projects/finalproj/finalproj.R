#Preprocessing
#Join Columns of test files

ticeval2000 <- read_delim("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/finalproj/ticeval2000.txt",
"\t", escape_double = FALSE, col_names = FALSE,
trim_ws = TRUE)
View(ticeval2000)

ticdata2000 <- read_delim("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/finalproj/ticdata2000.txt",
"\t", escape_double = FALSE, col_names = FALSE,
trim_ws = TRUE)
View(ticdata2000)

tictgts2000 <- read_csv("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/finalproj/tictgts2000.txt",
col_names = FALSE)
View(tictgts2000)


ticcompl <- cbind(ticeval2000,tictgts2000)

#Rename Last Column
colnames(ticcompl)[86] <- "X86"

#Combine train & test data
ticcompl <- rbind(ticdata2000,ticcompl)

#Rename columns
names(ticcompl)  <- c("MOSTYPE",
                      "MAANTHUI", 
                      "MGEMOMV", 
                      "MGEMLEEF", 
                      "MOSHOOFD", 
                      "MGODRK",
                      "MGODPR", 
                      "MGODOV", 
                      "MGODGE", 
                      "MRELGE", 
                      "MRELSA", 
                      "MRELOV", 
                      "MFALLEEN", 
                      "MFGEKIND", 
                      "MFWEKIND", 
                      "MOPLHOOG", 
                      "MOPLMIDD", 
                      "MOPLLAAG", 
                      "MBERHOOG", 
                      "MBERZELF", 
                      "MBERBOER", 
                      "MBERMIDD", 
                      "MBERARBG", 
                      "MBERARBO", 
                      "MSKA", 
                      "MSKB1", 
                      "MSKB2", 
                      "MSKC", 
                      "MSKD", 
                      "MHHUUR", 
                      "MHKOOP", 
                      "MAUT1", 
                      "MAUT2", 
                      "MAUT0", 
                      "MZFONDS", 
                      "MZPART", 
                      "MINKM30", 
                      "MINK3045", 
                      "MINK4575",
                      "MINK7512", 
                      "MINK123M",
                      "MINKGEM", 
                      "MKOOPKLA", 
                      "PWAPART", 
                      "PWABEDR", 
                      "PWALAND", 
                      "PPERSAUT", 
                      "PBESAUT", 
                      "PMOTSCO", 
                      "PVRAAUT", 
                      "PAANHANG", 
                      "PTRACTOR", 
                      "PWERKT", 
                      "PBROM", 
                      "PLEVEN", 
                      "PPERSONG", 
                      "PGEZONG",
                      "PWAOREG",
                      "PBRAND", 
                      "PZEILPL", 
                      "PPLEZIER", 
                      "PFIETS", 
                      "PINBOED", 
                      "PBYSTAND", 
                      "AWAPART", 
                      "AWABEDR", 
                      "AWALAND", 
                      "APERSAUT", 
                      "ABESAUT", 
                      "AMOTSCO", 
                      "AVRAAUT", 
                      "AAANHANG", 
                      "ATRACTOR",
                      "AWERKT", 
                      "ABROM", 
                      "ALEVEN", 
                      "APERSONG", 
                      "AGEZONG", 
                      "AWAOREG", 
                      "ABRAND", 
                      "AZEILPL", 
                      "APLEZIER", 
                      "AFIETS", 
                      "AINBOED", 
                      "ABYSTAND", 
                      "CARAVAN")
library(caret)

#Identify near zero variance predictors 
nearZeroVar(ticcompl, names = TRUE, freqCut = 95/5, uniqueCut = 10)

#Remove such predictors 
ticcompl$PWABEDR = NULL
ticcompl$PWALAND = NULL
ticcompl$PBESAUT = NULL
ticcompl$PMOTSCO = NULL
ticcompl$PVRAAUT = NULL
ticcompl$PAANHANG = NULL
ticcompl$PTRACTOR = NULL
ticcompl$PWERKT = NULL
ticcompl$PBROM = NULL
ticcompl$PLEVEN = NULL
ticcompl$PPERSONG = NULL
ticcompl$PGEZONG = NULL
ticcompl$PWAOREG = NULL
ticcompl$PZEILPL = NULL
ticcompl$PPLEZIER = NULL
ticcompl$PFIETS = NULL
ticcompl$PINBOED = NULL
ticcompl$PBYSTAND = NULL
ticcompl$AWABEDR = NULL
ticcompl$AWALAND = NULL
ticcompl$ABESAUT = NULL
ticcompl$AMOTSCO = NULL
ticcompl$AVRAAUT = NULL
ticcompl$AAANHANG = NULL
ticcompl$ATRACTOR = NULL
ticcompl$AWERKT = NULL
ticcompl$ALEVEN = NULL
ticcompl$APERSONG = NULL
ticcompl$AGEZONG = NULL
ticcompl$AWAOREG = NULL
ticcompl$AZEILPL = NULL
ticcompl$APLEZIER = NULL
ticcompl$AFIETS = NULL
ticcompl$AINBOED = NULL
ticcompl$ABYSTAND = NULL

#Convert into data frame
ticcompl <- as.data.frame(ticcompl)
summary(ticcompl)
dim(ticcompl)

summary(ticcompl)
dim(ticcompl)

ticcompl = na.omit(ticcompl)

summary(ticcompl)
dim(ticcompl)

ticcompl$MAANTHUI=NULL
ticcompl$MINK123M=NULL
ticcompl$ABROM=NULL


ticcompl$MAUT2 <- ifelse(ticcompl$MAUT2>4,4, ticcompl$MAUT2)
ticcompl$PWAPART <- ifelse(ticcompl$PWAPART==3,1, ticcompl$PWAPART)
ticcompl$ABRAND <- ifelse(ticcompl$ABRAND>2,2, ticcompl$ABRAND)
ticcompl$APERSAUT <- ifelse(ticcompl$APERSAUT>2,2, ticcompl$APERSAUT)
ticcompl$AWAPART <- ifelse(ticcompl$AWAPART==2,1, ticcompl$AWAPART)
ticcompl$PPERSAUT <- ifelse(ticcompl$PPERSAUT>6,7, ticcompl$PPERSAUT)
ticcompl$MINK7512 <- ifelse(ticcompl$MINK7512>4,4, ticcompl$MINK7512)
ticcompl$MSKD <- ifelse(ticcompl$MSKD>5,5, ticcompl$MSKD)
ticcompl$MSKB1 <- ifelse(ticcompl$MSKB1>5,5, ticcompl$MSKB1)
ticcompl$MBERZELF <- ifelse(ticcompl$MBERZELF>2,5, ticcompl$MBERZELF)
ticcompl$MBERBOER <- ifelse(ticcompl$MBERBOER>5,5, ticcompl$MBERBOER)
ticcompl$MRELSA <- ifelse(ticcompl$MRELSA>4,4, ticcompl$MRELSA)
ticcompl$MGODOV <- ifelse(ticcompl$MGODOV==5,4, ticcompl$MGODOV)
ticcompl$MGODRK <- ifelse(ticcompl$MGODRK>5,5, ticcompl$MGODRK)
ticcompl$MGEMLEEF <- ifelse(ticcompl$MGEMLEEF==6,1, ticcompl$MGEMLEEF)
ticcompl$MGEMOMV <- ifelse(ticcompl$MGEMOMV>5,1, ticcompl$MGEMOMV)

# Convert categorical data into factors
ix <- 1:48
ticcompl[ix] <- lapply(ticcompl[ix], as.factor) 

summary(ticcompl)
dim(ticcompl)
#Split training & test data
train <- ticcompl[1:5822,]
test <- ticcompl[-(1:5822),]

library(randomForest)

#Random Forest
rf.model = randomForest(CARAVAN~., data= train,mtry=3, importance=TRUE)
rf.pred = predict(rf.model,test,type="class")
table(test$CARAVAN,rf.pred)
mean(rf.pred == test$CARAVAN)

library(e1071)

#SVM
svm.lin = svm(CARAVAN~., data=train, kernel = "linear", cost=10,tolerance=0.01)
svm.lin.pred = predict(svm.lin,test)
table(test$CARAVAN,svm.lin.pred)
mean(svm.lin.pred == test$CARAVAN)


#LR
lr.final.model = lm(CARAVAN~., data = train)
test.pred.lr = predict(lr.final.model,test[-48])
test.pred.lr
