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
In this question, I am going to deal with the data in `brca.csv` consist of 987 screening mammograms administered at a hospital in Seattle, Washington. First, in order to figure out whether there are some radiologists more clinically conservative than others in recalling patients, the primary method is to create a model that is trained on each of the radiologists’ and then test the model on data from both the radiologist and other patients not seen by the radiologist in question. Because we need to take consideration that all the risk factors need to be constant, we chose `age`, `history of breast biopsy/surgery`, `breast cancer symptom`, `menopause/hormone-therapy status` and `breast density classification` as explanatory variables and `recall` as dependent variable to form the proper logistic model. After taking the existence of interaction terms into account, we selected following two models:
```r
model1 = glm(recall ~ .-cancer, data=brca_train, maxit = maxit)
model2 = glm(recall ~ (.-cancer)^2, data=brca_train, maxit = maxit)
```
Next we are going to measure the performance of two models with error rate, which is calculated by sum of the right diagonal numbers of confusion matrix divided by 987 screening mammograms. The table below depicts average of the out-of-sample RMSE made by Monte Carlo training-testing split for each model.
|         |  AVG RMSE |
|---------|:---------:|
| model 1 | 0.4297103 |
| model 2 | 0.4094487 |

After it, I find there exists only slight difference in the error rate between two models. Hence, I plan to perform robust test to predict recall rates under the scenarios of model1 and model2 respectively.
I first randomly choose 200 samples and repeat them for 5 times to address the issue that **the radiologists don’t see the same patients**. Moreover, an additional row is added, which is arranged by repeated series radiologist13, radiologist34, radiologist66, radiologist89 and radiologist95. In this situation, 5 radiologists could see the mammogram of a single patient and thus the recall rates could reflect the performance of the radiologists.

| Radiologist   |  Prob. of Recall (model1)           | Prob. of Recall (model2)          |
|:--------------|:-----------------------------------:|:---------------------------------:|
| radiologist13 |     0.1309659                       |0.1520413                          |
| radiologist34 |     0.0804886                       |0.0673055                          |
| radiologist66 |     0.1771984                       |0.2315687                          |
| radiologist89 |     0.1919766                       |0.2360001                          |
| radiologist95 |     0.1247765                       |0.1317192                          |

Viewed from the table above, ranking of radiologist’s conservative characteristic under scenario of model1 is consistent with the results derived from model2: radiologist89 > radiologist66 > radiologist13 > radiologist95 > radiologist34. Therefore, the radiologist with # 89 is the most clinically conservative since his recall rate is highest under scenarios of both models, holding patient risk factors equal.
Next, I need to determine whether radiologists are eﬀectively utilizing all of a patient’s clinical data to determine whether or not to recall a patient. I first develop four linear models that attempts to predict cancer rates based on the factors available in the dataset.
``` r
model1 = glm(cancer ~ recall, data=brca_train, maxit = maxit)
model2 = glm(cancer ~ recall + history + symptoms + menopause, data=brca_train, maxit = maxit)
model3 = glm(cancer ~ ., data=brca_train, maxit = maxit)
model4 = glm(cancer ~ (.)ˆ2, data=brca_train, maxit = maxit)
```
Then I plan to calculate the deviance of these models respectively since if might be a problem if a healthy woman is recalled doing some further test, but it may cause death if the doctor didn’t identify the patients who have cancer. Hence, the accurate rate here is not applicable, I intend to consider the average deviance of the model as proper criteria and choose the model with comparatively smaller deviance.
|          | AVG Deviance for Different Models |
|----------|:---------------------------------:|
| Model 1  |              1.449282             |
| Model 2  |              1.386806             |
| Model 3  |              1.505677             |
| Model 4  |              1.540937             |

From the table we can tell that the Model 3 has the lowest average deviation, which means we can perform better than the doctors currently do if they give more weight on the terms in Model 3. Overall, we can say that the doctors did great jobs at identifying the patients who do get cancer. the drop between Model3 and the baseline is very small.
Then I am going to run the regression of chosen model and let ’s take a look at the regression results shown below:
|                          | coefficients.Estimate | coefficients.Std..Error |
|--------------------------|:---------------------:|:-----------------------:|
| (Intercept)              |       0.0165484       |        0.0109027        |
| recall                   |       0.1299492       |        0.0165467        |
| history                  |       0.0079463       |        0.0155115        |
| symptoms                 |       0.0119353       |        0.0273940        | 
| menopausepostmenoNoHT    |       -0.0010441      |        0.0142239        |
| menopausepostmenounknown |       0.0410178       |        0.0328765        |
| menopausepremeno         |       -0.0058343      |        0.0152413        | 

