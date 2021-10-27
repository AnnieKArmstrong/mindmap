
# Libraries and Packages --------------------------------------------------


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
library(tidyverse)
library(igraph)
library(tidygraph)
library(RColorBrewer)
library(tidyr)
library(dplyr)
install.packages("data.table")
library(data.table)

#install.packages("GGally")
library(GGally)

#install.packages("formattable")
library(formattable)

#install.packages("reactable")
library(reactable)


# Custom Colors -----------------------------------------------------------

customGreen0 = "#DeF7E9"

customGreen = "#71CA97"

customRed = "#ff7f7f"

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


# Some Data Wrangling -----------------------------------------------------
ind_el <- read.csv("~/Github/mindmap/ind-el.csv", fileEncoding = "UTF-8-BOM")
el_ID<-ind_el%>%
        select(Source, Target, Month, Group, StudentStatus, QualitativeCode, Student)

tibble::rowid_to_column(ind_el, "Id")

el<- dplyr::select(ind_el, Source, Target)

d1<-data.frame(source=unlist(el_ID, use.names=FALSE))
nodes <- tibble::rowid_to_column(d1, "Id")

nodes2<-nodes %>%
        distinct(source, .keep_all = TRUE)

write.csv(nodes2, "~/Github/mindmap/ind_nodes.csv") #nodes with id
write.csv()


# Individual Maps ---------------------------------------------------------

MW_2 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)

MW_2Sept <- filter(MW_2, Student == "2MW", Month == "September")
MW_2Dec <- filter(MW_2, Student == "2MW", Month == "December")



i <-dplyr::select(MW_2, Month, QualitativeCode, Student)
f <- filter(i, Student == "2MW")

f2<-table(f$QualitativeCode, f$Month)
f3<- as.data.frame(f2)

p <- pivot_wider(f3, id_cols = NULL, names_from = Var2, values_from = Freq)
p <- rename(p, Code = Var1)
p<- p %>% select(order(colnames(p), decreasing = TRUE))

formattable(p)
formattable(p, align = c("l", "c", "c"),
                         "Var1" = formatter("span", style = ~style(color="grey",
                         font.weight="bold")),
                        'December' = color_tile(customGreen,customGreen0),
                        'September' = color_tile(customGreen,customGreen0))

reactable(
        f,
        columns = list(
                
        )
        
)


#g<- get.adjacency(g, sparse=FALSE)



#MW_2_Graph<- graph_from_adjacency_matrix(g)

col <- data.frame(QualitativeCode = unique(MW_2$QualitativeCode), stringsAsFactors = F)
col$color <- brewer.pal(nrow(col), "Set3")
MW_2$color <-col$color[match(MW_2$QualitativeCode, col$QualitativeCode)]


g <- graph_from_data_frame(MW_2Sept, directed = FALSE)
g

g2<- graph_from_data_frame(MW_2Dec, directed = FALSE)
g2

vertex.attributes(g)

pal<-brewer.pal(length(MW_2$QualitativeCode), "Set3")

plot(g, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "coral", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

write_graph(MW_2_Graph, "~/Github/mindmap/Individual maps/2mw.graphml", "edgelist")


MW_2_graph2 <- graph_from_adjacency_matrix(g)
plot(MW_2_graph2, directed = FALSE, vertex.color ="Sky Blue", layout = layout.circle)


# MW3 Individual Maps -----------------------------------------------------

MW_3 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)
MW_3Sept <- filter(MW_3, Student == "3MW", Month == "September")
MW_3Dec <- filter(MW_3, Student == "3MW", Month == "December")



g <- graph_from_data_frame(MW_3Sept, directed = FALSE)
g

g2<- graph_from_data_frame(MW_3Dec, directed = FALSE)
g2

plot(g, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "coral", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)


# MW4 Individual Maps -----------------------------------------------------

MW_4 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)
MW_4Sept <- filter(MW_4, Student == "4MW", Month == "September")
MW_4Dec <- filter(MW_4, Student == "4MW", Month == "December")

g <- graph_from_data_frame(MW_4Sept, directed = FALSE)
g

g2<- graph_from_data_frame(MW_4Dec, directed = FALSE)
g2

plot(g, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "coral", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)


# MW5 Individual Maps -----------------------------------------------------

MW_5 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)
MW_5Sept <- filter(MW_5, Student == "5MW", Month == "September")
#No December Graph,since the student didn't come in December

g <- graph_from_data_frame(MW_5Sept, directed = FALSE)
g


plot(g, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "coral", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)


# MW6 Individual Maps -----------------------------------------------------

#No September Graph,since the student didn't come in September

MW_6 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)
MW_6Dec <- filter(MW_6, Student == "6MW", Month == "December")

g2<- graph_from_data_frame(MW_6Dec, directed = FALSE)
g2


plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)


# MW September Individual Mind Maps -------------------------------------------------

ind_el <- read.csv("~/Github/mindmap/ind-el.csv", fileEncoding = "UTF-8-BOM")
#Use the fileEncoding because it was importing with a funny character before the first 
#column name

dplyr::select(ind_el, Edge, Target, Month, Group, 
              QualitativeCode, StudentStatus, StudentID)

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
     vertex.label.dist=1, vertex.size = 5, vertex.color=freqMW$StudentStatus,
     layout = layout.davidson.harel)
legend('topleft', legend=levels(freqMW$StudentStatus), fill=pal, border=NA)
     


# TTh September Individual Mindmaps ---------------------------------------

ind_el <- read.csv("~/Github/mindmap/ind-el.csv", fileEncoding = "UTF-8-BOM")
el<- dplyr::select(ind_el, Edge, Target, Month, Group, QualitativeCode, StudentStatus)
TTh<- filter(el, Group == "TTh", Month == "September")


