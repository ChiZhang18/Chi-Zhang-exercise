Exercise One
============================

Question1: Data Visualization
------------------------

#### Overview of the Problem

In this question, we are given the data in ABIA.csv, which contains information on every commercial flight in 2008 that either departed from or landed at Austin-Bergstrom Interational Airport. I am really interested in two  questions: 1) What is the best time of day to fay to minimize delay; 2)Which flight is worst considering flight delay? Now I intend to use plots to figure them out.

#### Process and Results of Data Analysis
First load the `ggplot2`, `ggExtra` and `gapminder` libraries
``` r
library(ggplot2)
library(ggExtra)
library(gapminder)
```

* Plot 1: Marginal Histogram and Scatterplot to figure out the relation between Departure Delay and Scheduled Departure Time
``` r
ABIA <- read.csv("C:/Users/Mayson Zhang/Desktop/UT Austin MA Economics/2020 Spring/Data Mining/ABIA.csv")
theme_set(theme_bw()) 
g <- ggplot(ABIA, aes(CRSDepTime, DepDelay)) + 
  geom_point(aes(color = UniqueCarrier)) +
  labs(title="Departure Delay vs Scheduled Departure Time across Carriers", 
       caption="Sourced from ABIA dataset",
       y="Departure Delay in Minute",
       x="Scheduled Departure Time/hhmm",
       color="Unique Carrier Code")
ggMarginal(g, type = "histogram", fill="transparent")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q1-1.png) 
Viewed from the plot, I find flight delays mainly occur during the period from 10 am to 8 pm, and relatively long delays also occur during this time period. For comparison,it is not hard to find that the flights are expected to depart from midnight to 5 a.m with almost no delay and thus this period of time could be considered as the best time to minimize flight delay. 

* Plot 2: Facet count chart used to figure out conditions on flight delay across carriers
``` r
g <- ggplot(ABIA, aes(CRSDepTime, DepDelay))
g + geom_count(col="tomato3", show.legend=F) +
    facet_wrap(~UniqueCarrier, scales = "free") +
    labs(title = "Departure Delay vs Scheduled Departure Time across Carriers",
         caption="Sourced from ABIA dataset",
         y="Departure Delay in Minute",
         x="Scheduled Departure Time/hhmm")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q1-2.jpg)
During a day, AA and WN had relatively high numbers of delayed flights, while NW had the least number of delayed flights. This is most likely due to the different numbers of different airline flights per day, and thus we need to make further statistics and explanation on the delay rate of various carriers through histograms.

* Plot3: Histogram of Departure Delay
```r
theme_set(theme_classic()) 
g <- ggplot(ABIA, aes(DepDelay)) + scale_fill_brewer(palette = "Spectral")
g + geom_histogram(binwidth = 1, 
                   col="black", 
                   size=.1) +
    facet_wrap(~UniqueCarrier, scales = "free") +
    labs(title = "Histogram of Departure Delay across Carriers",
         caption="Sourced from ABIA dataset",
         y="Counts",
         x="Departure Delay in Minute")
```         
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q1-3.png)
Viewed from the histogram, I find that 9E, YV have relatively low delay rates, while F9, NW and XE's delay rate are comparatively higher than others. Most airlines have similar delay rates, and even some airlines such as F9, NW, US and XE have a higher probability of departing earlier.

Question2: K nearest
--------------------
#### Overview of the Problem
When dealing with this dataset, I need to use K-nearest neighbors to build a predictive model for price, given mileage, separately for each of two trim levels: 350 and 65 AMG.For each of these two trim levels: 1)Split the data into a training and a testing set; 2)Run K-nearest-neighbors, for many different values of K, starting at K=2 and going as high as you need to; 3)For each value of K, fit the model to the training set and make predictions on your test set. After it, make a plot of RMSE versus K for each trim to find out the optimal value of K and show the fitted plot under the "best" K.

#### Process and Results of the Data Analysis
Load the `tidyverse`, `FNN`, `dplyr`, `mosaic` libraries.
``` r
library(tidyverse)
library(FNN)
library(dplyr)
library(mosaic)
```

