## Just a try~
``` r
library(ggplot2)
library(ggExtra)
library(gapminder)
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
