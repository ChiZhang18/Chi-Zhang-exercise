\#Qustion1: data visualization

library(ggplot2) library(ggExtra) library(gapminder)

ABIA = read.csv(‘../data/ABIA.csv’)

\#Plot 1: Marginal Histogram and Scatterplot to figure out the relation
between Departure Delay and Scheduled Departure Time
theme\_set(theme\_bw()) g &lt;- ggplot(ABIA, aes(CRSDepTime, DepDelay))
+ geom\_point(aes(color = UniqueCarrier)) + labs(title=“Departure Delay
vs Scheduled Departure Time across Carriers”, caption=“Sourced from ABIA
dataset”, y=“Departure Delay in Minute”, x=“Scheduled Departure
Time/hhmm”, color=“Unique Carrier Code”) ggMarginal(g, type =
“histogram”, fill=“transparent”)

\#Plot 2: Facet count chart to figure out conditions on airport delay
across carriers g &lt;- ggplot(ABIA, aes(CRSDepTime, DepDelay)) g +
geom\_count(col=“tomato3”, show.legend=F) + facet\_wrap(\~UniqueCarrier,
scales = “free”) + labs(title = “Departure Delay vs Scheduled Departure
Time across Carriers”, caption=“Sourced from ABIA dataset”, y=“Departure
Delay in Minute”, x=“Scheduled Departure Time/hhmm”)

Question2: K nearest
====================

library(tidyverse) library(FNN) library(MASS) library(mosaic) sclass =
read.csv(‘../data/sclass.csv’)

Focus on 2 trim levels: 350 and 65 AMG
======================================

sclass550 = subset(sclass, trim == ‘350’) sclass65AMG = subset(sclass,
trim == ‘65 AMG’)

####################################### 

\#First we consider the trim level: 350\#
\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

Make a train-test split
=======================

N = nrow(sclass550) N\_train = floor(0.8\*N) N\_test = N - N\_train

randomly sample a set of data points to include in the training set
===================================================================

train\_ind = sample.int(N, N\_train, replace=FALSE)

Define the training and testing set
===================================

D\_train = sclass550\[train\_ind,\] D\_test = sclass550\[-train\_ind,\]

reorder the rows of the testing set by the KHOU (temperature) variable
======================================================================

D\_test = arrange(D\_test, mileage)

Now separate the training and testing sets into features (X) and outcome (y)
============================================================================

X\_train = select(D\_train, mileage) y\_train = select(D\_train, price)
X\_test = select(D\_test, mileage) y\_test = select(D\_test, price)

Choose differents value of K, starting from k=3 since it might be out of bounds when choosing k=2
=================================================================================================

knn3 = knn.reg(train = X\_train, test = X\_test, y = y\_train, k=3) knn5
= knn.reg(train = X\_train, test = X\_test, y = y\_train, k=5) knn10 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=10) knn15 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=15) knn25 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=25) knn50 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=50) knn75 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=75) knn100 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=100) knn150 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=150) knn200 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=200) knn250 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=250) knn300 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=300) knn332 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=332)

define a helper function for calculating RMSE
=============================================

rmse = function(y, ypred) { sqrt(mean(data.matrix((y-ypred)^2))) }

\#define a series of predictions from k-nearest regressions ypred\_knn3
= knn3*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*5 = *k**n**n*5pred
ypred\_knn10 =
knn10*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*15 = *k**n**n*15pred
ypred\_knn25 =
knn25*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*50 = *k**n**n*50pred
ypred\_knn75 =
knn75*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*100 = *k**n**n*100pred
ypred\_knn150 =
knn150*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*200 = *k**n**n*200pred
ypred\_knn250 =
knn250*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*300 = *k**n**n*300pred
ypred\_knn332 = knn332$pred

\#calculate the out-of-sample RMSE in different values of k
rmse(y\_test, ypred\_knn3) rmse(y\_test, ypred\_knn5) rmse(y\_test,
ypred\_knn10) rmse(y\_test, ypred\_knn15) rmse(y\_test, ypred\_knn25)
rmse(y\_test, ypred\_knn50) rmse(y\_test, ypred\_knn75) rmse(y\_test,
ypred\_knn100) rmse(y\_test, ypred\_knn150) rmse(y\_test, ypred\_knn200)
rmse(y\_test, ypred\_knn250) rmse(y\_test, ypred\_knn300) rmse(y\_test,
ypred\_knn332)

attach the predictions to the test data frame
=============================================

