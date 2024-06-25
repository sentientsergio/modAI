import pandas as pd
import os
import subprocess
from xlwt import Workbook
import requests
import json
import time

df = pd.read_excel('Information_Of_Repo.xlsx')
folders = os.listdir('./COBOL_files')\

i = 168

folders = folders[168:]

for repos in folders:
    # Checking if the repo is present in the dataframe
    name_from_df = df['Username'][i][17:]
    name_from_df = name_from_df[:-2]
    name_from_df = name_from_df+"_"+str(df['RepoName'][i])
    
    # print(i,name_from_df,repos)
    if name_from_df == repos:
        # Call def for running API passing url as parameter
        usr_name = df['Username'][i][17:]
        usr_name = usr_name[:-2]
        url = "https://api.github.com/repos/"+usr_name+"/"+df['RepoName'][i]
        response = requests.get(url)
        print(i,response.status_code)
        if response.status_code == 200:
            data = response.json()
            # print(data['license'])
            # print(data['license']['url'])
            if data['license'] == None :
                df['License Name'][i] = "No License"
            else:
                df['License Name'][i] = data['license']['name']
                df['License url'][i] = data['license']['url']
        elif response.status_code == 403:
            print('Rate limit exceeded')
            break
        i = i+1

df.to_excel('Information_Of_Repo.xlsx',index=False)