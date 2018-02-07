#Read the dataset
default_of_credit_card_clients <- read_csv("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/7/default of credit card clients.csv")
View(default_of_credit_card_clients)
myData <- default_of_credit_card_clients
#Removing the redundant columns from data
summary(myData)
dim(myData)
myData <- myData[-c(1,8,9,11,12,14,15,16,17,18)]

summary(myData)
dim(myData)
myData[,3] <- ifelse(myData[,3]==5,4, myData[,3])
myData[,3] <- ifelse(myData[,3]==6,4, myData[,3])

#Correlation plot
library(corrplot)
p <- cor(myData)
corrplot(p,method = "circle")

#RandomForest
#install.packages("randomForest")
library(randomForest)
set.seed(9)
myData1  <- sample(30000,18000);
myData1 = myData[myData1,]

myData1$target=as.factor(myData1$target)
summary(myData1)

myData1Train = sample(18000,15000)

rfModel <- randomForest(target~., myData1, subset = myData1Train,ntree=100, mtry= 12, importance = FALSE, proximity = TRUE);
predRandomForestTesting <- predict(rfModel, myData1[-myData1Train,]);
TestAccuracy = mean(predRandomForestTesting == myData1[-myData1Train,]$target)

print("Accuracy:")
TestAccuracy

plot(rfModel, log = "y")
importance(rfModel)

#Bagging
bagModel = randomForest(target~., myData1, subset = myData1Train, mtry= 2, importance = FALSE, proximity = TRUE);
predBag = predict(bagModel,myData1[-myData1Train,])
Accuracy = mean(predBag==myData1[-myData1Train,]$target)
Accuracy

