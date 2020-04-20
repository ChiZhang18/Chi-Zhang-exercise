Exercise 3
==========

This report was made by Chi Zhang, UTEID: cz6753.

Question 1: Predictive Model Building
---------------------------------

In this excercise, I am going to build the best predictive model possible for price and to quantify the average change in rental income per square foot by using this model.
Before the model was assembled I cleaned the data first. I  removed buildings with a leasing rate of 0 per cent and lowered the scale of the building size by 1,000 square feet in order to meet the computation limit. Moreover, I deleted the data with occupancy rate equal to 0 percent as we stated in the first exercise because I believe these buildings are anomalous. Next, to assemble the predictive model for price, I first applied the stepwise selection method. Two models were produced with a slight tweak.

The first model regarded LEED and EnergyStar separately, and the second model combined them into a single category of "green certified." I intended to start with the null model in both models by regressing rent on one, and then adding new variables as shown in the forward selection method. Using it as my baseline model, I ran stepwise selection process and the final model would be eventually obtained.

The two models selected are shown below. I had 45 and 44 significant coefficients, including the interaction terms, respectively.
    ## Rent ~ cluster_rent + size + class_a + class_b + cd_total_07 + 
    ##     age + cluster + net + Electricity_Costs + hd_total07 + leasing_rate + 
    ##     LEED + amenities + cluster_rent:size + size:cluster + cluster_rent:cluster + 
    ##     class_b:age + class_a:age + cd_total_07:net + cd_total_07:hd_total07 + 
    ##     cluster_rent:age + size:leasing_rate + size:Electricity_Costs + 
    ##     size:class_a + age:Electricity_Costs + cluster_rent:leasing_rate + 
    ##     cluster_rent:net + cluster_rent:LEED + Electricity_Costs:hd_total07 + 
    ##     size:cd_total_07 + cluster:Electricity_Costs + class_a:cd_total_07 + 
    ##     cluster:hd_total07 + cluster_rent:hd_total07 + size:age + 
    ##     size:class_b + class_b:amenities + size:amenities + Electricity_Costs:amenities + 
    ##     cluster_rent:amenities + cluster:leasing_rate + age:cluster + 
    ##     size:hd_total07 + age:LEED

    ## Rent ~ cluster_rent + size + class_a + class_b + cd_total_07 + 
    ##     age + cluster + net + Electricity_Costs + hd_total07 + leasing_rate + 
    ##     green_rating + amenities + cluster_rent:size + size:cluster + 
    ##     cluster_rent:cluster + class_b:age + class_a:age + cd_total_07:net + 
    ##     cd_total_07:hd_total07 + cluster_rent:age + size:leasing_rate + 
    ##     size:Electricity_Costs + size:class_a + age:Electricity_Costs + 
    ##     cluster_rent:leasing_rate + cluster_rent:net + Electricity_Costs:hd_total07 + 
    ##     size:cd_total_07 + cluster:Electricity_Costs + cluster:hd_total07 + 
    ##     class_a:cd_total_07 + size:age + size:class_b + size:hd_total07 + 
    ##     cluster_rent:hd_total07 + green_rating:amenities + size:amenities + 
    ##     class_b:amenities + cluster_rent:amenities + Electricity_Costs:amenities + 
    ##     cluster:leasing_rate + age:cluster

I then tried to use the Lasso model to assemble the best predictive model possible for price. Two models were also built with this method, the model considering LEED and EnergyStar separately, and the model combining them into a single "green certified" category. I considered the interaction terms as well.

In the first model, from the path plot below I could see that minimum AIC occurs at segment 65.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-1.png)

