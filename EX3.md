Exercise 3
==========

This report was made by Chi Zhang, UTEID: cz6753.

Question 1: Predictive Model Building
---------------------------------

In this excercise, I am going to build the best predictive model possible for price and to quantify the average change in rental income per square foot by using this model.
Before the model was assembled I cleaned the data first. I  removed buildings with a leasing rate of 0 per cent and lowered the scale of the building size by 1,000 square feet in order to meet the computation limit. Moreover,   I deleted the data with occupancy rate equal to 0 percent as we stated in the first exercise because we believe these buildings are anomalous. Next, to assemble the predictive model for price, we used the stepwise selection method. Two models were produced with a slight tweak.

The first model regarded LEED and EnergyStar separately, and the second model combined them into a single category of "green certified." I  started with the null model in both models by regressing rent on one, and then adding new variables as shown in the forward selection method. Using this model as my baseline model, I ran stepwise selection process and the final model would be eventually obtained.

The two models selected are shown below. We had 45 and 44 significant coefficients, including the interaction terms, respectively.
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

![](Exercise_3_report_files/figure-markdown_github/pathplot1-1.png)

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

In the second model, from the path plot below we could see that minimum AIC occurs at segment 66.

![](Exercise_3_report_files/figure-markdown_github/pathplot2-1.png)

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


In order to explain this situation, I should first focus on the model selected by stepwise method with combined green rate variable, it could be seen that holding all other significant features of the building fixed, green-certified buildings with amenities is 2.15 dollar per square feet per calendar year lower than green-certified ones without amenities. It shows that "green certification" effect is different for buildings with and without amenities. The intuition behind is that the green buildings with amenities are generally regarded as commercial buildings, so the buildings have to pay the energy fee as commercial rate, which is usually higher than residential rate. Thus, residents in the green buildings with amenities still need to pay more than those in the green buildings without amenities. Thus, the owners of green buildings with amenities will lower the rent fee in order to attract more residents.

Exercise 3.2
