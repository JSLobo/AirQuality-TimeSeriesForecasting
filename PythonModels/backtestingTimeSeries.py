# -*- coding: utf-8 -*-
"""
@author: JSLobo
"""

#Load Sunspot Dataset

import pandas
#from pandas import Series
from matplotlib import pyplot
#series = Series.from_csv()
series = pandas.read_csv('AirQualityUCI-GT.csv', header=0)
print(series.head(100))
series.plot()
pyplot.show()
'''
series = pandas.read_csv('AirQualityUCI-PT08.csv', header=0)
print(series.head())
series.plot()
pyplot.show()
'''
'''
#Train-Test Split

from pandas import Series
from matplotlib import pyplot
series = Series.from_csv('sunspots.csv', header=0)
X =  series.values
train_size = int(len(X) * 0.66)
train, test = X[0:train_size], X[train_size:len(X)]
print('Observations: %d' %  (len(X)))
print('Training Observations: %d' % (len(train)))
print('Testing Observations: %d' % (len(test)))
pyplot.plot(train)
pyplot.plot([None for i in train] + [x for x in test])
pyplot.show()
'''
#Multiple Train-Test Splits

#training_size = i * n_samples / (n_splits + 1) + n_samples % (n_splits + 1)
#test_size = n_samples / (n_splits + 1)
'''
n_samples = len(X)
n_splits = 2


train = i * n_samples / (n_splits + 1) + n_samples % (n_splits + 1)
train = 1 * 100 / (2 + 1) + 100 % (2 + 1)
train = 33.3 or 33

test = n_samples / (n_splits + 1)
test = 100 / (2 + 1)
test = 33.3 or 33

train = i * n_samples / (n_splits + 1) + n_samples % (n_splits + 1)
train = 2 * 100 / (2 + 1) + 100 % (2 + 1)
train = 66.6 or 67

test = n_samples / (n_splits + 1)
test = 100 / (2 + 1)
test = 33.3 or 33
'''

import pandas
#from pandas import Series
from sklearn.model_selection import TimeSeriesSplit
from matplotlib import pyplot
series = pandas.read_csv('AirQualityUCI-GT.csv', header=0)
X = series.values
splits = TimeSeriesSplit(n_splits=3)
pyplot.figure(1)
index = 1
for train_index, test_index in splits.split(X):
    train = X[train_index]
    test = X[test_index]
    print('Observations: %d' % (len(train) + len(test)))
    print('Training Observations: %d' % (len(train)))
    print('Testing Observations: %d' % (len(test)))
    pyplot.subplot(310 + index)
    pyplot.plot(train)
    pyplot.plot([None for i in train] + [x for x in test])
    index += 1
pyplot.show()

'''
#Walk Forward Validation

from pandas import Series
from matplotlib import pyplot
series = Series.from_csv('sunspots.csv', header=0)
X = series.values
n_train = 500
n_records = len(X)
for i in range(n_train, n_records):
	train, test = X[0:i], X[i:i+1]
	print('train=%d, test=%d' % (len(train), len(test)))
    '''