Thus, I used the model at the segment 65 and hence chose 184 coefficients. The model specification is shown below.

    ## Rent ~ cluster + size + leasing_rate + stories + age + renovated + 
    ##     class_a + class_b + LEED + Energystar + net + amenities + 
    ##     hd_total07 + total_dd_07 + Precipitation + Electricity_Costs + 
    ##     cluster_rent + cluster:size + cluster:empl_gr + cluster:leasing_rate + 
    ##     cluster:stories + cluster:age + cluster:renovated + cluster:class_a + 
    ##     cluster:class_b + cluster:LEED + cluster:Energystar + cluster:net + 
    ##     cluster:hd_total07 + cluster:total_dd_07 + cluster:Precipitation + 
    ##     cluster:Gas_Costs + cluster:Electricity_Costs + cluster:cluster_rent + 
    ##     size:empl_gr + size:leasing_rate + size:stories + size:age + 
    ##     size:renovated + size:class_a + size:class_b + size:LEED + 
    ##     size:Energystar + size:net + size:amenities + size:cd_total_07 + 
    ##     size:hd_total07 + size:Precipitation + size:Gas_Costs + size:Electricity_Costs + 
    ##     size:cluster_rent + empl_gr:leasing_rate + empl_gr:stories + 
    ##     empl_gr:age + empl_gr:renovated + empl_gr:class_b + empl_gr:LEED + 
    ##     empl_gr:net + empl_gr:amenities + empl_gr:hd_total07 + empl_gr:Precipitation + 
    ##     empl_gr:Electricity_Costs + empl_gr:cluster_rent + leasing_rate:stories + 
    ##     leasing_rate:age + leasing_rate:class_a + leasing_rate:class_b + 
    ##     leasing_rate:LEED + leasing_rate:net + leasing_rate:amenities + 
    ##     leasing_rate:cd_total_07 + leasing_rate:hd_total07 + leasing_rate:total_dd_07 + 
    ##     leasing_rate:Precipitation + leasing_rate:Gas_Costs + leasing_rate:Electricity_Costs + 
    ##     leasing_rate:cluster_rent + stories:age + stories:renovated + 
    ##     stories:class_a + stories:class_b + stories:LEED + stories:Energystar + 
    ##     stories:net + stories:amenities + stories:cd_total_07 + stories:hd_total07 + 
    ##     stories:Precipitation + stories:Gas_Costs + stories:Electricity_Costs + 
    ##     stories:cluster_rent + age:renovated + age:class_a + age:class_b + 
    ##     age:LEED + age:Energystar + age:net + age:amenities + age:cd_total_07 + 
    ##     age:hd_total07 + age:total_dd_07 + age:Precipitation + age:Gas_Costs + 
    ##     age:Electricity_Costs + age:cluster_rent + renovated:class_a + 
    ##     renovated:class_b + renovated:LEED + renovated:Energystar + 
    ##     renovated:net + renovated:amenities + renovated:cd_total_07 + 
    ##     renovated:hd_total07 + renovated:total_dd_07 + renovated:Precipitation + 
    ##     renovated:Gas_Costs + renovated:Electricity_Costs + renovated:cluster_rent + 
    ##     class_a:LEED + class_a:Energystar + class_a:net + class_a:amenities + 
    ##     class_a:cd_total_07 + class_a:hd_total07 + class_a:total_dd_07 + 
    ##     class_a:Precipitation + class_a:Gas_Costs + class_a:Electricity_Costs + 
    ##     class_a:cluster_rent + class_b:LEED + class_b:Energystar + 
    ##     class_b:net + class_b:amenities + class_b:cd_total_07 + class_b:hd_total07 + 
    ##     class_b:total_dd_07 + class_b:Precipitation + class_b:Gas_Costs + 
    ##     class_b:Electricity_Costs + class_b:cluster_rent + LEED:Energystar + 
    ##     LEED:net + LEED:amenities + LEED:cd_total_07 + LEED:total_dd_07 + 
    ##     LEED:Precipitation + LEED:Gas_Costs + LEED:Electricity_Costs + 
    ##     LEED:cluster_rent + Energystar:net + Energystar:amenities + 
    ##     Energystar:cd_total_07 + Energystar:total_dd_07 + Energystar:Precipitation + 
    ##     Energystar:Electricity_Costs + Energystar:cluster_rent + 
    ##     net:amenities + net:cd_total_07 + net:total_dd_07 + net:Precipitation + 
    ##     net:Gas_Costs + net:Electricity_Costs + net:cluster_rent + 
    ##     amenities:hd_total07 + amenities:total_dd_07 + amenities:Precipitation + 
    ##     amenities:Gas_Costs + amenities:Electricity_Costs + amenities:cluster_rent + 
    ##     cd_total_07:hd_total07 + cd_total_07:total_dd_07 + cd_total_07:Precipitation + 
    ##     cd_total_07:Electricity_Costs + cd_total_07:cluster_rent + 
    ##     hd_total07:total_dd_07 + hd_total07:Precipitation + hd_total07:cluster_rent + 
    ##     Precipitation:Gas_Costs + Precipitation:Electricity_Costs + 
    ##     Precipitation:cluster_rent + Gas_Costs:Electricity_Costs + 
    ##     Gas_Costs:cluster_rent + Electricity_Costs:cluster_rent

