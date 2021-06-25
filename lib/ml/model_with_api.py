# -*- coding: utf-8 -*-
"""
Created on Fri Jun 25 02:31:24 2021

@author: hzasd
"""

import surprise
from surprise import KNNBasic
from surprise import Dataset
from surprise import Reader

from collections import defaultdict
from operator import itemgetter
import heapq
import os
import csv

def load_dataset():
    reader = Reader(line_format='user item rating timestamp', sep=',', skip_lines=1)
    ratings_dataset = Dataset.load_from_file('ml-latest-small/ratings.csv', reader=reader)

    # Lookup a movie's name with it's Movielens ID as key
    movieID_to_name = {}
    with open('ml-latest-small/movies.csv', newline='', encoding='ISO-8859-1') as csvfile:
            movie_reader = csv.reader(csvfile)
            next(movie_reader)
            for row in movie_reader:
                movieID = row[0]
                #int(row[0]
                movie_name = row[1]
                movieID_to_name[movieID] = movie_name
    # Return both the dataset and lookup dict in tuple
    return (ratings_dataset, movieID_to_name)

dataset, movieID_to_name = load_dataset()

# Build a full Surprise training set from dataset
trainset = dataset.build_full_trainset()


similarity_matrix = KNNBasic(sim_options={
        'name': 'cosine',
        'user_based': False
        })\
        .fit(trainset)\
        .compute_similarities()
        
        
        # Pick a random user ID, has to be a numeric string.
# Play around and see how the final recommendations change
# depending on the user! 1-610


from flask import Flask, jsonify, request #import objects from the Flask model
app = Flask(__name__) #define app using Flask


@app.route('/lang', methods=['Post'])
def addOne():
    userId =  request.json["userId"]
    print(userId)
    test_subject = userId

# Get the top K items user rated
    k = 20
    
    
    test_subject_iid = trainset.to_inner_uid(test_subject)
    
    # Get the top K items we rated
    test_subject_ratings = trainset.ur[test_subject_iid]
    k_neighbors = heapq.nlargest(k, test_subject_ratings, key=lambda t: t[1])
    
    
    
    candidates = defaultdict(float)
    
    for itemID, rating in k_neighbors:
        try:
          similaritities = similarity_matrix[itemID]
          for innerID, score in enumerate(similaritities):
              candidates[innerID] += score * (rating / 5.0)
        except:
          continue
      
        
    def getMovieName(movieID):
      if movieID in movieID_to_name:
        #int(movieID)
        return movieID_to_name[movieID]
        #int(movieID)
      else:
          return ""
      
        
    watched = {}
    for itemID, rating in trainset.ur[test_subject_iid]:
      watched[itemID] = 1
    
    # Add items to list of user's recommendations
    # If they are similar to their favorite movies,
    # AND have not already been watched.
    recommendations = []
    
    position = 0
    for itemID, rating_sum in sorted(candidates.items(), key=itemgetter(1), reverse=True):
      if not itemID in watched:
        recommendations.append(getMovieName(trainset.to_raw_iid(itemID)))
        position += 1
        if (position > 10): break # We only want top 10
    
    for rec in recommendations:
      print("Movie: ", rec)


    return jsonify({'recommendations' : recommendations})

if __name__ == '__main__':
	app.run(debug=True, port=5050) #run app on port 8080 in debug mode


