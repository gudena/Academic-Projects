winequality_white <- read_delim("C:/Dileep/DataScience MS at UTD/Spring 2017/R/Assignments/2/winequality-white.csv",
";", escape_double = FALSE, trim_ws = TRUE)
View(winequality_white)
a2<- winequality_white
a2_copy <- winequality_white
a2<-a2[-12]
a2_copy[,12] = ifelse(a2_copy[,12]<=2,1, ifelse(a2_copy[,12]<=5,2,ifelse(a2_copy[,12]<=8,3,4)))
pca_a2=prcomp(a2,scale. = TRUE,center = TRUE)
biplot(pca_a2,cex=c(1/2,3/4),scale = 0)
plot(pca_a2)
pca_a2$sdev
pca_a2$x
km_pca_a2=kmeans(pca_a2$x[,1:3],3)
km_pca_a2
pve_a2=pca_a2.var/sum(pca_a2.var)
pve_a2
pca_a2.var=pca_a2$sdev^2
pca_a2.var
plot(cumsum (pve_a2 ), xlab=" Principal Component ", ylab ="
Cumulative Proportion of Variance Explained ", ylim=c(0,1) ,
type='b')
table(a2_copy$quality,km_pca_a2$cluster)
pca_a2.scaled = scale(pca_a2$x[,1:3])
pca_a2.ward = hclust(dist(pca_a2.scaled), method="ward.D2")
plot(pca_a2.ward,main="Ward Linkage", xlab="", sub="", cex=.9)
cutree(pca_arrests.ward,4)