Similarly in the second model, from the path plot below we could see that minimum AIC occurs at segment 66.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-2.png)

Thus, we used the model at the segment 66 and hence chose 168 coefficients. The specific model is shown below.

    ## Rent ~ cluster + size + leasing_rate + stories + age + renovated + 
    ##     class_a + class_b + green_rating + net + amenities + hd_total07 + 
    ##     total_dd_07 + Precipitation + Electricity_Costs + cluster_rent + 
    ##     cluster:size + cluster:empl_gr + cluster:leasing_rate + cluster:stories + 
    ##     cluster:age + cluster:renovated + cluster:class_a + cluster:class_b + 
    ##     cluster:green_rating + cluster:net + cluster:amenities + 
    ##     cluster:hd_total07 + cluster:total_dd_07 + cluster:Precipitation + 
    ##     cluster:Gas_Costs + cluster:Electricity_Costs + cluster:cluster_rent + 
    ##     size:empl_gr + size:leasing_rate + size:stories + size:age + 
    ##     size:renovated + size:class_a + size:class_b + size:green_rating + 
    ##     size:amenities + size:cd_total_07 + size:hd_total07 + size:Precipitation + 
    ##     size:Gas_Costs + size:Electricity_Costs + size:cluster_rent + 
    ##     empl_gr:leasing_rate + empl_gr:stories + empl_gr:age + empl_gr:renovated + 
    ##     empl_gr:class_b + empl_gr:green_rating + empl_gr:amenities + 
    ##     empl_gr:hd_total07 + empl_gr:Precipitation + empl_gr:Electricity_Costs + 
    ##     empl_gr:cluster_rent + leasing_rate:stories + leasing_rate:age + 
    ##     leasing_rate:class_a + leasing_rate:class_b + leasing_rate:green_rating + 
    ##     leasing_rate:net + leasing_rate:amenities + leasing_rate:cd_total_07 + 
    ##     leasing_rate:hd_total07 + leasing_rate:total_dd_07 + leasing_rate:Precipitation + 
    ##     leasing_rate:Gas_Costs + leasing_rate:Electricity_Costs + 
    ##     leasing_rate:cluster_rent + stories:age + stories:renovated + 
    ##     stories:class_a + stories:class_b + stories:green_rating + 
    ##     stories:net + stories:amenities + stories:cd_total_07 + stories:hd_total07 + 
    ##     stories:Precipitation + stories:Gas_Costs + stories:Electricity_Costs + 
    ##     stories:cluster_rent + age:renovated + age:class_a + age:class_b + 
    ##     age:green_rating + age:net + age:amenities + age:cd_total_07 + 
    ##     age:hd_total07 + age:total_dd_07 + age:Precipitation + age:Gas_Costs + 
    ##     age:Electricity_Costs + age:cluster_rent + renovated:class_a + 
    ##     renovated:class_b + renovated:green_rating + renovated:net + 
    ##     renovated:amenities + renovated:cd_total_07 + renovated:hd_total07 + 
    ##     renovated:total_dd_07 + renovated:Precipitation + renovated:Gas_Costs + 
    ##     renovated:Electricity_Costs + renovated:cluster_rent + class_a:green_rating + 
    ##     class_a:net + class_a:amenities + class_a:cd_total_07 + class_a:hd_total07 + 
    ##     class_a:total_dd_07 + class_a:Precipitation + class_a:Gas_Costs + 
    ##     class_a:Electricity_Costs + class_a:cluster_rent + class_b:green_rating + 
    ##     class_b:net + class_b:amenities + class_b:cd_total_07 + class_b:hd_total07 + 
    ##     class_b:total_dd_07 + class_b:Precipitation + class_b:Gas_Costs + 
    ##     class_b:Electricity_Costs + class_b:cluster_rent + green_rating:net + 
    ##     green_rating:amenities + green_rating:cd_total_07 + green_rating:hd_total07 + 
    ##     green_rating:Precipitation + green_rating:Gas_Costs + green_rating:Electricity_Costs + 
    ##     green_rating:cluster_rent + net:amenities + net:cd_total_07 + 
    ##     net:total_dd_07 + net:Precipitation + net:Gas_Costs + net:Electricity_Costs + 
    ##     net:cluster_rent + amenities:hd_total07 + amenities:total_dd_07 + 
    ##     amenities:Precipitation + amenities:Gas_Costs + amenities:Electricity_Costs + 
    ##     amenities:cluster_rent + cd_total_07:hd_total07 + cd_total_07:total_dd_07 + 
    ##     cd_total_07:Precipitation + cd_total_07:Electricity_Costs + 
    ##     cd_total_07:cluster_rent + hd_total07:total_dd_07 + hd_total07:Precipitation + 
    ##     hd_total07:cluster_rent + total_dd_07:Electricity_Costs + 
    ##     Precipitation:Gas_Costs + Precipitation:Electricity_Costs + 
    ##     Precipitation:cluster_rent + Gas_Costs:Electricity_Costs + 
    ##     Gas_Costs:cluster_rent + Electricity_Costs:cluster_rent

