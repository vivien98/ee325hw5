import numpy as np
import math
import matplotlib.pyplot as pl

lam = 0.5
m = 0.7




def slot(qLength,lamda,mu,slotNum,arr,dep):
	U = np.random.uniform()
	V = np.random.uniform()
	arrival= 0
	leng = 0
	if slotNum == 0:
		leng = 0
	else:
		leng = qLength[-1]
		qLength.append(leng)
	if U < lamda :
		leng += 1
		qLength[-1] += 1
		arr.append(slotNum)
		arrival = 1
	if V < mu and ((leng>0 and arrival==0) or (leng-1>0 and arrival==1)) and (not (slotNum==0)) :
		leng -= 1
		qLength[-1] -= 1
		dep.append(slotNum)

def runQueueGivenMaxSlot(maxSlotNum,qLength,timeSpent,lamda,mu):
	arr = []
	dep = []
	for i in range(0,maxSlotNum):
		slot(qLength,lamda,mu,i,arr,dep)
	for i in range(0,len(dep)):
		timeSpent.append(dep[i] - arr[i])
	#print(arr)
	#print(dep)

def runQueueGivenMaxDep(maxDepNum,qLength,timeSpent,lamda,mu):
	arr = []
	dep = []
	slotnum = 0
	while len(dep)<maxDepNum: 
		slot(qLength,lamda,mu,slotnum,arr,dep)
		slotnum+=1
	for i in range(0,len(dep)):
		timeSpent.append(dep[i] - arr[i])
	#print(arr)
	#print(dep)

def getQueueLenMean(lamda,mu,numSamplePaths,maxTime):
	
	sum1 = np.zeros(maxTime)
	for i in range(0,numSamplePaths):
		qlen = [0]
		timesp = []
		runQueueGivenMaxSlot(maxTime,qlen,timesp,lamda,mu)
		sum1 += qlen
	sum1 = sum1/numSamplePaths
	return sum1

def getTimeSpentMean(lamda,mu,numSamplePaths,maxDep):
	
	sum1 = np.zeros(maxDep)
	for i in range(0,numSamplePaths):
		qlen = [0]
		timesp = []
		runQueueGivenMaxDep(maxDep,qlen,timesp,lamda,mu)
		sum1 += timesp
	sum1 = sum1/numSamplePaths
	return sum1

def getTimeAverage(qLength):
	avgLen = 0.0
	for i in range(0,len(qLength)):
		avgLen += qLength[i]
	avgLen/=len(qLength)
	return avgLen




numSamplePaths = 100
maxTime = 1000
maxDep = 1000
'''
q = [0]
tsp = []
runQueueGivenMaxDep(maxDep,q,tsp,lam,m)
print(q)
print(tsp)
pl.plot(q)
pl.show()
pl.plot(tsp)
pl.show()
'''
meanQLen = np.zeros(maxTime)
meanQLen = getQueueLenMean(lam,m,numSamplePaths,maxTime)
meanTimeSpent = getTimeSpentMean(lam,m,numSamplePaths,maxDep)
#print(meanQLen)
pl.plot(meanQLen)
pl.show()
#print(meanTimeSpent)
pl.plot(meanTimeSpent)
pl.show()
avgW=0.0
avgQ=0.0
avgW = getTimeAverage(meanTimeSpent)
avgQ = getTimeAverage(meanQLen)

print("Average q size over time: " + '%.3f'%avgQ)
print("Average time spent in q: " + '%.3f'%avgW)

