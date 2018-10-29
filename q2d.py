import numpy as np
import math

lam1 = 0.5
lam2 = 0.5
lam12 = 0.2
N = 10000

def generateExp(lamda):
	U = np.random.uniform()
	x = -(math.log(1 - U))/lamda
	return x

def generateSample(l1,l2,l12):
	y1=0.0
	y2=0.0
	y12=0.0
	y1 = generateExp(l1)
	y2 = generateExp(l2)
	y12 = generateExp(l12)
	x1 = min(y1,y12)
	x2 = min(y2,y12)
	return (x1,x2)

def generateSamples(numSamp,samples,l1,l2,l12):

	for i in range(0,numSamp):
		samples[i] = generateSample(l1,l2,l12)

def cdf(x1,x2,samples,numSamp):
	count = 0.0
	for i in range(0,numSamp):
		if samples[i][0]>x1 and samples[i][1]>x2:
			count += 1.0

	count = count/numSamp
	return count

x1 = 1.0
x2 = 4.0
realCdf = math.exp(-lam1*x1-lam2*x2-lam12*max(x1,x2))
samp = np.zeros((N,2))
prob = 0.0
generateSamples(N,samp,lam1,lam2,lam12)
prob = cdf(x1,x2,samp,N)

print(prob)
print(realCdf)