Lastly, by comparing models that are applicable, I used k-fold cross validation by arbitrarily setting k equal to 10 and calculating the CVs. As a result, I found that the CVs of the stepwise selection models are lower than those by Lasso method. **The second stepwise model with the combined "green certified" category had the minimum CV, and therefore it is our best predictive model possible for rent price.**

    ## [1] 9.158497 9.154099 9.186821 9.126833

After model selection process, I need to use selected model to quantify the average change in rental income per square feet (whether in absolute or percentage terms) associated with green certification, holding other features of the building constant.

    ##           green_rating green_rating:amenities 
    ##               2.294792              -2.150574

**Conclusion**: Holding all other significant features of the building fixed, green certified (LEED or EnergyStar) buildings are expected to be 2.29 dollars per square feet per calendar year more expensive in comparison to non-green buildings. However, interestingly when buildings have amenities available on site, the positive effect of the green certification on rental income is significantly neutralized, an expected decrease of 2.15 dollars per square feet per calendar year.

In order to explain this situation, first let's focus on the model selected by stepwise method with combined green rate variable. It could be seen that holding all other significant features of the building fixed, green-certified buildings with amenities is 2.15 dollar per square feet per calendar year lower than green-certified ones without amenities. It shows that "green certification" effect is different for buildings with and without amenities. The intuition behind is that the green buildings with amenities are generally regarded as commercial buildings, so the buildings have to pay the energy fee as commercial rate, which is usually higher than residential rate. Thus, residents in the green buildings with amenities still need to pay more than those in the green buildings without amenities. Thus, the owners of green buildings with amenities will lower the rent fee in order to attract more residents.

Question 2: What causes what
----------------------------

**1.Why can’t I just get data from a few different cities and run the regression of “Crime” on “Police” to understand how more cops in the streets affect crime? (“Crime” refers to some measure of crime rate and “Police” measures the number of cops in a city.)**

The reason I cannot just do the simple regression of “Crime” on “Police” is due to the existence of endogeneity and that might arise from simultaneity, which means that although Crime rate depends on police force, the demand of police force might also depend on the crime rate. Assumed that when a city put more police on the street the crime rate tends to drop, and more police is needed if the crime rate of a city is high. So we need system ofequation including two equations to address this issue. However, the data that we have on hand mixed these two effects so that we cannot tell what is the cause for the variation on the crime rate. Therefore,  we cannot simply do the regression of “Crime” on “Police”.

