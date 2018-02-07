#We start with importing the data from the data set

StudentKnowledgeData <- read_csv("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/1/StudentKnowledgeData.csv")
View(StudentKnowledgeData)

#Making the copy of the data without disturbing the original data

a1<-StudentKnowledgeData

#Look at the summary of the data in order to scale the data if required
summary(a1)

#Look at the histograms of the data columns so as to check the distribution of the data
hist(a1$STG)
hist(a1$SCG)
hist(a1$STR)
hist(a1$LPR)
hist(a1$PEG)

#Check the correlation of the columns so as to pick the 2 points that are least correlated values
c<-cor(a1)
corrplot::corrplot(c,method = "circle")

#Develop a k-means model
#Check the plots of the data distribution

kskd <- kmeans(a1,2)
plot(a1,col=kskd$cluster)

#Repeat the process for different values of k

kskd <- kmeans(a1,3)
plot(a1[,c(3,5)],col=kskd$cluster)
kskd <- kmeans(a1,4)
plot(a1[,c(4,5)],col=kskd$cluster)
kskd <- kmeans(a1,5)
plot(a1[,c(4,5)],col=kskd$cluster)
kskd <- kmeans(a1,6)
plot(a1[,c(4,5)],col=kskd$cluster)

#Choose the best fit of k for the data
kskd <- kmeans(a1,2)
plot(a1[,c(4,5)],col=kskd$cluster)

kskd
kskd$totss
kskd$withinss
kskd$tot.withinss
kskd$betweenss

k.max <- 15
wss <- sapply(1:k.max, 
              function(k){kmeans(a1, k, nstart=10 )$tot.withinss})
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
abline(v = 5, lty =2)

