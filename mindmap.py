import networkx
import pandas as pd
pd.set_option('max_rows', 400)
import matplotlib.pyplot as plt
#Read in file

mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/decmw.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'decmw.graphml')
networkx.draw(G)
plt.figure(figsize=(8,8))
networkx.draw(G, with_labels= True, node_color= 'skyblue', width = .3, font_size=8)

mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/septmw.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'septmw.graphml')
networkx.draw(G)
plt.figure(figsize=(8,8))
networkx.draw(G, with_labels= True, node_color= 'skyblue', width = .3, font_size=8)

mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/dectth.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'dectth.graphml')
networkx.draw(G)
plt.figure(figsize=(8,8))
networkx.draw(G, with_labels= True, node_color= 'skyblue', width = .3, font_size=8)

mindmap_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/septtth.csv")
G = networkx.from_pandas_edgelist(mindmap_df, 'Edge', 'Target')
networkx.write_graphml(G, 'septth.graphml')
networkx.draw(G)
plt.figure(figsize=(8,8))
networkx.draw(G, with_labels= True, node_color= 'skyblue', width = .3, font_size=8)

#def mindwork(file_name):
    #mindmap_df = pd.read_csv(file_name)
    #G = networkx.from_pandas_edgelist('Edge', 'Target')
    #networkx.write_graphml(G, 'mindmap-networkmw.graphml')
    #networkx.draw(G)
    #plt.figure(figsize=(8,8))
    #networkx.draw(G, with_labels= True, node_color= 'skyblue', width = .3, font_size=8)
    #return

#mindwork("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/decmw.csv")
