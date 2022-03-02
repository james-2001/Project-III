from bagging_rate import bagging_rate
from sklearn.datasets import make_classification, load_iris
from numpy import array, mean

iris = load_iris()
data, target = iris.data, iris.target

improvements = array([bagging_rate(data, target) for _ in range(100)])
print(mean(improvements, axis=0))
