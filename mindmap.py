#Import packages
import networkx
import pandas as pd
pd.set_option('max_rows', 400)
import matplotlib.pyplot as plt

#https://networkx.org/documentation/stable/reference/classes/generated/networkx.Graph.number_of_nodes.html
#Read in file

mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/decmw.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'decmw.graphml')
#networkx.draw(G)
networkx.write_graphml(G, 'dectth.graphml')
print('decmw', G.number_of_nodes(), G.number_of_edges())
#plt.figure(figsize=(8,8))
#networkx.draw(G, with_labels=True, node_color= 'skyblue', width = .3, font_size=8)

mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/septmw.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'septmw.graphml')
#networkx.draw(G)
#networkx.write_graphml(G, 'dectth.graphml')
print('septmw', G.number_of_nodes(), G.number_of_edges())
#plt.figure(figsize=(8,8))
#networkx.draw(G, with_labels=True, node_color= 'skyblue', width = .3, font_size=8)


mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/dectth.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'dectth.graphml')
print('dectth', G.number_of_nodes(), G.number_of_edges())
#networkx.draw(G)
#plt.figure(figsize=(8,8))
#networkx.draw(G, with_labels=True, node_color= 'skyblue', width = .3, font_size=8)


mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/septtth.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'septth.graphml')
print('septtth', G.number_of_nodes(), G.number_of_edges())
#networkx.draw(G)
#plt.figure(figsize=(8,8))
#networkx.draw(G, with_labels=True, node_color= 'skyblue', width = .3, font_size=8)

#def mindwork(file_name):
    #mindmap_df = pd.read_csv(file_name)
    #G = networkx.from_pandas_edgelist('Edge', 'Target')
    #networkx.write_graphml(G, 'mindmap-networkmw.graphml')
    #networkx.draw(G)
    #plt.figure(figsize=(8,8))
    #networkx.draw(G, with_labels= True, node_color= 'skyblue', width = .3, font_size=8)
    #return

#mindwork("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/decmw.csv")
