import pandas as pd
import numpy as np
import math

#import data
data = pd.read_csv('titanic_data.csv')
y_label = data['Survived'].to_numpy()
X = data.drop(['Survived'], axis=1).to_numpy()
N, D = X.shape
X = np.append(np.array([[1] for i in range(N)]), X, axis=1)
N, D = X.shape

def dot(theta, X, i):
    N, D = X.shape
    ans = 0
    for j in range(D):
        ans = ans + theta[j]*X[i,j]
    return ans

def l(theta, X):
    ans = 0
    N, D = X.shape
    for i in range(N):
        ans = ans         -y_label[i]*math.log(1+math.exp(-dot(theta, X, i)))        -(1-y_label[i])*math.log(1+math.exp(dot(theta, X, i)))
    return ans

def nabla_l(theta, X):
    N, D = X.shape
    ans = np.zeros(D)
    for i in range(N):
        ans = ans +         (y_label[i] - 1/(1+math.exp(-dot(theta, X, i)))) * X[i,]
    return ans

def hessian(theta, X):
    N, D = X.shape
    ans = np.zeros((D,D))
    for i in range(N):
        ans = ans\
        - np.dot(np.asmatrix(X[i,]).T, np.asmatrix(X[i,]))\
        * math.exp(-dot(theta, X, i))/ (1+math.exp(-dot(theta, X, i)))**2
    return ans

def GradientAscent(theta, X, epsilon):
    k = 1
    nabla = nabla_l(theta, X)
    nabla_norm = np.linalg.norm(nabla)
    print("k = ", k, "\n\ttheta = ", theta)
    print("\tnabla_norm = ", nabla_norm, "\n")
    while nabla_norm > epsilon:
        k=k+1
        Hessian = hessian(theta, X)
        alpha = np.dot(np.linalg.inv(Hessian), nabla)
        theta = theta - np.array(alpha)[0]
        nabla = nabla_l(theta, X)
        nabla_norm = np.linalg.norm(nabla)
        print("k = ", k, "\n\ttheta = ", theta)
        print("\tnabla_norm = ", nabla_norm, "\n")
    return theta

# init parameter
N, D = X.shape
theta = np.array([0 for i in range(D)])
epsilon = 1e-12

# fit
theta = GradientAscent(theta, X, epsilon)
print("l(theta) = ", l(theta, X))