#!/usr/bin/env python3
# coding: utf-8

#Imports
import pandas as pd

#Read in raw aggregated log file
df = pd.read_json("./logs/shop_log.jsonl", lines=True)

#Write out data to CSV
#df[df.columns.difference(['timestamp'])].to_csv('./logs/processed_logs.csv')
df.to_csv("./logs/processed_logs.csv", index=False)


