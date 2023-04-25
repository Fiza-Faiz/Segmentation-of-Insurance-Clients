# Insurance Client Segmentation
This repository contains code for segmenting insurance clients based on their demographics and behavior. The main file is Insurance client segmentation.R, which is an R script that loads the necessary data and performs the segmentation analysis.

## Data
The data used in this analysis is stored in the insurance.csv file. This file contains information on 1,000 insurance clients, including their age, gender, marital status, education level, income, location, and various other attributes. The file was obtained from an open dataset on Kaggle.

## Analysis
The analysis performed in this code involves segmenting the insurance clients into different groups based on their characteristics. The segmentation is performed using a combination of K-means clustering and hierarchical clustering, which are unsupervised machine learning techniques. The output of the analysis is a set of clusters, each representing a distinct group of clients with similar attributes.

## Results
The results of the segmentation analysis are presented in the form of a plot showing the distribution of clients across the different clusters. Additionally, some basic descriptive statistics are provided for each cluster, including the average age, income, and education level of the clients in the cluster.

## Usage
To run the analysis, simply download the Insurance client segmentation.R file and run it in R or RStudio. Note that the script requires several packages to be installed, including **tidyverse, cluster, and factoextra**. These packages can be installed using the install.packages() function in R.

## Credits
The code in this repository was written by Fiza Faiz. The data used in the analysis was obtained from a Kaggle dataset.
