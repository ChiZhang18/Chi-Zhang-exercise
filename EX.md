Qustion1: data visualization
----------------------------

``` r
library(ggplot2)
library(ggExtra)
library(gapminder)
```

Plot 1: Marginal Histogram and Scatterplot to figure out the relation
between Departure Delay and Scheduled Departure Time

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

    ## Warning: Removed 1413 rows containing missing values (geom_point).

    ## Warning: Removed 1413 rows containing missing values (geom_point).

![](EX_files/figure-markdown_github/unnamed-chunk-2-1.png) Plot 2: Facet
count chart to figure out conditions on airport delay across carriers

``` r
g <- ggplot(ABIA, aes(CRSDepTime, DepDelay))
g + geom_count(col="tomato3", show.legend=F) +
    facet_wrap(~UniqueCarrier, scales = "free") +
    labs(title = "Departure Delay vs Scheduled Departure Time across Carriers",
         caption="Sourced from ABIA dataset",
         y="Departure Delay in Minute",
         x="Scheduled Departure Time/hhmm")
```

    ## Warning: Removed 1413 rows containing non-finite values (stat_sum).

![](EX_files/figure-markdown_github/unnamed-chunk-3-1.png)

Question2: K nearest
--------------------

``` r
sclass <- read.csv("C:/Users/Mayson Zhang/Desktop/UT Austin MA Economics/2020 Spring/Data Mining/sclass.csv")
library(tidyverse)
```

    ## -- Attaching packages ------------------------------- tidyverse 1.3.0 --

    ## v tibble  2.1.3     v dplyr   0.8.4
    ## v tidyr   1.0.2     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.4.0
    ## v purrr   0.3.3

    ## -- Conflicts ---------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(FNN)

library(dplyr)
library(mosaic)
```

    ## Loading required package: lattice

    ## Loading required package: ggformula

    ## Loading required package: ggstance

    ## 
    ## Attaching package: 'ggstance'

    ## The following objects are masked from 'package:ggplot2':
    ## 
    ##     geom_errorbarh, GeomErrorbarh

    ## 
    ## New to ggformula?  Try the tutorials: 
    ##  learnr::run_tutorial("introduction", package = "ggformula")
    ##  learnr::run_tutorial("refining", package = "ggformula")

    ## Loading required package: mosaicData

    ## Loading required package: Matrix

    ## 
    ## Attaching package: 'Matrix'

    ## The following objects are masked from 'package:tidyr':
    ## 
    ##     expand, pack, unpack

    ## Registered S3 method overwritten by 'mosaic':
    ##   method                           from   
    ##   fortify.SpatialPolygonsDataFrame ggplot2

    ## 
    ## The 'mosaic' package masks several functions from core packages in order to add 
    ## additional features.  The original behavior of these functions should not be affected by this.
    ## 
    ## Note: If you use the Matrix package, be sure to load it BEFORE loading mosaic.

    ## 
    ## Attaching package: 'mosaic'

    ## The following object is masked from 'package:Matrix':
    ## 
    ##     mean

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     count, do, tally

    ## The following object is masked from 'package:purrr':
    ## 
    ##     cross

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     stat

    ## The following objects are masked from 'package:stats':
    ## 
    ##     binom.test, cor, cor.test, cov, fivenum, IQR, median,
    ##     prop.test, quantile, sd, t.test, var

    ## The following objects are masked from 'package:base':
    ## 
    ##     max, mean, min, prod, range, sample, sum

Focus on 2 trim levels: 350 and 65 AMG

``` r
sclass550 = subset(sclass, trim == '350')
sclass65AMG = subset(sclass, trim == '65 AMG')
```

First we consider the trim level: 350 Make a train-test split

``` r
N = nrow(sclass550)
N_train = floor(0.8*N)
N_test = N - N_train
```

randomly sample a set of data points to include in the training set

``` r
train_ind = sample.int(N, N_train, replace=FALSE)
```

Define the training and testing set

``` r
D_train = sclass550[train_ind,]
D_test = sclass550[-train_ind,]
```

Reorder the rows of the testing set by the KHOU (temperature) variable

``` r
D_test = arrange(D_test, mileage)
```

Now separate the training and testing sets into features (X) and outcome
(y)

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

    ## [1] 14720.83

``` r
rmse(y_test, ypred_knn300)
```

    ## [1] 17874.71

``` r
rmse(y_test, ypred_knn332)
```

    ## [1] 20183.49

Attach the predictions to the test data frame

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

![](EX_files/figure-markdown_github/unnamed-chunk-16-1.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn5), color='red') + labs(title = "K = 5")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-2.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn10), color='red') + labs(title = "K = 10")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-3.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn15), color='red') + labs(title = "K = 15")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-4.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn25), color='red') + labs(title = "K = 25")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-5.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn50), color='red') + labs(title = "K = 50")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-6.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn75), color='red') + labs(title = "K = 75")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-7.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn100), color='red') + labs(title = "K = 100")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-8.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn150), color='red') + labs(title = "K = 150")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-9.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn200), color='red') + labs(title = "K = 200")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-10.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn250), color='red') + labs(title = "K = 250")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-11.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn300), color='red') + labs(title = "K = 300")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-12.png)

``` r
p_test + geom_path(aes(x = mileage, y = ypred_knn332), color='red') + labs(title = "K = 332")
```

![](EX_files/figure-markdown_github/unnamed-chunk-16-13.png) Make a plot
of RMSE versus K

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

![](EX_files/figure-markdown_github/unnamed-chunk-17-1.png) Determine
“best” K

``` r
best_k = k[which.min(knn_test_rmse)]
best_k
```

    ## [1] 73

The optimal value of k is 11, so I do the fitted plot on k = 11

``` r
knn_best = knn.reg(train = X_train, test = X_test, y = y_train, k=best_k)
ypred_knn_best = knn_best$pred
D_test$ypred_knn_best = ypred_knn_best
p_test + geom_path(aes(x = mileage, y = ypred_knn_best), color='red') + labs(title = "the Best K for Trim 350")
```

![](EX_files/figure-markdown_github/unnamed-chunk-19-1.png)