**2.How were the researchers from UPenn able to isolate this effect? Briefly describe their approach and discuss their result in the “Table 2” below, from the researchers' paper.**

The researchers took endogeneity issue into account. By doing so, they utilized dummy variable _whether the high alert was triggered_ as instrumental variable and a control variable _ridership_ so as to isolate the effect. Therefore, initially data on crime were collected, as well as data of days when there was a high alert for potential terrorist attacks.

let me explain briefly the intuition behind what they have done. Because the mayor of DC will respond actively to these events by putting more cops on the street when there is a high alert of potential terrorist attacks, and that decision made by Mayor does not have the intention of reducing crime on the road. When the high alert was triggered, majority of people might stay at home. The likelihood of a crime would therefore decrease, resulting in fewer crimes not being committed by more cops at that time. In addition to it, researchers also chose riding as a control variable. If the number of ridership is as usual, that means the number of people do not decrease due to the high alert. Thus, researchers need to control the ridership. From table 1, we saw that days with a high alert have lower crimes, since the coefficient is -6.046, which is also significant at 5% level after including the control variable ridership.

Therefore, holding the number of people going out in the days when there’s a high alert fixed (also holding the ridership fixed), the crime becomes lower in those days is due to more cops in the street.

**3.Why did they have to control for Metro ridership? What was that trying to capture?**

While the above method is very brilliant, some may still argue that the correlation between the alert and the crime rate is probably not zero. In high-alert days people may be too afraid to leave from home, and hence crime opportunities may be less, leading to lower crime.

Regarding to it, researchers therefore include ridership into the regression and rerun it.  If the estimation of interest remains negative, then it’s more convincing to say that the regression captures the influence of police force on crime rate.

Viewed from Table 2, the coefficient of interest was still negative holding the control variable fixed. Results rule out the possibility mentioned above to some extent. We can not for sure prove, however, that more cops are causing fewer crimes. Street criminals may have too much fear of terrorists and decide not to leave on a day of high alert. This would reduce crime, which is not linked to more police on the streets.

**4.Below I am showing you "Table 4" from the researchers' paper. Just focus on the first column of the table. Can you describe the model being estimated here? What is the conclusion?**

The model here uses a cluster regression of the impact of a high-alert on a given district in Washington DC to figure out what is the effect of a high-alert on crime allowing for the fact that different districts within DC would have pre-specified law enforcement levels that are not consistent throughout the whole city - namely the Capitol National Mall in comparison with other districts. The researchers concluded that the alert increased the police presence and reduced crime, but for certain districts you control, most of the decrease was observed within one district – the Capitol Mall. This makes sense since the high ratio of extra cops in the district is most likely to be deployed for security reasons as all terrorist targets, such as the United States Capitol, the White House, Federal Triangle and the US Supreme Court are all there. The impact is insignificant in other districts because the confidence interval lies on the coefficient of zero.

Question 3: Clustering and PCA
----------------------------

**Part 1: Distinguish the red from the white**

First I intend to normalize the data. After demeaning and scaling with their standard deviation, I end up with a 6,497\*11 dataset. The following is the heatmap of the correlation between these 11 chemical properties.

Although there are 11 chemical properties, I choose to visualize the data through only 4 dimensions: total sulfur dioxide, density, pH, and volatile acidity. The following graph shows the distribution of the red wines and the white wine on these 4 dimensions. I randomly pick these 4 properties to give a first taste of the data. From the graph I can tell that the red wine and the white wine have different features, so it is highly possible for me to distinguish these two different type of wines.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-3.png)

Since I have already have a basic impression of 2 categories in mind, I choose to first **do clustering with K=2**.

First, by using K-means, I can divide the wines into 2 category. Visualizing through the total sulfur dioxide and the density, I can tell that K=means did an excellent work distinguishing red wines and white wines.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-4.png)

