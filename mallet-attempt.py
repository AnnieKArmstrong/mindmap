#Path to mallet
path_to_mallet = 'C:/mallet/bin/mallet'

#Import libraries
import little_mallet_wrapper
import seaborn
import glob
from pathlib import Path
import pandas as pd
import random
import numpy as np

#Set directory
directory = "C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists"

files = glob.glob(f"{directory}/*.csv")

septmw_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/septmwnew.csv")
decmw_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/decmw.csv")
septtth_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/septtth.csv")
dectth_df = pd.read_csv("C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists/dectth.csv")

#concatenate

horizontal_concat = pd.concat([septmw_df, decmw_df, septtth_df, dectth_df])
print(horizontal_concat)

#Process Texts

training_data = [little_mallet_wrapper.process_string(text, numbers='remove') for text in horizontal_concat['Edge']]
original_texts = [text for text in horizontal_concat['Edge']]

targets = [target for target in horizontal_concat['Target']]

#Dataset statistics

little_mallet_wrapper.print_dataset_stats(training_data)

#Train topic model

num_topics = 15

training_data = training_data

#Set other Mallet file paths

output_directory_path = "C:/Users/Annie Armstrong/Documents/Github/mindmap/grp_edgelists"

Path(f"{output_directory_path}").mkdir(parents = True, exist_ok = True)

path_to_training_data           = f"{output_directory_path}/training.txt"
path_to_formatted_training_data = f"{output_directory_path}/mallet.training"
path_to_model                   = f"{output_directory_path}/mallet.model.{str(num_topics)}"
path_to_topic_keys              = f"{output_directory_path}/mallet.topic_keys.{str(num_topics)}"
path_to_topic_distributions     = f"{output_directory_path}/mallet.topic_distributions.{str(num_topics)}"
path_to_word_weights            = f"{output_directory_path}/path_to_word_weights.{str(num_topics)}"
path_to_diagnostics             = f"{output_directory_path}/topic_diagnostics.{str(num_topics)}"

#Import Dataset

little_mallet_wrapper.import_data(path_to_mallet,
                path_to_training_data,
                path_to_formatted_training_data,
                training_data)

little_mallet_wrapper.train_topic_model(path_to_mallet,
                      path_to_formatted_training_data,
                      path_to_model,
                      path_to_topic_keys,
                      path_to_topic_distributions,
                      path_to_word_weights,
                      path_to_diagnostics,
                      num_topics)

#Display Topics and Top Words

#topics = little_mallet_wrapper.load_topic_keys(path_to_topic_keys)

#topics = little_mallet_wrapper.load_topic_keys(path_to_topic_keys)

#for topic_number, topic in enumerate(topics):
    #print(f"✨Topic {topic_number}✨\n\n{topic}\n")