freqTTh<-as.data.frame(table(TTh))
freqTTh<-subset(freqTTh,Freq>0)
freqTTh

gTTh=graph.data.frame(freqTTh)
gTTh<-get.adjacency(gTTh, sparse=FALSE)

TTh_Sept_Ind <-graph_from_adjacency_matrix(gTTh)
plot(TTh_Sept_Ind)

V(TTh_Sept_Ind)
E(TTh_Sept_Ind)

#Network Density
edge_density(TTh_Sept_Ind)

plot(TTh_Sept_Ind, edge.arrow.size = .3,
     vertex.label.dist=1,
     vertex.size = 5,
     vertex.color=freqTTh$StudentStatus,
     layout = layout.davidson.harel)

# December MW Individual Mind Maps ----------------------------------------

el<- dplyr::select(ind_el, Edge, Target, Month, Group, QualitativeCode, StudentStatus)
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

plot(MW_Dec_Ind, directed = FALSE, edge.arrow.size=.2,edge.width=freqDecMW$Freq, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
     vertex.label.dist=1, vertex.size = 5, vertex.color=freqDecMW$StudentStatus,
     layout = layout.davidson.harel)

legend('topleft', legend=levels(freqDecMW$QualitativeCode), fill=pal, border=NA)


# December TTh Individual Mind Maps ---------------------------------------
el<- dplyr::select(ind_el, Edge, Target, Month, Group, QualitativeCode, StudentStatus)
DecTTh <- filter(el, Group == "TTh", Month == "December")

freqDecTTh<-as.data.frame(table(DecTTh))
freqDecTTh<-subset(freqDecTTh,Freq>0)
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
     vertex.size = 5,
     vertex.color=freqDecTTh$StudentStatus,
     edge.color = "Black",
     layout = layout.davidson.harel)


# Group Mind Map -- MW September ------------------------------------------
grp_el <-read.csv("~/Github/mindmap/group-el.csv", fileEncoding = "UTF-8-BOM")

el<- dplyr::select(grp_el, Edge, Target, Month, Group, QualitativeCode)
MW<- filter(el, Group == "MW", Month == "September")

freqMW<-as.data.frame(table(MW)) # Create an edge weight column named "Freq"
freqMW<-subset(freqMW,Freq>0) # Delete all the edges having weight equal to 0
freqMW

g=graph.data.frame(freqMW)
g<- get.adjacency(g, sparse=FALSE)
g


MW_Sept_Grp <- graph_from_adjacency_matrix(g)
plot(MW_Sept_Grp, directed = FALSE)

gsize(MW_Sept_Grp)
gorder(MW_Sept_Grp)

V(MW_Sept_Grp)
E(MW_Sept_Grp)

#Network Density
edge_density(MW_Sept_Grp)

set.seed(1001)
code <- MW_Sept_Grp$QualitativeCode
pal<-brewer.pal(length(code), "Spectral")

q<-plot(MW_Sept_Grp, directed = FALSE, edge.arrow.size=.3,edge.width=freqMW$Freq, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
     vertex.label.dist=1, vertex.size = 5, vertex.color="Purple",
     layout = layout.davidson.harel)


# Tuesday Thursday September Group Map ------------------------------------

el<- dplyr::select(grp_el, Edge, Target, Month, Group, QualitativeCode)
TTh<- filter(el, Group == "TTh", Month == "September")

freqTTh<-as.data.frame(table(TTh)) # Create an edge weight column named "Freq"
freqTTh<-subset(freqTTh,Freq>0) # Delete all the edges having weight equal to 0
freqTTh

g=graph.data.frame(freqTTh)
g<- get.adjacency(g, sparse=FALSE)
g


TTh_Sept_Grp <- graph_from_adjacency_matrix(g)
plot(TTh_Sept_Grp, directed = FALSE)

gsize(TTh_Sept_Grp)
gorder(TTh_Sept_Grp)

V(TTh_Sept_Grp)
E(TTh_Sept_Grp)

#Network Density
edge_density(TTh_Sept_Grp)

set.seed(1001)
code <- MW_Sept_Grp$QualitativeCode
pal<-brewer.pal(length(code), "Spectral")

q<-plot(TTh_Sept_Grp, directed = FALSE, edge.arrow.size=.3,edge.width=freqMW$Freq, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
        vertex.label.dist=1, vertex.size = 5, vertex.color="SkyBlue",
        layout = layout.davidson.harel)

# Code Frequency Comparisons -- Mind Maps ---------------------------------


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

##Comparing Both Groups -- September

grp_el <-read.csv("~/Github/mindmap/group-el.csv", fileEncoding = "UTF-8-BOM")

AllQualCode <-select(grp_el, Month, Group, QualitativeCode)
AllQualCode <-filter(AllQualCode, Month == "September")

AllQualCode <- table(AllQualCode)
AllCode<-as.data.frame(AllQualCode)

a <- ggplot(data=AllCode, aes(x=reorder(QualitativeCode,Freq), y=Freq, fill=Group))+
        geom_col(position="dodge")
a + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")+ 
        labs(title="Group Mind Map Code Frequencies", 
             subtitle = "September 2019")

##Comparing Both Groups -- December

grp_el <-read.csv("~/Github/mindmap/group-el.csv", fileEncoding = "UTF-8-BOM")

AllQualCode <-select(grp_el, Month, Group, QualitativeCode)
AllQualCode <-filter(AllQualCode, Month == "December")

AllQualCode <- table(AllQualCode)
AllCode<-as.data.frame(AllQualCode)

a <- ggplot(data=AllCode, aes(x=reorder(QualitativeCode,Freq), y=Freq, fill=Group))+
        geom_col(position="dodge")
a + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency") + 
        labs(title="Group Mind Map Code Frequencies", 
        subtitle = "December 2019")