More specifically, I can calculate the accuracy rate by looking at the following confusion matrix. The accuracy rate for K-means is (4,830+1,575)/6,497 = 98.6%, which is pretty high. **This means by looking at the chemical properties, the K-means can characterize the red wine and white wine almost perfectly.**

    ##               wine$color
    ## clust1$cluster  red white
    ##              1   24  4830
    ##              2 1575    68

Second, I use **the PCA method**. The summary of the scores is listed below. The first four principal components capture about 73% of the variance in the data. So I choose to use the first four principal components to do the clustering. The following is the graph of different wines and different categories on the scale of the first two components. As the graph shows, the PCA is also a good way to differ red wines from white wines.

    ## Importance of components:
    ##                           PC1    PC2    PC3     PC4     PC5     PC6
    ## Standard deviation     1.7407 1.5792 1.2475 0.98517 0.84845 0.77930
    ## Proportion of Variance 0.2754 0.2267 0.1415 0.08823 0.06544 0.05521
    ## Cumulative Proportion  0.2754 0.5021 0.6436 0.73187 0.79732 0.85253
    ##                            PC7     PC8     PC9   PC10    PC11
    ## Standard deviation     0.72330 0.70817 0.58054 0.4772 0.18119
    ## Proportion of Variance 0.04756 0.04559 0.03064 0.0207 0.00298
    ## Cumulative Proportion  0.90009 0.94568 0.97632 0.9970 1.00000

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-5.png)

More specifically, I can calculate the accuracy rate by looking at the following confusion matrix. The accuracy rate for K-PCA is (4,818+1,575)/6,497 = 98.4%, which is slightly lower than the K-mean result. **In conclusion, to differ white wines and red wines, we can simply use the K-mean method and it will give me a pretty good result.**

    ##                 wine$color
    ## clustPCA$cluster  red white
    ##                1   24  4818
    ##                2 1575    80


**Part 2: Sort the higher from the lower quality wines**

Before I do the clustering, the following barplot shows the distribution of the different qualities. There are only 7 different qualities of wines in the dataset. It seems that most of the wines have quality of 5 or 6, and only a few of them have very high or very low quality. Since normally the clustering method would divide the data into different categories quite equally, it might be very hard for K-means algorithm to successfully identify the quality of the wines.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-6.png)

What’s more, by data visualization, it seems that the wines with different qualities have similar chemistry features, making it even more difficult to identify the quality of the wine.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-7.png)

First, by using K-means, we can divide the wines into 7 category. The perfect density graph should be as follow.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-8.png)

However, the density of different wine should be concentrating on different categories. The result, as is shown in the following density graph and the confusion matrix, is not so good. There is no obvious pattern that could be pointed out from the clustering. Hence the K-mean method fails at this challenge, just as we expected.

    ##               wine$quality
    ## clust2$cluster   3   4   5   6   7   8   9
    ##              1   2   2  27  16   2   0   0
    ##              2   4  15 197 262 140  14   0
    ##              3   5  63 453 545 133  25   1
    ##              4   4  23  77 552 449  99   4
    ##              5   2  26 266 475 190  31   0
    ##              6   7  24 648 640 122  22   0
    ##              7   6  63 470 346  43   2   0

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-9.png)

Second, I use the PCA method. Still I choose to use the first four principal components to do the clustering with K=7. The following is the graph of different wines qualities and different categories on the scale of the first two components. From the graph I can hardly tell any relations between the quality of the wine and the categories that I find.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-10.png)

The similar story can be told by looking at the confusion matrix and the density graph. However, the PCA method is slightly better than the K-means, since the high quality wine tends to cluster into similar categories. Saying that, the overall result of the prediction is still a nightmare. The chemistry feature just might not be the reason for the different qualities of the wine.

    ##                  wine$quality
    ## clustPCA2$cluster   3   4   5   6   7   8   9
    ##                 1   5  39 493 603 134  24   1
    ##                 2   0  19 263 248  98   8   0
    ##                 3   4   5  90 121  54   6   0
    ##                 4   7  21 496 485  97  17   0
    ##                 5   5  53 297 565 232  43   0
    ##                 6   7  57 363 274  36   2   0
    ##                 7   2  22 136 540 428  93   4

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-11.png)

