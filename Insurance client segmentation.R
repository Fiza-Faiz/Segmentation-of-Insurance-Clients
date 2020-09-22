## R modeling: factor analysis and cluster analysis

getwd()
setwd("/businessAnalytics")

library(haven)
BENCAREF_JS3 <- read_sav("BENCAREF_JS3.sav")
head(BENCAREF_JS3)

BENCAREF_JS3 <- as.data.frame(BENCAREF_JS3)
BENCAREF_JS3_withoutna <- na.omit(BENCAREF_JS3)

## Factor Analysis
library(psych)

KCP <- data.frame(BENCAREF_JS3_withoutna$inter1, BENCAREF_JS3_withoutna$inter2, 
                  BENCAREF_JS3_withoutna$inter3, BENCAREF_JS3_withoutna$inter7, 
                  BENCAREF_JS3_withoutna$inter8, 11-BENCAREF_JS3_withoutna$inter9, 
                  BENCAREF_JS3_withoutna$inter13, BENCAREF_JS3_withoutna$inter14, 
                  BENCAREF_JS3_withoutna$inter15, BENCAREF_JS3_withoutna$inter16, 
                  BENCAREF_JS3_withoutna$val1, BENCAREF_JS3_withoutna$val2, 
                  BENCAREF_JS3_withoutna$val3, BENCAREF_JS3_withoutna$val4, 
                  BENCAREF_JS3_withoutna$val5, BENCAREF_JS3_withoutna$val6)

Correlation_KCP <- cor(KCP, use = "complete.obs")

factor_find <- fa(r = KCP, nfactors = 5, rotate="promax", fm="ml")

factor_scores <- factor_find$scores
BENCAREF_JS3_withfactor <- data.frame(BENCAREF_JS3_withoutna,factor_scores)


## Outliers

# Calculate Mahalanobis Distance
outliers_data <- factor_scores[,c('ML2','ML4','ML5')]
head(outliers_data)
factor_mean <- colMeans(outliers_data)
factor_cor <- cor(outliers_data, use="complete.obs")
Mahalanobis_Distance <- as.data.frame(mahalanobis(outliers_data,factor_mean,factor_cor))
colnames(Mahalanobis_Distance) <- "MHD"

# chi-square table: df=3, p=0.001 --> maha distance > 16.27
Mahalanobis_Distance_out <- subset(Mahalanobis_Distance, Mahalanobis_Distance$var > 16.27)
which(Mahalanobis_Distance_out$MHD > 16.27)# no outlier
BENCAREF_JS3_factor_mahaDis <- data.frame(BENCAREF_JS3_withoutna,factor_scores, Mahalanobis_Distance)
head(BENCAREF_JS3_factor_mahaDis)


## Cluster
library(factoextra)

cluster_data <- data.frame(BENCAREF_JS3_factor_mahaDis$ML2, 
                           BENCAREF_JS3_factor_mahaDis$ML4, 
                           BENCAREF_JS3_factor_mahaDis$ML5)

cluster_data <- scale(cluster_data) 

# find the optimal cluster number
hc <- hclust(dist(cluster_data))
plot(hc)

library(ggplot2)
set.seed(111)
fviz_nbclust(cluster_data,kmeans,method="wss")+geom_vline(xintercept=3,linetype=2) 
# the optimal cluster number is 4

# K-means
Kmeans_cluster <- kmeans(cluster_data,4)

Kmeans_cluster_final <- cbind(cluster_data, Kmeans_cluster$cluster)

fviz_cluster(Kmeans_cluster, data=cluster_data)
