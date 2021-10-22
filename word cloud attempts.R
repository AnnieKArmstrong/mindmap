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

library(igraph)
library(tidygraph)
library(RColorBrewer)
library(tidyr)
library(dplyr)

# Word Clouds -------------------------------------------------------------


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



# Mind Map Network Graphs -------------------------------------------------

ind_el <- read.csv("~/Github/mindmap/grp-edgelist.csv", fileEncoding = "UTF-8-BOM")
#Use the fileEncoding because it was importing with a funny character before the first 
#column name

el<- dplyr::select(ind_el, Edge, Target, Month, Group, QualitativeCode)
MW<- filter(el, Group == "MW", Month == "September")

freqMW<-as.data.frame(table(MW)) # Create an edge weight column named "Freq"

freqMW<-subset(freqMW,Freq>0) # Delete all the edges having weight equal to 0
freqMW

g=graph.data.frame(freqMW)
g<- get.adjacency(g, sparse=FALSE)
g

MW_Sept_Ind <- graph_from_adjacency_matrix(g)
plot(MW_Sept_Ind)

gsize(MW_Sept_Ind)
gorder(MW_Sept_Ind)

#Nodelist

V(MW_Sept_Ind)
E(MW_Sept_Ind)

#Network Density
edge_density(MW_Sept_Ind)

set.seed(1001)
pal<-brewer.pal(length(MW_Sept_Ind$QualitativeCode), "Set2")
plot(MW_Sept_Ind, edge.arrow.size=.3, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
     vertex.label.dist=1, vertex.size = 5, vertex.color=pal[as.numeric(as.factor(vertex_attr(MW_Sept_Ind, "QualitativeCode")))],
     layout = layout.davidson.harel)
