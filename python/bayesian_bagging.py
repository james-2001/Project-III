from sklearn import tree
from numpy import array
from numpy.random import choice, dirichlet
from sklearn.datasets import make_classification

data, target = make_classification()
r=50
n=len(target)

bb_samples = array([array(list(zip(data,target)), dtype=object)[list(choice(range(n), size = n, p = dirichlet([1]*n)))] for _ in range(25)])
bagged_trees = [tree.DecisionTreeClassifier().fit(sample[:,0],sample[:,1]) for sample in bb_samples]

