Reading Streaming Music: Approaches to Analysis in 2019 Pop Music
==========

This report was made by Chi Zhang, UTEID: cz6753.

Overview
---------------------------------

When you're stuck at home, music can provide a sense of order amid the coronavirus chaos. Streaming music is cheap or even free (in the case of Pandora and Spotify) and outpaces any physical format when it comes to ease and convenience. There is no denying that streaming music is now faced with the biggest development opportunity since streaming services accounted for nearly 80% of all music revenue in past 2019, in accordance to a year-end report from the RIAA. Therefore, it is of importance to understand user behavior and preference when interacting with streaming music services. To accomplish this objective, we collected the data of the 2019 popular music database from Pandora, one of the widely-used media service providers, and tried to build the best predictive model possible for streams of songs through both linear and non-linear methods for comprehensiveness. More than that, I also segmented the songs into five groups through unsupervised algorithms and estimated the popularity trend for various groups throughout the year. By doing so, the result of this project could help streaming music serversimprove their playlist song recommendations so that better meet users' need and provide the basis for the optimization of future development roadmap.

Data Sources
---------------------------------

The Pandora Top Spins Chart is a record chart ranking the 100 tracks that have been streamed the most over the course of the past week. It is published weekly by Pandora. From <https://www.nextbigsound.com/charts/top-spins>, we downloaded the weekly data of the top 100 songs in the US. The data in year 2019 gives us access to 1,502 different songs.
Given Pandora's public API, I had access to the data on the song features, artists and album information. By using web crawler, I could  extract those target data from the web page and store them in *.csv* format. In the end, the formal dateset ultimately contains the following variables(attached with corresonding descriptions):

<p align="center">
  <img width="700" height="900" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-description.jpg">
</p>
<p align="center">
  <img width="705" height="800" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-description1.jpg">
</p>

>Table 1: Description of Variables used in this Project  

Predictive Model Building
--------------------------

In this part I intended to build a predictive model for the streams of songs in 2019. I selected between linear regression and decision tree models, using methods such as stepwise selection, lasso regression and random forests to make sure the robustness of prediction results.
For the first model, I started with the null model by regressing streams on one, followed by running stepwise selection within 25 song feature variables and eventually obtained the final model.
For the second model, I began with the medium model by regressing streams on all other 25 variables, and used stepwise method to choose variables within all the 25 song features and their interactions.
By doing so, the two selected models are shown below. Noted that I had 5 and 31 significant coefficients, respectively in the first and second model.

    ## [1] "model 1: "

    ## Streams ~ danceability + speechiness + explicitTRUE + key8

    ## [1] "model 2: "

    ## Streams ~ duration_ms_x + acousticness + danceability + energy + 
    ##     liveness + loudness + mode + speechiness + valence + key6 + 
    ##     key8 + key10 + explicitTRUE + relseaseDuration + explicitTRUE:relseaseDuration + 
    ##     valence:explicitTRUE + duration_ms_x:key8 + energy:liveness + 
    ##     acousticness:liveness + mode:speechiness + mode:key10 + speechiness:explicitTRUE + 
    ##     liveness:key6 + acousticness:energy + valence:key6 + mode:key6 + 
    ##     danceability:key8 + key8:explicitTRUE + valence:key8 + speechiness:key8

I then used the Lasso model to assemble the best predictive model possible for streams. When using this method to select two models above, I did not allow for the interaction terms in the third model, but included them in the forth model.

For the third model, viewed from the path plot below I could find that minimum AIC occurs at segment 8, where there are 6 coefficients in this model.

<p align="center">
  <img width="500" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-4.png">
</p>

> Figure 1: Pathplot of Lasso (The Third Model)

Thus, I used the model at the segment 8 and chose 6 coefficients. The specific model is shown below.

    ## [1] "model 3: "

    ## Streams ~ danceability + speechiness + key8 + explicitTRUE + 
    ##     relseaseDuration

For the forth model, viewed from the path plot below I could see that minimum AIC occurs at segment 5, where there are 8 coefficients in the model.

<p align="center">
  <img width="500" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-5.png">
</p>

>Figure 2: Pathplot of Lasso (The Forth Model)