D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*3 = *y**p**r**e**d*<sub>*k*</sub>*n**n*3*D*<sub>*t*</sub>*e**s**t*ypred\_knn5
= ypred\_knn5
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*10 = *y**p**r**e**d*<sub>*k*</sub>*n**n*10*D*<sub>*t*</sub>*e**s**t*ypred\_knn15
= ypred\_knn15
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*25 = *y**p**r**e**d*<sub>*k*</sub>*n**n*25*D*<sub>*t*</sub>*e**s**t*ypred\_knn50
= ypred\_knn50
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*75 = *y**p**r**e**d*<sub>*k*</sub>*n**n*75*D*<sub>*t*</sub>*e**s**t*ypred\_knn100
= ypred\_knn100
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*150 = *y**p**r**e**d*<sub>*k*</sub>*n**n*150*D*<sub>*t*</sub>*e**s**t*ypred\_knn200
= ypred\_knn200
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*250 = *y**p**r**e**d*<sub>*k*</sub>*n**n*250*D*<sub>*t*</sub>*e**s**t*ypred\_knn300
= ypred\_knn300 D\_test$ypred\_knn332 = ypred\_knn332

\#plot the fit p\_test = ggplot(data = D\_test) + geom\_point(mapping =
aes(x = mileage, y = price), color=‘lightgrey’) +
theme\_bw(base\_size=18)

p\_test + geom\_path(aes(x = mileage, y = ypred\_knn3), color=‘red’) +
labs(title = “K = 3”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn5), color=‘red’) + labs(title = “K = 5”) p\_test +
geom\_path(aes(x = mileage, y = ypred\_knn10), color=‘red’) + labs(title
= “K = 10”) p\_test + geom\_path(aes(x = mileage, y = ypred\_knn15),
color=‘red’) + labs(title = “K = 15”) p\_test + geom\_path(aes(x =
mileage, y = ypred\_knn25), color=‘red’) + labs(title = “K = 25”)
p\_test + geom\_path(aes(x = mileage, y = ypred\_knn50), color=‘red’) +
labs(title = “K = 50”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn75), color=‘red’) + labs(title = “K = 75”) p\_test +
geom\_path(aes(x = mileage, y = ypred\_knn100), color=‘red’) +
labs(title = “K = 100”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn150), color=‘red’) + labs(title = “K = 150”) p\_test +
geom\_path(aes(x = mileage, y = ypred\_knn200), color=‘red’) +
labs(title = “K = 200”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn250), color=‘red’) + labs(title = “K = 250”) p\_test +
geom\_path(aes(x = mileage, y = ypred\_knn300), color=‘red’) +
labs(title = “K = 300”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn332), color=‘red’) + labs(title = “K = 332”)

\#make a plot of RMSE versus K rmse = function(actual, predicted) {
sqrt(mean((actual - predicted) ^ 2)) } make\_knn\_pred = function(k = 1,
training, predicting) { pred = FNN::knn.reg(train =
training\[“mileage”\], test = predicting\[“mileage”\], y =
training*p**r**i**c**e*, *k* = *k*)pred act = predicting$price
rmse(predicted = pred, actual = act) }

k = c(3:332) knn\_test\_rmse = sapply(k, make\_knn\_pred, training =
D\_train, predicting = D\_test) ggplot() + geom\_path(aes(x = k, y
=knn\_test\_rmse, color=‘red’))

determine “best” k
==================

best\_k = k\[which.min(knn\_test\_rmse)\] best\_k

the optimal value of k is 11, so I do the fitted plot on k = 11
===============================================================

knn\_best = knn.reg(train = X\_train, test = X\_test, y = y\_train,
k=best\_k) ypred\_knn\_best =
knn\_best*p**r**e**d**D*<sub>*t*</sub>*e**s**t*ypred\_knn\_best =
ypred\_knn\_best p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn\_best), color=‘red’) + labs(title = “the Best K for Trim
350”)

######################################## 

\#Then we consider the trim level: 65AMG\#
\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#
\# Make a train-test split N = nrow(sclass65AMG) N\_train =
floor(0.8\*N) N\_test = N - N\_train

randomly sample a set of data points to include in the training set
===================================================================

train\_ind = sample.int(N, N\_train, replace=FALSE)

Define the training and testing set
===================================

D\_train = sclass65AMG\[train\_ind,\] D\_test =
sclass65AMG\[-train\_ind,\]

reorder the rows of the testing set by the mileage variable
===========================================================

D\_test = arrange(D\_test, mileage)

Now separate the training and testing sets into features (X) and outcome (y)
============================================================================

X\_train = select(D\_train, mileage) y\_train = select(D\_train, price)
X\_test = select(D\_test, mileage) y\_test = select(D\_test, price)

Choose differents value of K, starting from k=3 since it might be out of bounds when choosing k=2
=================================================================================================

knn3 = knn.reg(train = X\_train, test = X\_test, y = y\_train, k=3) knn5
= knn.reg(train = X\_train, test = X\_test, y = y\_train, k=5) knn10 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=10) knn15 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=15) knn25 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=25) knn50 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=50) knn75 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=75) knn100 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=100) knn150 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=150) knn200 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=200) knn233 =
knn.reg(train = X\_train, test = X\_test, y = y\_train, k=233)

define a helper function for calculating RMSE
=============================================

rmse = function(y, ypred) { sqrt(mean(data.matrix((y-ypred)^2))) }

