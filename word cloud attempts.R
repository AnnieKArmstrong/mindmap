#install.packages("wordcloud")
library(wordcloud)

#install.packages("RColorBrewer")
library(RColorBrewer)

#install.packages("wordcloud2")
library(wordcloud2)

#install.packages("tidytext")
library(tidytext)

library(tidyverse)
library(dplyr)

#install.packages("tm")
library(tm)

library(ggplot2)

#install.packages("SnowballC")
library(SnowballC)

##Defining the Team
df <- read.csv("~/Github/mindmap/teamcodes.csv", head = TRUE)
na.omit(df)


head(df)
#wordcloud2(data = demoFreq)

wordcloud2(data = df, size = .7, minSize = 0, gridSize =  0,
           fontFamily = 'Segoe UI', fontWeight = 'bold',
           color = 'random-dark', backgroundColor = "white",
           minRotation = -pi/4, maxRotation = pi/4, shuffle = TRUE,
           rotateRatio = 0.4, shape = 'circle', ellipticity = 0.65,
           widgetsize = NULL, figPath = NULL, hoverFunction = NULL)

##Defining Individual Similarities to the Team

##Defining Differences to the Team
df <- read.csv("~/Github/mindmap/indsims.csv", head = TRUE)
na.omit(df)

wordcloud2(data = df, size = .25, minSize = 0, gridSize =  0,
           fontFamily = 'Segoe UI', fontWeight = 'bold',
           color = 'random-dark', backgroundColor = "white",
           minRotation = -pi/4, maxRotation = pi/4, shuffle = TRUE,
           rotateRatio = 0.4, shape = 'circle', ellipticity = 0.65,
           widgetsize = NULL, figPath = NULL, hoverFunction = NULL)