Viewed from the regression results, I find that there exists significant evidence that the doctor should pay more attention on patient’s history, the breast cancer symptoms and the menopause status of the patient. The patient is more likely to have cancers if he or she has the history of having cancer, or she has the breast cancer symptoms, or the hormone-therapy status is unknown.
Ultimately, I am going to compare the results in nature and the specification that sacrificing patient care for a more effective diagnosing mechanism. The threshold of positive prediction is chosen as 0.0395, which is slightly higher than the prior probability of having a cancer.
The confusion matrix for the model in nature (model1) is :
|            | prediction = 0 | prediction = 1 |
|------------|:--------------:|:--------------:|
| cancer = 0 |       824      |       126      |
| cancer = 1 |       15       |       22       |

The accuracy rate is (824+22)/987 = 85.7%, the false negative rate is 15/(22+15) = 40.5%, the false positive rate is 126/(126+22) = 85.1%.
The confusion matrix for the model with chosen specification:

|            | prediction = 0 | prediction = 1 |
|------------|:--------------:|:--------------:|
| cancer = 0 |       797      |       153      |
| cancer = 1 |       14       |       23       |

The accuracy rate is (797+23)/987 = 83.1%, the false negative rate is 14/(23+14) = 37.8%, the false positive rate is 153/(153+23) = 86.9%.
Viewed from the in-sample results, I can draw the conclusion that the false negative rate is decreasing, which means it will lower the false negative rate, identifying more precisely the patients who do end up getting cancer, so that they can be treated as early as possible, while the false positive rate is slightly increasing, meaning the doctors have to be more conservative and hence slightly increase the rate of the false alert. However, clearly the fact that we identified more cancer patients matters more.

Question3: Predicting When Articles Go Viral
--------------------------------------------
In this question, I am going to deal with the data in `online_news.csv` contains data on 39,797 online articles published by Mashable during 2013 and 2014. First, I set up the baseline model for predicting which articles go viral. Out of the 39,644 articles, 19,562 of them have gone viral. This means that even if we blindly predict all articles do not go viral, the accuracy rate would reach 50.7%. We will set this number as our baseline accuracy rate and attempt to improve it as much as we can.
For model construction, I intend to build several logistic models with different combinations of interaction terms, polynomial terms, and transformations and all these models are trained on 80% of this sampled data and tested on the remaining 20%. As mentioned before, a Root Mean Squared Error value is established among the models and then they were tested for in-sample and out-of-sample accuracy and further determines which variables play a main role in deciding whether content go viral.
The models used are shown below:
```r
model1 <<- glm(shares ~ ., data=df_train, maxit = maxit)   #baseline model
model2 <<- glm((shares ~ . - weekday_is_friday - num_videos - data_channel_is_lifestyle global_rate_negative_words, data=df_train, maxit = maxit)
model3 <<- glm(shares ~ (.)ˆ2, data=df_train, maxit = maxit)
model4 <<- glm(shares ~ ((shares ~ . - weekday_is_friday - num_videos - data_channel_is_lifestyle global_rate_negative_words, data=df_train, maxit = maxit)ˆ2, data=df_train, maxit = maxit)
```
The RMSE output for each model is listed in the following table:
|              | AVG. Accurate Rate|
|-----------   |:-----------------:|
| share-Model1 |      0.626298     |
| share-Model2 |      0.602651     |
| share-Model3 |      0.635417     |
| share-Model4 |      0.618867     |

Viewed from the results, model3 turns out to be comparatively better, providing us with higher average accurate rate. 
We now report the confusion matrix with the logit model which provides us with the highest accuracy rate.
|           | prediction = 0 | prediction = 1 |
|-----------|:--------------:|:--------------:|
| viral = 0 |      2494      |      1530      |
| viral = 1 |      1412      |      2493      |

Accuracy rate: 0.635

Overall error rate: 0.365

True positive rate: 0.634

False positive rate:0.366

In a hindsight, it is believed that the method of threshold first and regress/classify second would be the optimal mechanism of developing models that predict what article will go viral.
Moreover, viewed from our chosen model (model3), we could get several drivers to improve an article’s chance of reaching Mashable’s cutoff threshold, 1400 shares. Once an article is under social media or technological channel or published on Saturday, it would contribute a lot. However, if an article is under world or entertainment channel or published on Tuesday, the significant negative effect on its share would take place.  



