AmesHousing <- read_delim("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/mid-term/Ames Housing/Ames Housing/AmesHousing.txt",
                          "\t", escape_double = FALSE, trim_ws = TRUE)
View(AmesHousing)
midData<-AmesHousing
summary(midData)
dim(midData)
midData=as.data.frame(unclass(midData))
summary(midData)
dim(midData)
midData$Order=NULL
summary(midData)
midData$PID=NULL
summary(midData)
midData$Misc.Feature=NULL
summary(midData)
midData$Fence=NULL
summary(midData)
midData$Pool.QC=NULL
summary(midData)
midData$Fireplace.Qu=NULL
summary(midData)
dim(midData)
midData$Sale.Condition=NULL
summary(midData)
midData$Sale.Type=NULL
summary(midData)
midData$Misc.Val=NULL
summary(midData)
midData$Pool.Area=NULL
summary(midData)
midData$Screen.Porch=NULL
summary(midData)
midData$X3Ssn.Porch=NULL
summary(midData)
midData$Enclosed.Porch=NULL
summary(midData)
midData$Wood.Deck.SF=NULL
summary(midData)
midData$Paved.Drive=NULL
summary(midData)
midData$Garage.Cond=NULL
summary(midData)
midData$Garage.Qual=NULL
summary(midData)
midData$Functional=NULL
summary(midData)
midData$Bsmt.Half.Bath=NULL
summary(midData)
midData$Low.Qual.Fin.SF=NULL
summary(midData)
midData$X2nd.Flr.SF=NULL
summary(midData)
midData$Electrical=NULL
summary(midData)
midData$Central.Air=NULL
summary(midData)
midData$Heating=NULL
summary(midData)
midData$BsmtFin.SF.2=NULL
summary(midData)
midData$BsmtFin.Type.2=NULL
summary(midData)
midData$Bsmt.Cond=NULL
summary(midData)
midData$Exter.Cond=NULL
summary(midData)
midData$Mas.Vnr.Area=NULL
summary(midData)
midData$Roof.Matl=NULL
summary(midData)
midData$Roof.Style=NULL
summary(midData)
midData$Bldg.Type=NULL
summary(midData)
midData$Condition.2=NULL
summary(midData)
midData$Condition.1=NULL
summary(midData)
midData$Land.Slope=NULL
summary(midData)
midData$Utilities=NULL
summary(midData)
midData$Land.Contour=NULL
summary(midData)
midData$Alley=NULL
summary(midData)
midData$Street=NULL
summary(midData)
midData$Lot.Config=NULL
summary(midData)
midData$MS.Zoning=NULL
summary(midData)
dim(midData)
midData=na.omit(midData)
summary(midData)
midData$Overall.Cond=as.factor(midData$Overall.Cond)
summary(midData)
midData$Overall.Qual=as.factor(midData$Overall.Qual)
summary(midData)
midData$Bsmt.Full.Bath=as.factor(midData$Bsmt.Full.Bath)
summary(midData)
midData$Full.Bath=as.factor(midData$Full.Bath)
summary(midData)
midData$Half.Bath=as.factor(midData$Half.Bath)
summary(midData)
midData$Bedroom.AbvGr=as.factor(midData$Bedroom.AbvGr)
summary(midData)
midData$Kitchen.AbvGr=as.factor(midData$Kitchen.AbvGr)
summary(midData)
midData$Kitchen.AbvGr=NULL
summary(midData)
midData$Fireplaces=as.factor(midData$Fireplaces)
summary(midData)
midData$Garage.Cars=as.factor(midData$Garage.Cars)
summary(midData)
midData$Yr.Sold=as.factor(midData$Yr.Sold)
midData1=midData
for(j in 1:ncol(midData)){
  if(class(midData[,j])=="factor")
    midData1[,j]=as.numeric(midData[,j])
}
summary(midData1)
c= cor(midData1)
plot(c)
summary(midData)
dim(midData1)
midData=midData1[midData1$Gr.Liv.Area<4000,]
fold=10
id <- sample(1:fold, nrow(myData), replace = TRUE);
list <- 1:fold;
MSE.gam=0;
gam.error=0
MSE.lr = 0
lr.error = 0
for (i in 1:fold)
{
  training<- subset(midData, id %in% list[-i])
  test <- subset(midData, id %in% c(i))
#train2 = sample(1:nrow(midData), nrow(midData)*0.8)
#test2 = -train2
#training_Data2 = midData[train2,]
#testing_Data2 = midData[test2,]
  gam.fit.midterm = gam(SalePrice~.,data=training)
  test.pred.gam=predict(gam.fit.midterm,newdata = test[-40])
  MSE.gam = MSE.gam + mean((test.pred.gam-test[40])^2)
  gam.error = gam.error + sqrt(mean((test.pred.gam-test[40])^2))/mean(test[,40])
  lr.midterm.model = lm(SalePrice~., data = training)
  test.pred.lr = predict(lr.midterm.model,test[-40])
  MSE.lr = MSE.lr + mean((test.pred.lr-test[40])^2)
  lr.error = lr.error + sqrt(mean((test.pred.lr-test[40])^2))/mean(test[,40])
}
gam.error/fold
lr.error/fold
lr.midterm.model = lm(SalePrice~., data = training_Data2)
test.pred.lr = predict(lr.midterm.model,testing_Data2[-40])
summary(lr.midterm.model)
MSE.midterm.lr=mean((test.pred.lr-testing_Data2[40])^2)
MSE.midterm.lr
lr.error = sqrt(MSE.midterm.lr)
lr.error
errorpercent=100*lr.error/mean(testing_Data2[,40])
errorpercent
