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

##September Individual Mindmaps

el<- dplyr::select(ind_el, Edge, Target, Month, Group, QualitativeCode)
MW<- filter(el, Group == "MW", Month == "September")


freqMW<-as.data.frame(table(MW)) # Create an edge weight column named "Freq"
freqMW<-subset(freqMW,Freq>0) # Delete all the edges having weight equal to 0
freqMW

g=graph.data.frame(freqMW)
g<- get.adjacency(g, sparse=FALSE)
g


MW_Sept_Ind <- graph_from_adjacency_matrix(g)
plot(MW_Sept_Ind, directed = FALSE)

gsize(MW_Sept_Ind)
gorder(MW_Sept_Ind)


#MW Individual Nodelist, September

V(MW_Sept_Ind)
E(MW_Sept_Ind)

#Network Density
edge_density(MW_Sept_Ind)

set.seed(1001)
code <- MW_Sept_Ind$QualitativeCode
pal<-brewer.pal(length(code), "Spectral")

plot(MW_Sept_Ind, directed = FALSE, edge.arrow.size=.3,edge.width=freqMW$Freq, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
     vertex.label.dist=1, vertex.size = 5, vertex.color=freqMW$QualitativeCode,
     layout = layout.davidson.harel)
legend('topleft', legend=levels(QualitativeCode), fill=pal, border=NA)
     

#Tuesday Thursday Individual, September

TTH <- filter(el, Group == "TTh", Month == "September")

freqTTh<-as.data.frame(table(TTH))
freqTTh<-subset(freqTTh,Freq>0)
freqTTh

gTTh=graph.data.frame(freqTTh)
gTTh<-get.adjacency(gTTh, sparse=FALSE)

TTh_Sept_Ind <-graph_from_adjacency_matrix(gTTh)
plot(TTh_Sept_Ind)

V(TTh_Sept_Ind)
E(MW_Sept_Ind)

#Network Density
edge_density(TTh_Sept_Ind)

#pal2<-brewer.pal(length(TTh_Sept_Ind$QualitativeCode), "Set2")
plot(TTh_Sept_Ind, edge.arrow.size = .3,
     vertex.label.dist=1,
     vertex.size = freqTTh$Freq*3,
     vertex.color=freqTTh$Freq,
     layout = layout.davidson.harel)

##December Individual Mind Maps

el<- dplyr::select(ind_el, Edge, Target, Month, Group, QualitativeCode)
DecMW<- filter(el, Group == "MW", Month == "December")

freqDecMW<-as.data.frame(table(DecMW)) # Create an edge weight column named "Freq"
freqDecMW<-subset(freqDecMW,Freq>0) # Delete all the edges having weight equal to 0
freqDecMW

g=graph.data.frame(freqDecMW)
g<- get.adjacency(g, sparse=FALSE)
g

MW_Dec_Ind <- graph_from_adjacency_matrix(g)
plot(MW_Dec_Ind, directed = FALSE)

gsize(MW_Dec_Ind)
gorder(MW_Dec_Ind)

V(MW_Dec_Ind)
E(MW_Dec_Ind)

#Network Density
edge_density(MW_Dec_Ind)

MW_Dec_IndDeg <-degree(MW_Dec_Ind, mode=c("All"))
V(MW_Dec_Ind)$degree<-MW_Dec_IndDeg
V(MW_Dec_Ind)$degree
which.max(alumnet)
V
set.seed(1001)
code <- MW_Dec_Ind$QualitativeCode
pal<-brewer.pal(length(code), "Spectral")

plot(MW_Dec_Ind, directed = FALSE, edge.arrow.size=.2,edge.width=freqMW$Freq, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
     vertex.label.dist=1, vertex.size = MW_Dec_IndDeg, vertex.color="coral",
     layout = layout.davidson.harel)

legend('topleft', legend=levels(freqDecMW$QualitativeCode), fill=pal, border=NA)

##December TTh individual maps

DecTTh <- filter(el, Group == "TTh", Month == "December")

freqDecTTh<-as.data.frame(table(DecTTh))
freqDecTTh<-subset(freqTTh,Freq>0)
freqDecTTh

gTTh=graph.data.frame(freqDecTTh)
gTTh<-get.adjacency(gTTh, sparse=FALSE)

TTh_Dec_Ind <-graph_from_adjacency_matrix(gTTh)
plot(TTh_Dec_Ind)

V(TTh_Dec_Ind)
E(TTh_Dec_Ind)

#Network Density
edge_density(TTh_Dec_Ind)

#Degree Centrality
TThDecInd <-degree(TTh_Dec_Ind, mode=c("All"))
V(TTh_Dec_Ind)$degree<-TThDecInd
V(TTh_Dec_Ind)$degree
which.max(alumnet)
V

#Plot
pal2<-brewer.pal(15,"Set3")
plot(TTh_Dec_Ind, directed = FALSE, edge.arrow.size = .3,
     vertex.label.dist=1,
     vertex.size = TThDecInd,
     vertex.color="cornflower blue",
     edge.color = "Black",
     layout = layout.davidson.harel)


#iHstogram of Code Frequencies

##Tuesday THursday Comparisons

TThQualCode <- select(el, Month, Group, QualitativeCode)
TThQualCode<- filter(TThQualCode, Group == "TTh")

qualcode<-table(TThQualCode)
qualcode<-table($QualitativeCode)
qualcode<-as.data.frame(qualcode)

q<- ggplot(data = qualcode, aes(x=reorder(QualitativeCode,Freq), y=Freq, fill = Month))+
        geom_col(position="dodge")
q + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")

p<-ggplot(data = qualcode, mapping = aes(x = reorder(Var1, Freq), y = Freq, fill= Freq ))+
        geom_col(stat = "identity") 
        
p <- p + coord_flip() + scale_fill_distiller(palette = "Purples") +
        xlab("Code Frequency") + ylab("Qualitative Code")
p

##Monday Wednesday Comparisons
MWQualCode <-select(el, Month, Group, QualitativeCode)
MWQualCode <- filter(MWQualCode, Group == "MW")

MWQualCode<-table(MWQualCode)
qualcode2<-as.data.frame(MWQualCode)
class(qualcode2)

q <- ggplot(data = qualcode2, aes(x=reorder(QualitativeCode,Freq), y=Freq,fill=Month))+
        geom_col(position="dodge")
q + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")

##Comparing both groups -- September

AllQualCode <-select(el, Month, Group, QualitativeCode)
AllQualCode <-filter(AllQualCode, Month == "September")

AllQualCode <- table(AllQualCode)
AllCode<-as.data.frame(AllQualCode)

a <- ggplot(data=AllCode, aes(x=reorder(QualitativeCode,Freq), y=Freq, fill=Group))+
        geom_col(position="dodge")
a + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")

##Comparing Both Groups -- December

AllQualCode <-select(el, Month, Group, QualitativeCode)
AllQualCode <-filter(AllQualCode, Month == "December")

AllQualCode <- table(AllQualCode)
AllCode<-as.data.frame(AllQualCode)

a <- ggplot(data=AllCode, aes(x=reorder(QualitativeCode,Freq), y=Freq, fill=Group))+
        geom_col(position="dodge")
a + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")


