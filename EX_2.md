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

Question 2: A Hospital Audit
----------------------------
In this question, I am going to deal with the data in brca.csv consist of 987 screening mammograms administered at a hospital in Seattle, Washington.First, in order to get the most accurate predictions of radiologists’ recall rates, we constructed three logistic models. Because we need to take consideration that all the risk factors need to be constant, we chose age, history of breast biopsy/surgery, breast cancer symptom, menopause/hormone-therapy status and breast density classification as independent variables and recall as dependent variable in our logistic model. After considering the chance of interactions, we selected three following models:
``` r
model1 = recall~radiologist*(age+history+symptoms+menopause+density)
model2 = recall~radiologist+age+history+symptoms+menopause+density
model3 = recall~(radiologist+age+history+symptoms+menopause+density)^2
```
The performance of the models are measured with error rate, which is calculated by sum of the right diagonal numbers of confusion matrix divided by 987 screening mammograms. We use the 80% of the data to do logistic regressions and calculate error rate for the rest 20%, and rerun the Monte Carlo training-testing split to calculate the average error rate. The threshold that we used for the calculation is about 0.151, which is the average rate for the recalled patients. The result of the models are listed below:

|         |  AVG RMSE |
|---------|:---------:|
| model 1 | 0.4033503 |
| model 2 | 0.4496447 |
| model 3 | 0.4069543 |

After running for several times, we found the error rates of model 1 and model 3 are significantly smaller than that of model 2. We used model 1 to predict in the following as the error rate of model 1 is slightly smaller than that of model 3.

Then, we randomly chose 100 samples, which consist of around 10% of 987 screening mammograms. After that, we repeated these 100 samples for 5 times each. In order to address the problem that the radiologists don’t see the same patients, we added an additional row, which is arranged by repeated series radiologist13, radiologist34, radiologist66, radiologist89 and radiologist95. Therefore, we let five radiologists see the same patients. Finally, we predicted the recall rates of each radiologist with model 1. The results are below.

| radiologist   |  Prob\_recall|
|:--------------|-------------:|
| radiologist13 |     0.1463884|
| radiologist34 |     0.0952479|
| radiologist66 |     0.1962011|
| radiologist89 |     0.2179940|
| radiologist95 |     0.1263765|

From the above table, we can clearly see that radiologist89 is most clinically conservative, whose recall rate is about 0.21. Radiologist66, radiologist13, radiologist95 and radiologist34, ranked 2nd, 3rd, 4th and 5th respectivelly in terms of clinically conservative index.

At last, we performed robust test on our results. We predicted recall rates by using model 2 and model 3. The below tables showed the results, which are consistent with the result predicted by model 1.

    ## [1] "model 2"

| radiologist   |  Prob\_recall|
|:--------------|-------------:|
| radiologist13 |     0.1310649|
| radiologist34 |     0.0807986|
| radiologist66 |     0.1780884|
| radiologist89 |     0.1926796|
| radiologist95 |     0.1247958|

    ## [1] "model 3"

| radiologist   |  Prob\_recall|
|:--------------|-------------:|
| radiologist13 |     0.1514313|
| radiologist34 |     0.0662035|
| radiologist66 |     0.2225787|
| radiologist89 |     0.2350007|
| radiologist95 |     0.1318182|

In conclusion, holding patient risk factors equal, the order of clinically conservative characteristic in recalling patients is: radiologist89 &gt; radiologist66 &gt; radiologist13 &gt; radiologist95 &gt; radiologist34, when letting radiologists see the same patients.

### Exercise 2.2.2

The second point that we want to make is that when the radiologists at this hospital interpret a mammogram to make a decision on whether to recall the patient, they should be weighing the history of the patients, the breast cancer symptoms and the menopause status of the patient more heavily than they currently are. Although this means they have to recall more patients back for further checks, it will minimize the false negative rate, identifying more precisely the patients who do end up getting cancer, so that they can be treated as early as possible.

First we built the baseline model, which suggests that when the doctors recall a patient, they tend to think that the patient has a cancer.

To formalize the model by regression, we regressed the patient’s cancer outcome on the radiologist’s recall decision with the logistic regression. The regression model is:

``` r
baseline = cancer ~ recall
```

We splited the dataset into the training set and the testing set using the standard 80-20 rule, and re-run the regression for 100 times to eliminate the stochasticity, and ending up with similar rates to the ones calculated with the entire database.

