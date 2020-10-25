import pandas as pd
import numpy as np
import math
import scipy.stats as st

# Load dataset
data = pd.read_csv('titanic_data.csv')
print(data.describe())

print('- - - - - - - - - - - - - - - - - - - -')

# Variable transform
CATEGORICAL_FEATURES = ['Pclass', 'Sex', 'Siblings/Spouses Aboard', 'Parents/Children Aboard']
NUMERICAL_FEATURES = ['Age', 'Fare']
for feature_name in CATEGORICAL_FEATURES:
    data = data.join(pd.get_dummies(data[feature_name], prefix=feature_name))
    data.drop([feature_name], axis = 1, inplace=True)
for feature_name in NUMERICAL_FEATURES:
    data = data.join(pd.get_dummies(pd.qcut(data[feature_name], 5), prefix=feature_name))
    data.drop([feature_name], axis = 1, inplace=True)
print('First, I divided these six features into two categories.')
print('CATEGORICAL_FEATURES and NUMERICAL_FEATURES')
print('For CATEGORICAL_FEATURES, I directly convert it to one-hot encoding.')
print('For NUMERICAL_FEATURES, binning the data and then convert it to one-hot encoding.')
print(data.describe())

print('- - - - - - - - - - - - - - - - - - - -')


