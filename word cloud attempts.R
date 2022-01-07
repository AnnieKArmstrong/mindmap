
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
library(knitr)

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

node_codes <- read.csv("~/Github/mindmap/node_codes.csv", fileEncoding = "UTF-8-BOM")

ind_nodes <- read.csv("~/Github/mindmap/ind_nodes.csv")

group_node_codes <- read.csv("~/Github/mindmap/group_node_codes.csv", fileEncoding = "UTF-8-BOM")

group_el <- read.csv("~/Github/mindmap/group_el_real.csv", fileEncoding = "UTF-8-BOM")


MW_node_codes <- group_node_codes %>% 
        dplyr::select(Month, Group, Code) %>%
        filter(Group == "MW") %>%
        filter(Code != "Bronx River")
TTh_node_codes <- group_node_codes %>% 
        select(Month, Group, Code) %>%
        filter(Group == "TTh")%>%
        filter(Code != "Bronx River")
#Distinct group nodes/codes

d <- distinct(group_node_codes, .keep_all = TRUE)
d
# tibble::rowid_to_column(ind_el, "Id")
# 
# el<- dplyr::select(ind_el, Source, Target)
# 
# d1<-data.frame(source=unlist(el_ID, use.names=FALSE))
# nodes <- tibble::rowid_to_column(d1, "Id")
# 
# nodes2<-nodes %>%
#         distinct(source, .keep_all = TRUE)
# 
# write.csv(nodes2, "~/Github/mindmap/ind_nodes.csv") #nodes with id
# write.csv()
# 



# MW2 Individual Maps ---------------------------------------------------------

MW_2 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)

MW_2Sept <- filter(MW_2, Student == "2MW", Month == "September")
MW_2Dec <- filter(MW_2, Student == "2MW", Month == "December")



i <-dplyr::select(ind_el, Month, QualitativeCode, Student)
f <- filter(i, Student == "2MW", QualitativeCode != "*")
f
D<- distinct(f, QualitativeCode)
D

f2<-table(f$QualitativeCode, f$Month)
f3<- as.data.frame(f2)

p <- pivot_wider(f3, id_cols = NULL, names_from = Var2, values_from = Freq)
p <- rename(p, Code = Var1)

p<- p %>% select(order(colnames(p), decreasing = FALSE))

formattable(p, align = c("l", "c", "c"), list(
                         "Var1" = formatter("span", style = ~style(color="grey",
                         font.weight="bold"), width = 50),
                        'December' = color_tile(customGreen0,customGreen),
                        'September' = color_tile(customGreen0,customGreen)
                        ))
reactable(
        p,
        columns = list()
        
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

# MW7 Individual Mind Maps ----------------------------------------------------

MW_7 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)
MW_7Dec <- filter(MW_7, Student == "7MW", Month == "December")

g2<- graph_from_data_frame(MW_7Dec, directed = FALSE)
g2


plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)


# MW8 Individual Mind Maps ------------------------------------------------

MW_8 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)
MW_8Dec <- filter(MW_8, Student == "8MW", Month == "December")

g2<- graph_from_data_frame(MW_8Dec, directed = FALSE)
g2


plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

# TTH9 Individual Maps ----------------------------------------------------

TTH_9 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                     QualitativeCode, StudentStatus, Student)
TTH_9Sept <- filter(TTH_9, Student == "9TTh", Month == "September")
TTH_9Dec <- filter(TTH_9, Student == "9TTh", Month == "December")

g <- graph_from_data_frame(TTH_9Sept, directed = FALSE)
g

#g2<- graph_from_data_frame(TTH_9Dec, directed = FALSE)
#g2

plot(g, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "coral", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

#plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     #vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
     #layout = layout.fruchterman.reingold)


# TTh10 Individual Maps ---------------------------------------------------

TTH_10 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                      QualitativeCode, StudentStatus, Student)
TTH_10Sept <- filter(TTH_10, Student == "10TTh", Month == "September")
TTH_10Dec <- filter(TTH_10, Student == "10TTh", Month == "December")