If we build a model using the recall decision and all the other clinical risk factors and it significantly performs better than the baseline model, it means that there are some risk factors that the doctors are missing.

We checked (1) the model regressing cancer indicator on the recall indicator and all the risk factors, (2) the model regressing cancer indicator on the recall indicator and all the risk factors and their interactions (3) two hand-build models. The thresholds that we chose for these models are the same as the baseline model, so that we can compare these models on the same level. The regression models are:

``` r
model1 = cancer ~ recall + age + history + symptoms + menopause + density
model2 = cancer ~ recall + (age + history + symptoms + menopause + density)^2
model3 = cancer ~ recall + history + symptoms + menopause
```

Before we show the result of the models, we need to explain the criteria that we use to judge these model. When we try to identify the patient, different kinds of error has different cost. It might not be a big problem if a healthy woman is recalled to do some further test, but it may cause death if the doctor didn’t identify the patients who have cancer. Hence the accurate rate is not the best criteria. Instead, we calculate the deviance of these model, and choose the model with smaller deviance.

The average deviance of the models are listed in the following table:

|          | AVG Deviance for Different Models |
|----------|:---------------------------------:|
| Baseline |              1.449282             |
| Model 1  |              1.505878             |
| Model 2  |              1.540937             |
| Model 3  |              1.386806             |

From the table we can tell that the Model 3 has the lowest average deviation, which means we can perform better than the doctors currently do if they give more weight on the terms in Model 3. Overall we can say that the doctors did great jobs at identifying the patients who do get cancer. the drop between Model3 and the baseline is very small.

The logistic regression of model 3 using the whole dataset is shown below:

|                          | coefficients.Estimate | coefficients.Std..Error | coefficients.t.value | coefficients.Pr...t.. |
|--------------------------|:---------------------:|:-----------------------:|:--------------------:|:---------------------:|
| (Intercept)              |       0.0165484       |        0.0109027        |       1.5178354      |       0.1293784       |
| recall                   |       0.1299492       |        0.0165467        |       7.8534925      |       0.0000000       |
| history                  |       0.0079463       |        0.0155115        |       0.5122888      |       0.6085643       |
| symptoms                 |       0.0119353       |        0.0273940        |       0.4356900      |       0.6631576       |
| menopausepostmenoNoHT    |       -0.0010441      |        0.0142239        |      -0.0734067      |       0.9414975       |
| menopausepostmenounknown |       0.0410178       |        0.0328765        |       1.2476318      |       0.2124640       |
| menopausepremeno         |       -0.0058343      |        0.0152413        |      -0.3827939      |       0.7019556       |

From the regression result we can tell that the doctor should consider more about the patient’s history, the breast cancer symptoms and the menopause status of the patient. More specifically, if a person has the history of having cancer, or she has the breast cancer symptoms, or the hormone-therapy status is unknown, she is more likely to have cancers. This result matches our intuition.

To compare the result, we made some predictions with the baseline model and the model we choose.The threshold of positive prediction is chosen as 0.0395, which is slightly higher than the prior probability of having a cancer.

The confusion matrix for the baseline model using the entire dataset is:

|            | prediction = 0 | prediction = 1 |
|------------|:--------------:|:--------------:|
| cancer = 0 |       824      |       126      |
| cancer = 1 |       15       |       22       |

The accuracy rate is (824+22)/987 = 85.7%, the false negative rate is 15/(22+15) = 40.5%, the false positive rate is 126/(126+22) = 85.1%.

The confusion matrix for the model using the entire dataset is:

|            | prediction = 0 | prediction = 1 |
|------------|:--------------:|:--------------:|
| cancer = 0 |       797      |       153      |
| cancer = 1 |       14       |       23       |

The accuracy rate is (797+23)/987 = 83.1%, the false negative rate is 14/(23+14) = 37.8%, the false positive rate is 153/(153+23) = 86.9%.

Although this is the insample rates, we can still conclude that the false negative rate is decreasing, which means it will lower the false negative rate, identifying more precisely the patients who do end up getting cancer, so that they can be treated as early as possible, while the false positive rate is slightly increasing, meaning the doctors have to be more conservative and hence slightly increase the rate of the false alert. However, clearly the fact that we identified more cancer patients matters more.

