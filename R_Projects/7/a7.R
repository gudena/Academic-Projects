default_of_credit_card_clients <- read_csv("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/7/default of credit card clients.csv")
View(default_of_credit_card_clients)
mydata = default_of_credit_card_clients
summary(mydata)
mydata[1]=NULL
mydata$target=as.factor(mydata$target)
#qda
library(corrplot)
c=cor(mydata[-24])
corrplot(c)

train = sample(30000,24000)
credit.qda = qda(target~ .-BILL_AMT2 -BILL_AMT3 -BILL_AMT4 -BILL_AMT5 -BILL_AMT6
                 -PAY_2 -PAY_3 -PAY_5 -PAY_6, data= mydata, subset = train)
credit.qda.pred=predict(credit.qda,mydata[-train,])
table(credit.qda.pred$class,mydata[-train,]$target)
mean(credit.qda.pred$class==mydata[-train,]$target)

#lda
mydata$SEX=as.factor(mydata$SEX)
mydata$MARRIAGE=as.factor(mydata$MARRIAGE)
mydata$EDUCATION=ifelse(mydata$EDUCATION == 5,4,mydata$EDUCATION)
mydata$EDUCATION=ifelse(mydata$EDUCATION == 6,4,mydata$EDUCATION)
mydata$EDUCATION=as.factor(mydata$EDUCATION)

dim(mydata)
library("MASS", lib.loc="~/R/win-library/3.3")
credit.lda = lda(target~ ., data= mydata)
credit.lda
train = sample(30000,24000)
credit.lda = lda(target~ ., data= mydata, subset = train)
credit.lda
credit.pred=predict(credit.lda,mydata[-train,])
table(credit.pred$class,mydata[-train,]$target)
mean(credit.pred$class==mydata[-train,]$target)
library(corrplot)
c=cor(mydata[-24])
corrplot(c)
credit.qda = qda(target~ .-BILL_AMT2 -BILL_AMT3 -BILL_AMT4 -BILL_AMT5 -BILL_AMT6
                 -PAY_2 -PAY_3 -PAY_5 -PAY_6, data= mydata, subset = train)
credit.qda.pred=predict(credit.qda,mydata[-train,])
table(credit.qda.pred$class,mydata[-train,]$target)
mean(credit.qda.pred$class==mydata[-train,]$target)

library(e1071)

NB_Model<-naiveBayes(target~.,data=mydata,subset = train, laplace=1)
nb.pred	<- predict(NB_Model,	mydata[-train,])
nb.pred
table(nb.pred,	mydata[-train,]$target)
mean(nb.pred==mydata[-train,]$target)