\#define a series of predictions from k-nearest regressions ypred\_knn3
= knn3*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*5 = *k**n**n*5pred
ypred\_knn10 =
knn10*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*15 = *k**n**n*15pred
ypred\_knn25 =
knn25*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*50 = *k**n**n*50pred
ypred\_knn75 =
knn75*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*100 = *k**n**n*100pred
ypred\_knn150 =
knn150*p**r**e**d**y**p**r**e**d*<sub>*k*</sub>*n**n*200 = *k**n**n*200pred
ypred\_knn233 = knn233$pred

\#calculate the out-of-sample RMSE in different values of k
rmse(y\_test, ypred\_knn3) rmse(y\_test, ypred\_knn5) rmse(y\_test,
ypred\_knn10) rmse(y\_test, ypred\_knn15) rmse(y\_test, ypred\_knn25)
rmse(y\_test, ypred\_knn50) rmse(y\_test, ypred\_knn75) rmse(y\_test,
ypred\_knn100) rmse(y\_test, ypred\_knn150) rmse(y\_test, ypred\_knn200)
rmse(y\_test, ypred\_knn233)

attach the predictions to the test data frame
=============================================

D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*3 = *y**p**r**e**d*<sub>*k*</sub>*n**n*3*D*<sub>*t*</sub>*e**s**t*ypred\_knn5
= ypred\_knn5
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*10 = *y**p**r**e**d*<sub>*k*</sub>*n**n*10*D*<sub>*t*</sub>*e**s**t*ypred\_knn15
= ypred\_knn15
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*25 = *y**p**r**e**d*<sub>*k*</sub>*n**n*25*D*<sub>*t*</sub>*e**s**t*ypred\_knn50
= ypred\_knn50
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*75 = *y**p**r**e**d*<sub>*k*</sub>*n**n*75*D*<sub>*t*</sub>*e**s**t*ypred\_knn100
= ypred\_knn100
D\_test*y**p**r**e**d*<sub>*k*</sub>*n**n*150 = *y**p**r**e**d*<sub>*k*</sub>*n**n*150*D*<sub>*t*</sub>*e**s**t*ypred\_knn200
= ypred\_knn200 D\_test$ypred\_knn233 = ypred\_knn233

\#plot the fit p\_test = ggplot(data = D\_test) + geom\_point(mapping =
aes(x = mileage, y = price), color=‘lightgrey’) +
theme\_bw(base\_size=18)

p\_test + geom\_path(aes(x = mileage, y = ypred\_knn3), color=‘red’) +
labs(title = “k = 3”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn5), color=‘red’) + labs(title = “k = 5”) p\_test +
geom\_path(aes(x = mileage, y = ypred\_knn10), color=‘red’) + labs(title
= “k = 10”) p\_test + geom\_path(aes(x = mileage, y = ypred\_knn15),
color=‘red’) + labs(title = “k = 15”) p\_test + geom\_path(aes(x =
mileage, y = ypred\_knn25), color=‘red’) + labs(title = “k = 25”)
p\_test + geom\_path(aes(x = mileage, y = ypred\_knn50), color=‘red’) +
labs(title = “k = 50”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn75), color=‘red’) + labs(title = “k = 75”) p\_test +
geom\_path(aes(x = mileage, y = ypred\_knn100), color=‘red’) +
labs(title = “k = 100”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn150), color=‘red’) + labs(title = “k = 150”) p\_test +
geom\_path(aes(x = mileage, y = ypred\_knn200), color=‘red’) +
labs(title = “k = 200”) p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn233), color=‘red’) + labs(title = “k = 233”)

\#make a plot of RMSE versus K rmse = function(actual, predicted) {
sqrt(mean((actual - predicted) ^ 2)) } make\_knn\_pred = function(k = 1,
training, predicting) { pred = FNN::knn.reg(train =
training\[“mileage”\], test = predicting\[“mileage”\], y =
training*p**r**i**c**e*, *k* = *k*)pred act = predicting$price
rmse(predicted = pred, actual = act) } k = c(3:233) knn\_test\_rmse =
sapply(k, make\_knn\_pred, training = D\_train, predicting = D\_test)
ggplot() + geom\_path(aes(x = k, y =knn\_test\_rmse, color=‘red’))

determine “best” k
==================

best\_k = k\[which.min(knn\_test\_rmse)\] best\_k

the optimal value of k is 11, so I do the fitted plot on k = 11
===============================================================

knn\_best = knn.reg(train = X\_train, test = X\_test, y = y\_train,
k=best\_k) ypred\_knn\_best =
knn\_best*p**r**e**d**D*<sub>*t*</sub>*e**s**t*ypred\_knn\_best =
ypred\_knn\_best p\_test + geom\_path(aes(x = mileage, y =
ypred\_knn\_best), color=‘red’) + labs(title = “the Best K for Trim
65AMG”)

\#Q:Which trim yields a larger optimal value of K? Why do you think this
is? \#A: It depends since I randomly split the population into train
group and test group, so every time running the R code you will get
different value of optimal K.