Focus on 2 trim levels: 350 and 65 AMG
``` r
sclass550 = subset(sclass, trim == '350')
sclass65AMG = subset(sclass, trim == '65 AMG')
```

First we consider the trim level: 350. 
Make a train-test split.
``` r
N = nrow(sclass550)
N_train = floor(0.8*N)
N_test = N - N_train
```

Randomly sample a set of data points to include in the training set.
``` r
train_ind = sample.int(N, N_train, replace=FALSE)
```

Define the training and testing set.
``` r
D_train = sclass550[train_ind,]
D_test = sclass550[-train_ind,]
```

Reorder the rows of the testing set by the `mileage` variable.
``` r
D_test = arrange(D_test, mileage)
```

Now separate the training and testing sets into features (X) and outcome
(y).
``` r
X_train = select(D_train, mileage)
y_train = select(D_train, price)
X_test = select(D_test, mileage)
y_test = select(D_test, price)
```

Choose differents value of K, starting from k=3 since it might be out of
bounds when choosing k=2
``` r
knn3 = knn.reg(train = X_train, test = X_test, y = y_train, k=3) 
knn5 = knn.reg(train = X_train, test = X_test, y = y_train, k=5)
knn10 = knn.reg(train = X_train, test = X_test, y = y_train, k=10)
knn15 = knn.reg(train = X_train, test = X_test, y = y_train, k=15)
knn25 = knn.reg(train = X_train, test = X_test, y = y_train, k=25)
knn50 = knn.reg(train = X_train, test = X_test, y = y_train, k=50)
knn75 = knn.reg(train = X_train, test = X_test, y = y_train, k=75)
knn100 = knn.reg(train = X_train, test = X_test, y = y_train, k=100)
knn150 = knn.reg(train = X_train, test = X_test, y = y_train, k=150)
knn200 = knn.reg(train = X_train, test = X_test, y = y_train, k=200)
knn250 = knn.reg(train = X_train, test = X_test, y = y_train, k=250)
knn300 = knn.reg(train = X_train, test = X_test, y = y_train, k=300)
knn332 = knn.reg(train = X_train, test = X_test, y = y_train, k=332)
```

Define a helper function for calculating RMSE
``` r
rmse = function(y, ypred) {
  sqrt(mean(data.matrix((y-ypred)^2)))
}
```

Define a series of predictions from k-nearest regressions
``` r
ypred_knn3 = knn3$pred
ypred_knn5 = knn5$pred
ypred_knn10 = knn10$pred
ypred_knn15 = knn15$pred
ypred_knn25 = knn25$pred
ypred_knn50 = knn50$pred
ypred_knn75 = knn75$pred
ypred_knn100 = knn100$pred
ypred_knn150 = knn150$pred
ypred_knn200 = knn200$pred
ypred_knn250 = knn250$pred
ypred_knn300 = knn300$pred
ypred_knn332 = knn332$pred
```

Calculate the out-of-sample RMSE in different values of k
``` r
rmse(y_test, ypred_knn3)
```
    ## [1] 12262.13
``` r
rmse(y_test, ypred_knn5)
```
    ## [1] 11129.54
``` r
rmse(y_test, ypred_knn10)
```
    ## [1] 10481.52
``` r
rmse(y_test, ypred_knn15)
```
    ## [1] 10052.99
``` r
rmse(y_test, ypred_knn25)
```
    ## [1] 10174.39
``` r
rmse(y_test, ypred_knn50)
```
    ## [1] 9782.227
``` r
rmse(y_test, ypred_knn75)
```
    ## [1] 9725.361
``` r
rmse(y_test, ypred_knn100)
```
    ## [1] 9974.101
``` r
rmse(y_test, ypred_knn150)
```
    ## [1] 11228.28
``` r
rmse(y_test, ypred_knn200)
```
    ## [1] 12835.77
``` r
rmse(y_test, ypred_knn250)
```
    ## [1] 14720.8
``` r
rmse(y_test, ypred_knn300)
```
    ## [1] 17874.71
``` r
rmse(y_test, ypred_knn332)
```
    ## [1] 20183.49