Thus, I used the model at the segment 5 and chose 8 coefficients. The specific model is shown below.

    ## [1] "model 4: "

    ## Streams ~ danceability + danceability:time_signature4 + danceability:explicitTRUE + 
    ##     energy:speechiness + speechiness:relseaseDuration + key8:explicitTRUE + 
    ##     time_signature4:explicitTRUE

Afterwards, I used the decision tree models to assemble the best predictive model possible for streams. I tried the random forest model and the boosting model on the dataset, which gave me 2 non-linear models: the fifth model and the sixth model.


<p align="center">
  <img width="300" height="250" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-RMSE.png">
</p>

>Table 2: RMSE of Different Models

Lastly, I used k-fold cross validation in order to compare all 6 models above. I found that the CVs of the second model has the minimum CV, and therefore it is the best predictive model possible for streams. The advantage of a linear model is that a linear model with interactions is much easier to interpret than the non-linear models.

The second best model was the fifth model, which came from the random forest method. The random forest model has one advantage over the linear regression: it will only give us positive predictions. As a result, I used both the second model and the fifth model to do the predictions.

<p align="center">
  <img width="700" height="900" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-N+1.png">
</p>

>Table 3: Coefficients of The Second Model

From the second model, I could clearly see that *danceability, energy, liveness, loudness, mode, speechiness* and *key 6* have positive effects on streams, which means the more these factors used in the song, the more people the song will be played. Also, I intend to pay attention to *release duration* of the track . The longer the release duration is, the song will be played by less people, which means users prefer to play latest songs on.


<p align="center">
  <img width="500" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-6.png">
</p>

>Figure 3: Partial Dependence Plot (The Fifth Model)

Last but not the least, I plot the partial dependence for each variable contained in the fifth model, and the results seem similar to those derived from the second model, which guarantee the robustness of results. In conclusion, both selected linear model(the second model) and the decision tree model(the fifth model) provided me with similar results.  

PCA and Clustering
------------------

### Methodology Statement

In this section I would like to segment the 1,502 songs into groups with similar features in order to recommend to listeners who share the same interests/taste. For the reason of reducing unnecessary noises and computations, I first reduced the initial 25 variables by PCA. Next, I clustered them into groups with similar principle components, and based on the features in each principal component and the actual songs in each cluster, I were able to describe them in secular terminologies such as *"genre"*.

### Part1: PCA

In this part, I would like to use PCA to balance between the amount of computation load and explanatory variability, while eliminating as much noise as possible from the data. After demeaning and scaling of the data with standard deviation, I calculated the the loading matrix/scores matrix in order to derive the proportion of variance explained (PVE) and decide the number of principal components needed.


<p align="center">
  <img width="700" height="900" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-pca.jpg">
</p>

>Table 4: PCA Components

Table 4 reports that the first 20 principle components explain more than 90% of the variability. and hence I believe that these 20 principle components would keep the computation load low and eliminate some of the noises, while keeping the majority of the variability. Clustering would further group the songs based on these 20 principle components.

### Part 2: Clustering

K-means++ clustering was used to determine the market segments. 3 types of supporting analysis were used to help me determine the number of K (centroids): Elbow plot(SSE), CH index and Gap statistics.


<p align="center">
  <img width="500" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-7.png">
</p>

>Figure 4: SSE Grid vs K


<p align="center">
  <img width="500" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-8.png">
</p>

>Figure 5: CH Grid vs K


<p align="center">
  <img width="500" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-9.png">
</p>

>Figure 6: Gap vs K 

As shown above, both Elbow plot and CH index returned K=16 and Gap statistics returned K=4. Clustering 16 segments would not show the distinct differences among them as I now only have 20 principle components to allocate. So I selected K=4 as my anchor and explored the nearby Ks to see which one provides me with the best explanation for each cluster. For **best explanation**, I considered the following 2 categories.

-   *Clusters that have songs with clear and unique distribution in any of the 20 features.*

-   *Clusters that have songs with clear genre by their artist name and actual music.(I have played a considerable quantity of sample size from each cluster on video music providers such as YouTube, for confirmation)*

As the result, I eventually picked K = 5.

#### Catrgory 1: Song market segments breakdown by distribution of features

After 5 clusters were determined, first I reversed the principle components into the original features to determine cluster characteristics. Then I showed some of the cluster identifiable distributions and the summary of each cluster below.


