from sklearn import tree
from numpy import array, append
from numpy.random import choice, dirichlet
from sklearn.datasets import make_classification
from sklearn.ensemble import BaggingClassifier

data, target = make_classification()
r=2
n=len(target)

# bb_data  = []
# bb_target = []
# for i in range(r):
#     weights = dirichlet([1]*n)
#     sample_indexs = choice(range(n), size = n, p=weights)    
#     bb_data.append(array(data)[sample_indexs])
#     bb_target.append(array(target)[sample_indexs])

# bagged_trees = [tree.DecisionTreeClassifier().fit(bb_data[i], bb_target[i]) for i in range(r)]

bag = BaggingClassifier(n_estimators=25).fit(data,target,sample_weight=dirichlet([1]*n)) #do you want new dir samples each time?