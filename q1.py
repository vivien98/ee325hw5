import numpy as np
import math

k = 3
m = 100000
mu = 0.1


def generateBern(numTrials,tossesInTrial,X):
	for i in range(0,numTrials):
	 	for j in range(0,tossesInTrial):
	 		U = np.random.uniform()
	 		if U < mu:
	 			X[i][j] = 0
	 		else :
	 			X[i][j] = 1
	

def pmf(numTrials,tossesInTrial,X,mf):
	
	for i in range(0,numTrials):
	 	index = 0;
	 	for j in range(0,tossesInTrial):
	 		index += (2**j)*(X[i][j])
	 	mf[index]+=1

	for i in range(0,2**tossesInTrial):
		mf[i] = mf[i]/(numTrials)
	return mf

def printPmf(p,numTrials):
	print(p)
	
	print('\n')

X_1 = np.zeros((m,k),dtype = np.int)
generateBern(m,k,X_1)
PMF = np.zeros(2**k)
pmf(m,k,X_1,PMF)
printPmf(PMF,m)
