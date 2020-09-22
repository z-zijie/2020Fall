import numpy as np
import matplotlib.pyplot as plt

N = 1000
x = []
for i in range(N):
    x.append(np.random.uniform(0,1))

# plot
plt.figure(1)
plt.hist(x, bins=30)
plt.xlabel('Value')
plt.ylabel('Count')
plt.title('Uniform')
# plt.show()

# Generate with p=1/4
p = 1/4
y = []
for i in x:
    if(i<=p):
        y.append(1)
    else:
        y.append(0)
# plot
plt.figure(2)
plt.hist(y, bins=3)
plt.xlabel('Value')
plt.ylabel('Count')
plt.title('p = 1/4')
# plt.show()

# Generate with p=1/2
p = 1/2
y = []
for i in x:
    if(i<=p):
        y.append(1)
    else:
        y.append(0)
# plot
plt.figure(3)
plt.hist(y, bins=3)
plt.xlabel('Value')
plt.ylabel('Count')
plt.title('p = 1/2')
# plt.show()

# Generate with p=3/4
p = 3/4
y = []
for i in x:
    if(i<=p):
        y.append(1)
    else:
        y.append(0)
# plot
plt.figure(4)
plt.hist(y, bins=3)
plt.xlabel('Value')
plt.ylabel('Count')
plt.title('p = 3/4')
# plt.show()

# e
# plot z_k
p = 1/4
y = []
for i in x:
    if(i<=p):
        y.append(1)
    else:
        y.append(0)
z = []
n = 10
m = 100
for i in range(m):
    ans = 0
    for j in range(n):
        ans = ans + y[i*n+j]
    z.append(ans)
# print(z)
# plot
plt.figure(5)
plt.hist(z, range=(0,10))
plt.xlabel('Sum')
plt.ylabel('Num')
plt.title('p = 1/4')

# plot z_k
p = 1/2
y = []
for i in x:
    if(i<=p):
        y.append(1)
    else:
        y.append(0)
z = []
n = 10
m = 100
for i in range(m):
    ans = 0
    for j in range(n):
        ans = ans + y[i*n+j]
    z.append(ans)
# print(z)
# plot
plt.figure(6)
plt.hist(z, range=(0,10))
plt.xlabel('Sum')
plt.ylabel('Num')
plt.title('p = 1/2')

# plot z_k
p = 3/4
y = []
for i in x:
    if(i<=p):
        y.append(1)
    else:
        y.append(0)
z = []
n = 10
m = 100
for i in range(m):
    ans = 0
    for j in range(n):
        ans = ans + y[i*n+j]
    z.append(ans)
# print(z)
# plot
plt.figure(7)
plt.hist(z, range=(0,10))
plt.xlabel('Sum')
plt.ylabel('Num')
plt.title('p = 3/4')


plt.show()