**In conclusion, I might not be able to tell the difference among the different quality wine by only looking at the chemical features of the wine.**

Question 4: Market Segmentation
----------------------------

First I decided to eliminate as many bots as possible from the slip through. All users with spam posts are assumed to be pots as only a few dozens of them had spam posts. Users with pornography posts are a bit complicated because more than a few couple hundred users had them and at the same time also posted significant amount of other types of posts, so they might just be actual human users with interests in pornography to some extent . To distinguish between humans and bots, we set an arbitrary rule of 20/80 to delete all users having more than 20% of their total posts in pornagraphy. Next, column chatter and uncategorized are deleted because they are the labels that do not fit at all into any of the interest categories. At the end, we are left with 7,676 users to determine market segmentation using clustering and principal components analysis methodologies. At last, there are 33 variables left.

**Part 1: Clustering**

In order to determine market segment by k-means clustering, I must first select the number of initial centroids, or in other words, the number of user types. 3 types of supporting analysis were used to help us determine the quantity: Elbow plot(SSE), CH index and Gap statistics.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-12.png)

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-13.png)

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-14.png)

As shown above, the results are subtle and therefore difficult to determine the best number for K. I eventually picked K=7 for two reasons, 1. I observed a weak signal of dipping in the Gap statistic graph and 2. I found about the equal number of interest groups with relatively strong correlated interests from our correlation analysis as shown below.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-15.png)

I created this heat map hoping to have a deeper analysis of each cluster. Even though we would never know the full picture of each cluster, I believed interests with high proximity, or high correlation, would most likely be fit into same cluster. The more common interests I find from each cluster, the better I can describe each market segment and therefore are able to help our client creating cluster based market strategies.

Some distinct market segments with highly correlated interests are listed below based on the heat map

#### 1. Personal fitness, outdoors, health & nutrition

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-16.png)

#### 2. Fashion, cooking, beauty, shopping, photo sharing

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-17.png)

#### 3. Online gaming, college&university, sports playing

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-18.png)

#### 4. Sports fandom, food, family, religion, parenting, school

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-19.png)

#### 5. Politics, news, computers, travel, automobiles

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-20.png)

#### 6. TV film, art, music

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-21.png)

#### 7. Everything, shopping, photo sharing

From the graphs above, I can see the last group being a very special one, showing moderate interests in almost all areas (compared to strong distinct tastes in other groups). Within the group, interests toward shopping and photo sharing seems to stand out.

**Part 2: Principal Components Analysis**

After data pre-process, In order to reduce dimension of 33 different categories variables, I decided to use principal components analysis methods to find principal components, which can explain most of the variability in the data.

After center and scale the data, I did the correlation analysis of total 33 categories first. In the correlation matrix above, I found that the correlation of those categories are relatively weak, as most correlation coefficients are below 0.3. Thus, I suppose that the proportion of variance explained by most dominant principal components will not be as high as I expected.

I first got the loadings matrix and scores matrix from principal components methods. Then I calculated proportion of variance explained (PVE) to decide the number of principal components that I need to choose.

    ##  [1] 0.13 0.08 0.08 0.07 0.07 0.05 0.04 0.04 0.03 0.03 0.03 0.03 0.03 0.03
    ## [15] 0.03 0.02 0.02 0.02 0.02 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01
    ## [29] 0.01 0.01 0.01 0.01 0.01

In the above table, I can see that the first eight principal components can explain most of the variability. The first principal component explains 13% of the variability; the second principal component explains 8% of the variability; the third principal component explains 8% of the variability;the fourth principal component explains 7% of the variability; the fifth principal component explains 7% of the variability; the sixth principal component explains 5% of the variability; the seventh principal component explains 4% of the variability; the eighth principal component explains 4% of the variability. Together, the first eight principal components explain 56% of the variability.

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-22.png)