Attach the predictions to the test data frame.
``` r
D_test$ypred_knn3 = ypred_knn3
D_test$ypred_knn5 = ypred_knn5
D_test$ypred_knn10 = ypred_knn10
D_test$ypred_knn15 = ypred_knn15
D_test$ypred_knn25 = ypred_knn25
D_test$ypred_knn50 = ypred_knn50
D_test$ypred_knn75 = ypred_knn75
D_test$ypred_knn100 = ypred_knn100
D_test$ypred_knn150 = ypred_knn150
D_test$ypred_knn200 = ypred_knn200
D_test$ypred_knn250 = ypred_knn250
D_test$ypred_knn300 = ypred_knn300
D_test$ypred_knn332 = ypred_knn332
```

Plot the fit
``` r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "K = 3")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-1.png)

```r
p_test + geom_path(aes(x = mileage, y = ypred_knn5), color='red') + labs(title = "K = 5")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-2.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn10), color='red') + labs(title = "K = 10")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-3.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn15), color='red') + labs(title = "K = 15")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-4.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn25), color='red') + labs(title = "K = 25")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-5.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn50), color='red') + labs(title = "K = 50")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-6.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn75), color='red') + labs(title = "K = 75")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-7.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn100), color='red') + labs(title = "K = 100")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-8.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn150), color='red') + labs(title = "K = 150")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-9.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn200), color='red') + labs(title = "K = 200")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-10.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn250), color='red') + labs(title = "K = 250")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-11.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn300), color='red') + labs(title = "K = 300")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-12.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn332), color='red') + labs(title = "K = 332")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-13.png) 

Make a plot of RMSE versus K.
``` r
rmse = function(actual, predicted) {
  sqrt(mean((actual - predicted) ^ 2))
}
make_knn_pred = function(k = 1, training, predicting) {
  pred = FNN::knn.reg(train = training["mileage"], 
                      test = predicting["mileage"], 
                      y = training$price, k = k)$pred
  act  = predicting$price
  rmse(predicted = pred, actual = act)
}

k = c(3:332)
knn_test_rmse = sapply(k, make_knn_pred,
                       training = D_train, 
                       predicting = D_test)
ggplot() + geom_path(aes(x = k, y =knn_test_rmse, color='red'))
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-14.png) 

Determine “best” K
``` r
best_k = k[which.min(knn_test_rmse)]
best_k
```
    ## [1] 73

The optimal value of k is 73, then do the fitted plot in best value of k.
``` r
knn_best = knn.reg(train = X_train, test = X_test, y = y_train, k=best_k)
ypred_knn_best = knn_best$pred
D_test$ypred_knn_best = ypred_knn_best
p_test + geom_path(aes(x = mileage, y = ypred_knn_best), color='red') + labs(title = "the Best K for Trim 350")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-15.png)

Then we consider the trim level: 65AMG.
All the following process are quite similar than what has been shown above, so I intend to partially skip repetitive R codes and focus on display relevant plots.
Considering this trim level: 65AMG, I choose a series of K values and plot the fit respectively.
```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 3")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-16.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 5")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-17.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 10")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-18.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 15")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-19.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 25")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-20.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 50")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-21.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 75")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-22.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 100")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-23.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 150")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-24.png)

```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 200")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-25.png)
```r
p_test = ggplot(data = D_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + labs(title = "k = 233")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-26.png)

Then I make a plot of RMSE versus K through helper functions(the same as what has been shown above).
```r
ggplot() + geom_path(aes(x = k, y =knn_test_rmse, color='red'))
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-28.png)

Eventually, we can therefore determine the optimal value of K(when K = 11) from this trim and plot the corresponding fit.
```r
best_k = k[which.min(knn_test_rmse)]
best_k

knn_best = knn.reg(train = X_train, test = X_test, y = y_train, k=best_k)
ypred_knn_best = knn_best$pred
D_test$ypred_knn_best = ypred_knn_best
p_test + geom_path(aes(x = mileage, y = ypred_knn_best), color='red') + labs(title = "the Best K for Trim 65AMG")
```
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/q2-27.png)

> Q: Which trim yields a larger optimal value of K? Why do you think this is?
>> A: It depends since I randomly split the population into train group and test group, so every time running the R code I will get different value of optimal K.
