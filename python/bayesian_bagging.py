from sklearn import tree
from numpy import array
from sklearn.datasets import load_iris
from bayesian_boot import generate_samples
from scipy.stats import mode

iris = load_iris()
data, targets = iris.data, iris.target

clf = tree.DecisionTreeClassifier()
clf = clf.fit(data, targets)

resamples = generate_samples(data, 25)
bagging = [tree.DecisionTreeClassifier().fit(boot, targets)
           for boot in resamples]

bagging_test = array([phi.predict(data) for phi in bagging])
bagging_test = mode(bagging_test).mode.flatten()
bagging_misclass = sum([bagging_test[i]!=targets[i] for i in range(len(targets))])
print(bagging_misclass/len(targets))