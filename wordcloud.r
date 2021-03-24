#Install and load packages

install.packages("wordcloud")
library(wordcloud)
library(tidyverse)


#load and check data

stigmacloud <- read.csv("~/Github/mindmap/wordcloud.csv")

wordcloud()