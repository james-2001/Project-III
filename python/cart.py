from sklearn.datasets import load_iris
from sklearn import tree
from sklearn.utils import resample
from scipy.stats import mode
from numpy import array
import random

iris = load_iris()

data, klass = iris.data, iris.target

iris = list(zip(data,klass))
random.shuffle(iris)
data, klass = zip(*iris)

learning_data, learning_class = data[int(2/3*len(data)):], klass[int(2/3*len(data)):]
training_data, training_class = data[:int(2/3*len(data))], klass[:int(2/3*len(data))]


clf = tree.DecisionTreeClassifier()
clf = clf.fit(learning_data, learning_class)
train_test = clf.predict(training_data)


misclassified = sum([train_test[i]!=training_class[i] for i in range(len(train_test))])
print(misclassified/len(train_test))

bagging = []
boot = [resample(list(zip(learning_data, learning_class))) for _ in range(25)]
for bs_sample in boot:
    bs_data = [x[0] for x in bs_sample]
    bs_class = [x[1] for x in bs_sample]
    bs_clf = tree.DecisionTreeClassifier()
    bagging.append(bs_clf.fit(bs_data, bs_class))

bs_test_full = array([phi.predict(training_data) for phi in bagging])
bs_test = mode(bs_test_full, axis =0).mode.flatten()
bs_misclass = sum([bs_test[i]!=training_class[i] for i in range(len(training_class))])
print(bs_misclass/len(training_class))
