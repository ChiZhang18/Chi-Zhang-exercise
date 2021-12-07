# Load all the required R packages
library(jpeg)
library(imager)
library(mdendro)
library(vcd)
library(ggplot2)
library(plotly)
library(factoextra)
library(cluster)
library(mclust)
library(NbClust)

memory.limit(35000)

# Load in the data set
fashion <- read.csv("~/Wake Forest MA Statistics/2021 Fall/Multivariate Statistics/Homework/Projects/Project2/project2.csv")

class_names = c('T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat', 'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot')

dim(fashion)
head(fashion[, 1:5])

source("https://raw.githubusercontent.com/MaysonChang/About-Me/master/plot_image.R")

par(mfrow=c(3,4)) 
for (i in 1:10) {
  image = fashion[sample(which(fashion$label == i-1), 1), ]
  image_mat = t(matrix(unlist(image[, -1]), 28, 28))
  plot_image(image_mat, ncol(image_mat))
  title(main = print(class_names[image[1,1]+1]))
}

min(fashion[, -1], na.rm = TRUE)
max(fashion[, -1], na.rm = TRUE)

fashion_mod = fashion[, -1]/255

pca = prcomp(fashion_mod)
E = pca$rotation

variance = 0.98 # The value of retained variance

cum_prop =  summary(pca)$importance[3,] # Cumulative Proportion explained by PCs
num = as.numeric(min(which(cum_prop >= variance))); num
Y = as.matrix(fashion_mod) %*% E[, 1:num]
fashion_pca = Y %*% t(E[, 1:num])

par(mfrow=c(3,2)) 
for (i in 1:3) {
  k = sample(c(1:nrow(fashion_pca)),1)
  image_before = t(matrix(unlist(fashion_mod[k, ]), 28, 28))
  plot_image(image_before, ncol(image_before))
  name_before = print("Original Image")
  title(main = name_before)
  
  image_after = t(matrix(unlist(fashion_pca[k, ]), 28, 28))
  plot_image(image_after, ncol(image_after))
  name_after = print("Reconstructed Image")
  title(main = name_after)
}

## K-means Method
set.seed(123)
label = fashion[, 1]
cl_km = kmeans(fashion_pca, centers = 10, nstart = 10)

tb_km = table(Cluster = cl_km$cluster, Label = label)
assoc(tb_km, shade = T, labeling = labeling_values, main = "The Association Plot Where K = 10") # The association plot

# The Elbow Method
fg_elbow = fviz_nbclust(fashion_pca, kmeans, method = "wss", k.max = 10) + ggtitle("The Elbow Method")

# The Gap Statistic
gap_stat = clusGap(fashion_pca, FUN = kmeans, K.max = 10, B = 10)
fg_gap = fviz_gap_stat(gap_stat) + ggtitle("The Gap Statistic")

# The Silhouette Method
fg_silh = fviz_nbclust(fashion_pca, kmeans, method = "silhouette", k.max = 10) + ggtitle("The Silhouette Method")

subplot(fg_elbow,fg_gap, fg_silh) %>%
  layout(title = "The Elbow Method          The Gap Statistics          Silhouette Method")

cl_km = kmeans(fashion_pca, centers = 4, nstart = 10)
tb_km = table(Cluster = cl_km$cluster, Label = label)
assoc(tb_km, shade = T, labeling = labeling_values, main = "The Association Plot Where K = 4")

cl_km = kmeans(fashion_pca, centers = 3, nstart = 10)
tb_km = table(Cluster = cl_km$cluster, Label = label)
assoc(tb_km, shade = T, labeling = labeling_values, main = "The Association Plot Where K = 3")

## PAM Method
fg_elbow = fviz_nbclust(fashion_pca, cluster::pam, method = "wss", k.max = 10) + ggtitle("The Elbow Method")

gap_stat = clusGap(fashion_pca, FUN = cluster::pam, K.max = 10, B = 10)
fg_gap = fviz_gap_stat(gap_stat) + ggtitle("The Gap Statistic")

fg_silh = fviz_nbclust(fashion_pca, cluster::pam, method = "silhouette", k.max = 10) + ggtitle("The Silhouette Plot")

subplot(fg_elbow, fg_gap, fg_silh)%>%
  layout(title = "The Elbow Method          The Gap Statistics          Silhouette Method")

cl_pam = pam(fashion_pca, k = 2)
tb_pam = table(cluster = cl_pam$clustering, class = label)
assoc(tb_pam, shade = T, labeling = labeling_values)

cl_pam = pam(fashion_pca, k = 6)
tb_pam = table(cluster = cl_pam$clustering, Label = label)
assoc(tb_pam, shade = T, labeling = labeling_values)