![](https://github.com/ChiZhang18/ECO395M-exercise/blob/master/Unnamed%20Plots/e3-23.png)

In the PVE Plot, I can see that between eighth and ninth components, there’s a significant gap in the Scree Plot. Also, from the Cumulative PVE Plot, we can find that first eight principal components can explain more than 50% of the total variability. Thus, I choose 8 principal components to divide the market of NutrientH20 into 8 segments. The characteristics of these 8 market segments are actually latent factor inferred from 33 interests categories.

Then I got top 5 interests of followers of NutrientH20 in each market segment.

    ## [1] "religion"      "food"          "parenting"     "sports_fandom"
    ## [5] "school"

    ## [1] "sports_fandom" "religion"      "parenting"     "food"         
    ## [5] "school"

    ## [1] "politics"   "travel"     "computers"  "news"       "automotive"

    ## [1] "health_nutrition" "personal_fitness" "outdoors"        
    ## [4] "politics"         "news"

    ## [1] "beauty"        "fashion"       "cooking"       "photo_sharing"
    ## [5] "shopping"

    ## [1] "online_gaming"  "sports_playing" "college_uni"    "cooking"       
    ## [5] "automotive"

    ## [1] "automotive"     "shopping"       "photo_sharing"  "news"          
    ## [5] "current_events"

    ## [1] "news"       "automotive" "tv_film"    "art"        "beauty"

In the 1st market segment, top 5 interest of followers are "religion", "food", "parenting", "sports\_fandom" and "school".

In the 2nd market segment, top 5 interest of followers are "sports\_fandom", "religion", "parenting", "food" and "school".

In the 1st and 2nd market segment, the top 5 interests are same, so we combine them into one segment as new 1st market segment.

In the 2nd market segment, top 5 interest of followers are "politics", "travel", "computers", "news" and "automotive".

In the 3rd market segment, top 5 interest of followers are "health\_nutrition", "personal\_fitness", "outdoors", "politics" and "news".

In the 4th market segment, top 5 interest of followers are "beauty", "fashion", "cooking", "photo\_sharing" and "shopping".

In the 5th market segment, top 5 interest of followers are "online\_gaming", "sports\_playing", "college\_uni", "cooking" and "automotive".

In the 6th market segment, top 5 interest of followers are "automotive", "shopping", "photo\_sharing", "news" and "current\_events".

In the 7th market segment, top 5 interest of followers are "news", "automotive", "tv\_film", "art" and "beauty".

Finally, I extracted 7 market segments.

**Part 3: Conclusion**

From the clustering and principal component analysis, I extracted 7 analysis from both of them. The first market segment found by clustering is similar with the third segment found by PCA as they have same interests - Personal fitness, outdoors and health & nutrition.

The second market segment found by clustering is similar with the fourth segment found by PCA as they have same interests - Fashion, cooking, beauty, shopping and photo sharing.

The third market segment found by clustering is similar with the fifth segment found by PCA as they have same interests - Online gaming, college&university and sports playing.

The fourth market segment found by clustering is similar with the first segment found by PCA as they have same interests - Sports fandom, food, religion, parenting and school.

The fifth market segment found by clustering is similar with the second segment found by PCA as they have same interests - Politics, news, computers, travel and automobiles.

The sixth market segment found by clustering is similar with the seventh segment found by PCA as they have similar interests - TV film and art.

The seventh market segment found by clustering is similar with the sixth segment found by PCA as they have similar interests - shopping and photo sharing.

Finally, I labeled above seven market segments to show their unique characteristics.

I named the first market segment as **“Mr. fitness”**. Those kinds of people focus on working out and keeping in a good shape.

I named the second market segment as **“Mrs. fashion”**. Those kinds of people like keeping up with fashion and sharing their happy moments with friends.

I named the third market segment as **“typical college student”**. College students consist with most parts of this group. They are fond of entertainment such as online games and sports during their rest time.

I named the fourth market segment as **“middle-age parents”**. They care about the fostering of their children. Also, they have interests in sports games.

I named the fifth market segment as **“business man”**. They pay attention to daily news online. Also, they like travelling during vacation.

I named the sixth market segment as **“Hippie”**. They like visiting gallery and enjoying movies.

I named the seventh market segment as **“Typical online user with interests toward everything but mainly shopping and photo sharing”**. This is the typical you and me.
