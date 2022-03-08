from random import shuffle
from python.classes.online_bagging import OnlineBaggingClassifier
from python.classes.online_bayes_bagging import OnlineBayesianBaggingClassifier
from python.classes.bayesian_bagging import BayesianBaggingClassifier
from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.datasets import load_wine, load_digits, load_iris, make_classification


def split_data(d, t):
    full = list(zip(d, t))
    shuffle(full)
    d, t = zip(*full)
    n = len(t)*2//3
    return d[:n], t[:n], d[n:], t[n:]


for loader in [load_wine, load_digits, load_iris, make_classification]:
    if loader is make_classification:
        data, target = loader()
    else:
        full = loader()
        data, target = full.data, full.target
    d_learn, t_learn, d_train, t_train = split_data(data, target)
    