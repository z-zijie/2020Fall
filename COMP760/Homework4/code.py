# Load Data
import pandas as pd
data = pd.read_csv('titanic_data.csv')
Data = data.drop(['Survived'], axis=1).values
Y = data['Survived'].values
feature_name = ['Pclass', 'Sex', 'Age', 'Siblings/Spouses Aboard', 'Parents/Children Aboard', 'Fare']

# One-Hot Encoding
import numpy as np
def One_Hot_Encode(x, j = -1):
    x = x.tolist()
    # Transformation for Pclass
    x[0] = np.identity(3)[int(x[0]-1)].tolist()
    # Transformation for Sex
    x[1] = np.identity(2)[int(x[1])].tolist()
    # Transformation for Age
    bins = np.linspace(0, 81, 5)
    binning = np.digitize(x[2], bins) - 1
    x[2] = np.identity(len(bins)-1)[binning].tolist()
    # Transformation for Siblings/Spouses Aboard
    x[3] = np.identity(9)[int(x[3])].tolist()
    # Transformation for Parents/Children Aboard
    x[4] = np.identity(7)[int(x[4])].tolist()
    # Transformation for Fare
    bins = np.linspace(0, 50, 6).tolist() + np.linspace(70, 520 , 11).tolist()
#     bins = np.linspace(0, 520, 26).tolist()
    binning = np.digitize(x[5], bins) - 1
    x[5] = np.identity(len(bins)-1)[binning].tolist()
    if j >= 0:
        x.pop(j)
    return x
# Encode
DATA = []
for x in Data:
    DATA.append(One_Hot_Encode(x))

import math
# j-feature Entropy on dataset
def Entropy(j, dataset):
    # get the j-th col
    X = np.array([x[j] for x in dataset])
    num = len(X)
    Pr = sum(X)/num
    ans = 0
    for p in Pr:
        if p > 0:
            ans = ans - p * math.log(p)
    return ans
# Entropy of Y
def Entropy_Y(label):
    p = sum(label) / len(label)
    if p == 0 or p == 1:
        return 0
    ans = (1-p) * math.log(1-p) - p * math.log(p)
    return ans

# Split label and dataset with y = val
def Split_Y(val, dataset, label):
    new_Y = []
    new_DATA = []
    for i in range(len(label)):
        if label[i] == val:
            new_DATA.append(dataset[i])
            new_Y.append(label[i])
    return new_Y, new_DATA

# new_Y, new_DATA = Split_Y(0, DATA, Y)
    
# Split dataset with j-th feature = val
def Split(j, val, dataset, label):
    new_Y = []
    new_DATA = []
    for i in range(len(label)):
        if dataset[i][j][val] == 1:
            new_Y.append(label[i])
            new_DATA.append(dataset[i])
    return new_Y, new_DATA

# new_Y, new_DATA = Split(0, 0, DATA, Y)

# Conditional Entropy
def H(j, dataset, label):
    p = sum(label) / len(label)
    if p == 0 or p == 1:
        return 0
    new_Y, new_DATA = Split_Y(0, dataset, label)
    H0 = Entropy(j, new_DATA)
    new_Y, new_DATA = Split_Y(1, dataset, label)
    H1 = Entropy(j, new_DATA)
    ans = (1-p) * H0 + p * H1
    return ans
# Mutual Information
def I(j, dataset, label):
    return Entropy(j, dataset) - H(j, dataset, label)

# List Mutual Information
def List_I(dataset, label):
    LIST = [I(j, dataset, label) for j in range(len(dataset[0]))]
    return LIST

# List_I(DATA, Y)

class Node:
    def __init__(self, index, vals, depth, feature_name):
        self.feature_index = index
        self.values = vals
        self.sub = []
        if index == -1:
            self.predict = vals
        self.depth = depth
        if index >= 0:
#             print(index)
            self.feature_name = feature_name[index]
        else:
            self.feature_name = 'Prediction'

# Build a Tree
def ID3(dataset, label, depth = 0, epsilon = 1e-2, alpha = 0.05, Feature_name = ['Pclass', 'Sex', 'Age', 'Siblings/Spouses Aboard', 'Parents/Children Aboard', 'Fare']):
    # Stop condition
    if Entropy_Y(Y) < epsilon or len(label) < alpha * data.shape[0] or depth >= len(Data[0]) - 1:
#     if Entropy_Y(Y) < epsilon or len(label) < alpha * data.shape[0]:
        p = sum(label) / len(label)
        if p >= 0.5:
            node = Node(-1, 1, depth, Feature_name)
        else:
            node = Node(-1, 0, depth, Feature_name)
        return node
    # Find node feature
    Mutual_Information = List_I(dataset, label)
    j = Mutual_Information.index(max(Mutual_Information))
    vals = len(dataset[0][j])
    node = Node(j, vals, depth, Feature_name)
    # Iterate all subtrees
    for value in range(vals):
        # split data with j-th feature = value
        new_Y, new_DATA = Split(j, value, dataset, label)
        if len(new_Y) == 0:
            node.sub.append(Node(-1, 0, depth, Feature_name))
            continue
        node.sub.append(ID3(new_DATA, new_Y, depth+1, Feature_name = Feature_name))
    return node
T = ID3(DATA, Y, depth = 0)

# Display the Tree
def PrintTree(Tree, indent = ''):
    if Tree.feature_index < 0:
        if Tree.values == 1:
            prediction = 'True'
        else:
            prediction = 'False'
        print(indent+'|'+prediction+'|*')
        return
    print(indent+'|-'+Tree.feature_name+'-|')
    indent = ' ' * (3+len(indent+Tree.feature_name))
    for sub in Tree.sub:
        PrintTree(sub, indent)
    return
PrintTree(T)