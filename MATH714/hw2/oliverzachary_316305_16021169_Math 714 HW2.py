
# coding: utf-8

# In[33]:


get_ipython().run_line_magic('matplotlib', 'inline')
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as integrate


# In[39]:


#Problem B.
def f(x):                
    return np.exp(-400*(x-0.5)**2)   #Here f(x) is defined
x=np.linspace(0,1,1000)
f_exact=f(x)                         #f(x) being solve for a large number of points in the domain
N=1
for n in range(1000):
    h=1/N
    xp=np.arange(0,1+h,h)
    fp=f(xp)
    f_interp=np.interp(x,xp,fp)      #Now f is being calculated as a linear interpolant
    E=abs(f_exact-f_interp)
    Emax=np.amax(E)
    if Emax <= 10**(-2):             #If the max error is lower than 10^-2, then the for loop stops
        print(N)                     #N is printed here based on satisfying the tolerance
        break
    else:
        N+=1


# In[9]:


#Problem C.
N=100         #This code shows the numerical two-step method.
M=25
h=1/(N)
k=1/(M)
x1=np.arange(0,1+h,h)
y1=np.arange(0,1+h,h)
t1=np.arange(0,1+k,k)
U=np.zeros(([N+1,N+1,M+1]))
U[:,:,0]=0                   #The system is initialized at the 0th time step
for i in range(N+1):
    for j in range(N+1):
        U[j,i,1]=k*f(j*h)*f(i*h)  #The system in initialized at the 1st time step
for n in range(2,M+1):
    for j in range(1,N):
        for i in range(1,N):      #Then the two-step method is used for all remaining timesteps.
            U[j,i,n]=2*U[j,i,n-1]-U[j,i,n-2]+k**2/h**2*(U[j-1,i,n-1]+U[j,i-1,n-1]-4*U[j,i,n-1]+U[j+1,i,n-1]+U[j,i+1,n-1])



# In[41]:


#This code represents the analytical solution to the 2D wave equation, which resulted in a double Fourier series

def const(x,y,m,n):
    return np.exp(-400*(x-0.5)**2)*np.exp(-400*(y-0.5)**2)*np.sin(m*np.pi*x)*np.sin(n*np.pi*y)
uexact=np.zeros(([N+1,N+1,M+1]))
for n in range(0,M+1):
    for j in range(0,N+1):
        for i in range(0,N+1):
            for m in range(1,10):
                for h in range(1,10):
                    um=m*np.pi
                    uh=h*np.pi
                    lam=np.sqrt(um**2+uh**2)
                    B=integrate.dblquad(const,0,1,lambda x: 0, lambda x:1,args=(m,n))
                    uexact[j,i,n] += np.sin(um*x1[j])*np.sin(uh*y1[i])*B[0]*np.sin(lam*t1[n])
        


# In[53]:


#This code computes the max norm error between the numerical and analytical solutions.
E=np.zeros(([N+1,N+1,M+1]))
for j in range(N+1):
    for i in range(N+1):
        for n in range(M):
            E[i,j,n]=abs(uexact[j,i,n]-U[j,i,n])
Emax=np.amax(E)


# In[54]:


plt.figure()
x=np.linspace(-4/3,0,100)
f=np.zeros(len(x))
plt.plot(x,f)
plt.axis([-2,2,-2,2])
plt.xlabel('Re')
plt.ylabel('Im')
plt.title('Stability Conditions')
plt.show()