g <- graph_from_data_frame(TTH_10Sept, directed = FALSE)
g

g2<- graph_from_data_frame(TTH_10Dec, directed = FALSE)
g2

plot(g, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "coral", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

plot(g2, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
        vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "sky blue", vertex.label.dist=10,
        layout = layout.fruchterman.reingold)


# TTh11 Individual maps-------------------------------------------------------------------

TTH_11 <-dplyr::select(ind_el, Source, Target, Month, Group, 
                       QualitativeCode, StudentStatus, Student)
TTH_11Sept <- filter(TTH_11, Student == "10TTh", Month == "September")
TTH_11Dec <- filter(TTH_11, Student == "10TTh", Month == "December")

g <- graph_from_data_frame(TTH_11Sept, directed = FALSE)
g

g2<- graph_from_data_frame(TTH_11Dec, directed = FALSE)
g2

plot(g, directed = FALSE, edge.arrow.size=.3, edge.color = "black", vertex.label.cex=1,
     vertex.label.dist=1, vertex.label.color = "black", vertex.size = 5, vertex.color = "coral", vertex.label.dist=10,
     layout = layout.fruchterman.reingold)

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

el<- dplyr::select(group_el, Edge, Target, Month, Group)
MW<- filter(el, Group == "MW", Month == "September", Edge !="", Target !="")
MW
# nodes <- select(grp_MW_nodes, Node, Code)

# g <- graph_from_data_frame(d=MW, vertices=nodes, directed=FALSE)
# g


freqMW<-as.data.frame(table(MW)) # Create an edge weight column named "Freq"
freqMW<-subset(freqMW,Freq>0) # Delete all the edges having weight equal to 0
freqMW

g=graph.data.frame(freqMW, directed = FALSE)
#g<- get.adjacency(g, sparse=FALSE)
g
plot(g)

# MW_Sept_Grp <- graph_from_adjacency_matrix(g, directed = FALSE)
# plot(MW_Sept_Grp, directed = FALSE)

gsize(g)
gorder(g)

V(g)
E(g)

#Network Density
edge_density(g)


#Degree Centrality
deg<-degree(g, mode=c("All"))
V(g)$degree<-deg
V(g)$degree
which.max(deg)
V(g)


#Eigenvector Centrality
eig<-evcent(g)$vector
V(g)$Eigen<-eig
V(g)$Eigen
which.max(eig)

#Betweenness Centrality

alumnet_bw<-estimate_betweenness(g, 
                                 vids = V(g), 
                                 directed = TRUE,
                                 weights=NA,
                                 cutoff=0)
alumnet_bw

edge_betweenness(g)
betweenness(g)


set.seed(1001)
V(g)$size <- V(g)$Eigen 

# q<-plot(MW_Sept_Grp, edge.arrow.size=.3,edge.width=freqMW$Freq, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
#      vertex.label.dist=1, vertex.size = 5, vertex.color="Coral",
#      layout = layout.fruchterman.reingold)

plot(g, edge.color="darkslategray", vertex.label.cex=.75, vertex.size=V(g)$degree*1.5, vertex.label.dist=1.5, 
    layout=layout.fruchterman.reingold, vertex.color = "coral", vertex.label.color = "black")


# Group Plot MW December --------------------------------------------------

el<- dplyr::select(group_el, Edge, Target, Month, Group)
MW<- filter(group_el, Group == "MW", Month == "December", Edge !="", Target !="")
MW
# nodes <- select(grp_MW_nodes, Node, Code)

# g <- graph_from_data_frame(d=MW, vertices=nodes, directed=FALSE)
# g


freqMW<-as.data.frame(table(MW)) # Create an edge weight column named "Freq"
freqMW<-subset(freqMW,Freq>0) # Delete all the edges having weight equal to 0
freqMW

g=graph.data.frame(freqMW, directed = FALSE)
#g<- get.adjacency(g, sparse=FALSE)
g
plot(g)

# MW_Sept_Grp <- graph_from_adjacency_matrix(g, directed = FALSE)
# plot(MW_Sept_Grp, directed = FALSE)

gsize(g)
gorder(g)

V(g)
E(g)

#Network Density
edge_density(g)


#Degree Centrality
deg<-degree(g, mode=c("All"))
V(g)$degree<-deg
V(g)$degree
which.max(deg)
V(g)


#Eigenvector Centrality
eig<-evcent(g)$vector
V(g)$Eigen<-eig
V(g)$Eigen
which.max(eig)

#Betweenness Centrality

alumnet_bw<-estimate_betweenness(g, 
                                 vids = V(g), 
                                 directed = TRUE,
                                 weights=NA,
                                 cutoff=0)
alumnet_bw

edge_betweenness(g)
betweenness(g)


set.seed(1001)
V(g)$size <- V(g)$Eigen 

# q<-plot(MW_Sept_Grp, edge.arrow.size=.3,edge.width=freqMW$Freq, #vertex.color = "darkgoldenrod2", edge.color='deepskyblue2',vertex.label.cex=0.5,
#      vertex.label.dist=1, vertex.size = 5, vertex.color="Coral",
#      layout = layout.fruchterman.reingold)

plot(g, edge.color="darkslategray", vertex.label.cex=.75, vertex.size=V(g)$degree*1.5, vertex.label.dist=1.5, 
     layout=layout.fruchterman.reingold, vertex.color = "sky blue", vertex.label.color = "black")

# Tuesday Thursday September Group Map ------------------------------------

TTh<- filter(group_el, Group == "TTh", Month == "September")

freqTTh<-as.data.frame(table(TTh)) # Create an edge weight column named "Freq"
freqTTh<-subset(freqTTh,Freq>0) # Delete all the edges having weight equal to 0

freqTTh

g=graph.data.frame(freqTTh, directed = FALSE)
#g<- get.adjacency(g, sparse=FALSE)
g


#TTh_Sept_Grp <- graph_from_adjacency_matrix(g)
plot(g)

# gsize(TTh_Sept_Grp)
# gorder(TTh_Sept_Grp)
# 
# V(TTh_Sept_Grp)
# E(TTh_Sept_Grp)

#Network Density
edge_density(TTh_Sept_Grp)

#Network Density
edge_density(g)


#Degree Centrality
deg<-degree(g, mode=c("All"))
V(g)$degree<-deg
V(g)$degree
which.max(deg)
V(g)


#Eigenvector Centrality
eig<-evcent(g)$vector
V(g)$Eigen<-eig
V(g)$Eigen
which.max(eig)

#Betweenness Centrality

alumnet_bw<-estimate_betweenness(g, 
                                 vids = V(g), 
                                 directed = TRUE,
                                 weights=NA,
                                 cutoff=0)
set.seed(1001)
plot(g, edge.color="darkslategray",vertex.label.cex=.75, 
     vertex.size=V(g)$degree*1.5, vertex.label.dist=1.5, 
     vertex.color = "coral", vertex.label.color = "black")


# Group Map Tuesday Thursday December -------------------------------------
TTh<- filter(group_el, Group == "TTh", Month == "December")

freqTTh<-as.data.frame(table(TTh)) # Create an edge weight column named "Freq"
freqTTh<-subset(freqTTh,Freq>0) # Delete all the edges having weight equal to 0

freqTTh

g=graph.data.frame(freqTTh, directed = FALSE)
#g<- get.adjacency(g, sparse=FALSE)
g


#TTh_Sept_Grp <- graph_from_adjacency_matrix(g)
plot(g)

# gsize(TTh_Sept_Grp)
# gorder(TTh_Sept_Grp)
# 
# V(TTh_Sept_Grp)
# E(TTh_Sept_Grp)

#Network Density
edge_density(TTh_Sept_Grp)

#Network Density
edge_density(g)


#Degree Centrality
deg<-degree(g, mode=c("All"))
V(g)$degree<-deg
V(g)$degree
which.max(deg)
V(g)


#Eigenvector Centrality
eig<-evcent(g)$vector
V(g)$Eigen<-eig
V(g)$Eigen
which.max(eig)

#Betweenness Centrality

alumnet_bw<-estimate_betweenness(g, 
                                 vids = V(g), 
                                 directed = TRUE,
                                 weights=NA,
                                 cutoff=0)
set.seed(1001)
plot(g, edge.color="darkslategray",vertex.label.cex=.75, 
     vertex.size=V(g)$degree*1.5, vertex.label.dist=1.5, 
     vertex.color = "sky blue", vertex.label.color = "black")


# Code Frequency Comparisons -- Mind Maps ---------------------------------
i <-dplyr::select(ind_el, Month, QualitativeCode)

f<-table(i$QualitativeCode, i$Month)

f2<- as.data.frame(f)

p <- pivot_wider(f2, id_cols = NULL, names_from = Var2, values_from = Freq)
p <- rename(p, Code = Var1)

p<- p %>% select(order(colnames(p), decreasing = FALSE))

formattable(p, align = c("l", "c", "c"), list(
        "Var1" = formatter("span", style = ~style(color="grey",
                                                  font.weight="bold")),
        'September' = color_tile(customGreen0,customGreen),
        'December' = color_tile(customGreen0,customGreen)
))


##Within Group Tuesday THursday Comparisons -- 

TTh_node_table <- table(TTh_node_codes)
TTh_node_table <-as.data.frame(TTh_node_table) %>%
    filter(Freq > 5)


q<-ggplot(data = TTh_node_table, aes(x=reorder(Code,Freq) , y = Freq, fill = Month))+
        geom_bar(stat="identity")

q
q + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency") +
        labs(title="Aggregated Individual Mind Map Code Frequencies", 
             subtitle = "Tuesday/Thursday Group")

# TThQualCode <- dplyr::select(ind_el, Month, Group, QualitativeCode)
# TThQualCode<- filter(TThQualCode, Group == "TTh")
# 
# qualcode<-table(TThQualCode)
# qualcode<-as.data.frame(qualcode)
# 
# q<- ggplot(data = qualcode, aes(x=reorder(QualitativeCode,Freq), y=Freq, fill = Month))+
#         geom_col(position="dodge")
# q + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")
# 
# 
# p<-ggplot(data = qualcode, mapping = aes(x = reorder(Var1, Freq), y = Freq, fill= Freq ))+
#         geom_col(stat = "identity") 
#         
# p <- p + coord_flip() + scale_fill_distiller(palette = "Purples") +
#         xlab("Code Frequency") + ylab("Qualitative Code")
# p

##Within Group Monday Wednesday Comparisons

MW_node_table <- table(MW_node_codes)
MW_node_table <-as.data.frame(MW_node_table)

q<-ggplot(data = MW_node_table, aes(x=reorder(Code,Freq), y = Freq, fill = Month))+
        geom_bar(stat="identity")

q
q + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency") +
labs(title="Aggregated Individual Mind Map Code Frequencies", 
     subtitle = "Monday/Wednesday Group")


# MWQualCode <-dplyr::select(ind_el, Month, Group, QualitativeCode)
# MWQualCode <- filter(MWQualCode, Group == "MW")
# 
# MWQualCode<-table(MWQualCode)
# qualcode2<-as.data.frame(MWQualCode)
# class(qualcode2)
# qualcode2
# 
# q <- ggplot(data = qualcode2, aes(x=reorder(QualitativeCode,Freq), y = Freq, fill=Month))+
#         geom_bar(stat = "identity")
# q
# q + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")
# 
# 
# MWQualCode <-dplyr::select(ind_el, Month, Group, QualitativeCode)
# MWQualCode <- filter(MWQualCode, Group == "MW", Month =="December")
# 
# MWQualCode<-table(MWQualCode)
# qualcode2<-as.data.frame(MWQualCode)
# class(qualcode2)
# 
# q <- ggplot(data = qualcode2, aes(x=reorder(QualitativeCode,Freq), y=Freq,fill="Sky Blue")) +
#         geom_col(position="dodge")
# q + coord_flip() + xlab("Qualitative Code") + ylab("Code Frequency")+ 
#         scale_fill_manual(values = c("December" = "Sky Blue"))

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



