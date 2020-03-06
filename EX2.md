Exercise 2
==========

This report was made by Chi Zhang, UTEID: cz6753.
Question 1: Saratoga House Prices
---------------------------------
In this question, I am going to deal with the dataset on house prices in Saratoga, NY. First of all, I plan to build a baseline model using variables such as `lotSize`, `bedrooms`, `fireplaces`, `rooms`, `bathrooms`, `air conditioning`, `waterfront` and etc. as regressors and the corresponding model's coefficients has shown below.
```
model1 = lm(price ~ . - sewer - age - livingArea - landValue - pctCollege, data=SaratogaHouses)
##	    (Intercept)	  lotSize	bedrooms
##	217546.952	13850.891	1318.706
##	   fireplaces	              bathrooms	rooms
##	14310.320	51277.008	11760.076
##        heatinghot water/steam	       heatingelectric	fuelelectric
##	-8486.597	-1423.725	-18190.593
##	 fueloil	  waterfrontNo	   newConstructionNo
##	-14174.595	  -185623.747	751.993
##	  centralAirNo
##	-24361.152
```
While this model could give us a not bad picture, adding interaction between these might lead to conflation of estimator coefficients. Therefore, I intend to run the above regression by additionally adding a bunch of interaction terms.
```r
model2 = lm(price ~ (. - sewer - age - livingArea - landValue - pctCollege)^2, data=SaratogaHouses)
```
Viewed from the regression results, the model with pairwise interactions does draw a better picture and looks more efficient. However, adding interaction terms without logical selection would induce weakly significant variables and unnecessary redundancy. Hence, I discriminately screen out some seemingly useless interactions and add some factors which might be drivers to the house price in practical world.
```r
model3 = price ~ landValue + lotSize*(bedrooms + bathrooms) + livingArea*(fuel+ heating + centralAir) + pctCollege*(fireplaces+age) + rooms
```
After model selection, we compare out of sample predictions to see how eﬀective our regression model is and then calculate the average root mean square errors by repeating regression a hundred times for these three regressions respectively.
|         | Prediction | AVG RMSE |
|---------|:--------:  |:--------:|
| model 1 | 70366.34   |65849.04  |
| model 2 | 87183.30   |58104.56  |
| model 3 | 88243.46   |57195.05  |

Now, the best model that we solve is model 3, which is much better than the ones we derived in class. Hence, I decide to choose it as selected one. Moreover, considering that building a KNN model might better our outcomes, I ﬁrst need to standardize our variables and then run the KNN regression using the same variable as that in model 3.
![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/ex2-1.png)

Since we are only interested in looking at the data where RMSE does better than the linear models, let us narrow down our K values up to 30. We can see below that the optimal K value seems to be closer to 11.
Moreover, I also figure out the usage of the variables in both selected linear model and corresponding KNN model with minimizing RMSE. First let us recall the regression result of selected model:
|                                   | coefficients.Estimate | coefficients.Std..Error |
|-----------------------------------|:---------------------:|:-----------------------:|
| (Intercept)                       |     -8.643001e+03     |       1.770303e+04      |
| landValue                         |      8.332313e-01     |       4.815750e-02      |
| lotSize                           |      8.886326e+03     |       8.083021e+03      |
| bedrooms                          |     -9.010594e+03     |       3.051553e+03      |
| bathrooms                         |      2.423306e+04     |       3.872891e+03      |
| livingArea                        |      9.013328e+01     |       5.689994e+00      |
| fuelelectric                      |     -4.945208e+04     |       4.874015e+04      | 
| fueloil                           |      3.908867e+04     |       1.311235e+04      |
| heatinghot water/steam            |      1.277797e+04     |       1.276971e+04      |
| heatingelectric                   |      4.673921e+04     |       4.935837e+04      |
| centralAirNo                      |      3.461381e+04     |       1.046454e+04      |
| pctCollege                        |      1.982960e+01     |       2.603112e+02      |
| fireplaces                        |      4.139041e+04     |       1.479376e+04      |
| age                               |     -5.979931e+02     |       2.613114e+02      |
| rooms                             |      2.539648e+03     |       9.776609e+02      |
| lotSize:bedrooms                  |      1.639476e+03     |       2.742749e+03      |
| lotSize:bathrooms                 |     -3.076214e+03     |       3.420065e+03      |
| livingArea:fuelelectric           |      2.420885e+01     |       2.803848e+01      |
| livingArea:fueloil                |     -2.464235e+01     |       7.454578e+00      | 
| livingArea:heatinghot water/steam |     -1.068582e+01     |       6.773995e+00      |
| livingArea:heatingelectric        |     -2.824654e+01     |       2.859791e+01      |
| livingArea:centralAirNo           |     -2.527276e+01     |       5.479314e+00      |
| pctCollege:fireplaces             |     -7.022711e+02     |       2.601372e+02      |
| pctCollege:age                    |      1.042842e+01     |       4.879803e+00      | 

Viewed from the regression results, there exists many factors that could influence the house price. First of all, the house price gets increased steeply with the increasing of the land value. Then the price is also driven by the number of bathrooms and rooms and are negatively related with number of bedrooms. That might be due to the reduction of each person’s limited activity space. Moreover, central airconditioning is another driving factor in the determination of prices. Based on the type of fuel used, the price of house varies from high for gas to low for electricity. Hot air heating also drives the prices up as compared to electricity or water. Being a new construction however, starkly aﬀects the price of the house.

Question 2:
