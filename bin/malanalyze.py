#!/usr/bin/env python3
from bs4 import BeautifulSoup
import matplotlib.pyplot as plt

recommenders = dict()
averages = dict()
with open("animelist.xml") as file:
    soup = BeautifulSoup(file, "xml")

for show in soup.find_all("anime"):
    tags = show.my_tags.string
    score = show.my_score.string
    title = show.series_title.string

    # empty tags are " ", not "" for whatever reason
    if tags != " " and score != "0":
        for tag in tags.split(","):
            if "rec:" in tag:
                recommender = tag.split(":")[1]
                if recommender not in recommenders:
                    recommenders[recommender] = list()
                recommenders[recommender].append(int(score))

# update values for recommenders to the an average instead of a set of scores
for recommender, scores in recommenders.items():
    averages[recommender] = sum(scores) / len(scores)
print(recommenders)
print(averages)
