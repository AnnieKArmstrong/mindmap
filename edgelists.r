#Working from Jesse Sadler's network analysis with R page: 
#https://www.jessesadler.com/post/network-analysis-with-r/


#Load libraries

library(tidyverse)
library(dplyr)

#Load data

mindmap <- readxl::read_excel("~/Github/mindmap/grp-edgelist.xlsx")

#Create edge and node lists

edges <- mindmap %>%
  distinct(Edge) %>%
  rename(label = Edge)

targets <- mindmap %>%
  distinct(Target) %>%
  rename(label = Target)

nodes <- full_join(edges, targets, by = "label")

#Create unique IDs for each node

idnodes <- nodes %>% rowid_to_column("id")
nodes

#Create unique IDs for edges
  



