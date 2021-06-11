#Import libraries
import pandas as pd
import openpyxl
import xlrd
import matplotlib
import numpy as np
pd.options.display.max_rows = 100

#Read Data
X = pd.ExcelFile("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/grp-edgelist.xlsx")
mindmap_df = X.parse("Individual lists")
grpmindmap_df = X.parse("Group list")


#Data Description
#print(mindmap_df.describe(include='all'))
#print(grpmindmap_df.describe(include='all'))

grouped = mindmap_df.groupby("Month")["Target"]