<p align="center">
  <img width="550" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-10.png">
</p>

<p align="center">
  <img width="550" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-11.png">
</p>

<p align="center">
  <img width="550" height="400" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-12.png">
</p>

>Figure 7: Cluster Identifiable Distributions

-   **Cluster 1**: High in energy, high in loudness, high danceability, low speechiness, considerate amount of G key, low acousticness

-   **Cluster 2**: Many 5 quarter time signature songs, high in energy

-   **Cluster 3**: Many songs with high energy, high on loudness

-   **Cluster 4**: Many songs with high on loudness, high danceability, considerable amount of B flat key

-   **Cluster 5**: Many 3 quarter time signature songs, low speechiness

### Category 2: Song market segments breakdown by genre

Since I have the full list of song names and artist names available in each cluster, I could actually listen to the songs and categorize them manually by the music genre standard as in pop, rock, rap, etc. If my cluster characteristics determined by K-means++ show close resemblance of the music genre, then the recommendation system could be effective, at least to the extent of traditional music listeners with distinct preference over specific genre.

-   **Cluster 1**: Many songs with electronically altered/amplified sounds, very rhythmic, but genre varying from pop to rap to country, etc. Typical examples would be Suge (Yea Yea) by DaBaby, Caro by Bad Bunny and Spy Kid by Chief Keef & Zaytoven.

-   **Cluster 2**: Indeed many songs with 5/4 time signature, high energy and rhythmic, but clearly sets apart different vibe compared cluster 1, perhaps due to the different time signature. Typical examples would be Higher by DJ Khaled, Safety, and That's Mine by GASHI.

-   **Cluster 3**: Genre varies a lot in this cluster, as shown in the very different artists such as Drake, Kendrick Lamar, Taylor Swift, XXXTENTACION and Queen. I did realize that out of the many rap songs in this cluster, most of them were the slower ones. For example, Me! by Taylor Swift and Who Needs Love by Trippie Redd.

-   **Cluster 4**: Songs in B flat key stands out, such as Midnight In Prague by Lil Xan and Say Something by Justin Timberlake, which make this cluster a different vibe than others.

-   **Cluster 5**: Many indie and pop songs with long vowel sounds, typical examples would be When We Were Young by Hollow Coves, Hay-on-Wye by Matthew Frederick and I Keep on Telling Myself by Dve Thomas Junior.

### Trend in popularity

I also calculated the total streams of different song clusters by time. The following graph demonstrates the trend in the total streams of different categories.


<p align="center">
  <img width="550" height="350" src="https://github.com/ChiZhang18/Chi-Zhang-exercise/blob/master/Unnamed%20Plots/fp-N.png">
</p>

>Figure 8: Trend in the Total Streams

From this graph it is demonstrated that the stream of five types of songs does not change too much in a year. Cluster 4 music has more streams overall, due to the fact that there are more songs in this categories. There is a peak in the end of April in 2019 for cluster 4, and then the streams goes back to normal. From this graph I can also see that at the end of the year cluster 4 music is not as popular as in the middle of the year, but type 5 music becomes more and more popular, especially in June and the end of the year. The popularity of cluster 1, cluster 2 and cluster 3 music doesn't vary too much throughout the whole year. 

Conclusion
----------

In each age, the popularity of songs reflects people's preference over different music, which may also differ from each era. To predict the success of a song, taking the contemporaneous music preference into account is of significance. In 2019, modern people are insane about music with elements of danceability, energy, liveness and so on. It seems that they are more likely to pursue the latest music. As a result, in order to predict the song's popularity trend in 2020, the first thing we need to do is to gather the information of public music preference next year.

Traditional music listeners explore songs by specific genre and artists. This confirmation bias, typically nurtured through years of artificial genre segmentation by media and artist reputation, could limit listeners from the songs that they really want to be exposed to. The question of "why are we attracted to certain songs" is a philosophical discussion that is beyond the scope of our project here, but given the data from Apple Music and our clustering method, we perhaps show that key, time signature and speed of the songs are some of the contributing factors to our inner biological working of what to like and dislike. Then, our basic recommendation system, most likely already used by streaming music service providers like Apple Music, Spotify, Pandora, etc., could recommend songs not by mere genre and artist names, but also by specific keys and time signatures each listener is attracted to, subconsciously.
