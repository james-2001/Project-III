from random import shuffle
from statistics import mean
from online_bagging import OnlineBaggingClassifier
from online_bayes_bagging import OnlineBayesianBaggingClassifier
from bayesian_bagging import BayesianBaggingClassifier
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
    print(loader.__name__)
    if loader is make_classification:
        data, target = loader()
    else:
        full = loader()
        data, target = full.data, full.target
    d_learn, t_learn, d_train, t_train = split_data(data, target)
    for method in [OnlineBaggingClassifier,
                   BayesianBaggingClassifier,
                   BaggingClassifier,
                   OnlineBayesianBaggingClassifier]:
        scores=[]
        for _ in range(100):
            clf = method(n_estimators=25)
            clf.fit(d_learn, t_learn)
            scores.append(clf.score(d_train, t_train))
        print(f"{method.__name__}:{mean(scores)}")
    scores=[]
    for _ in range(100):
        clf = DecisionTreeClassifier().fit(d_learn, t_learn)
        scores.append(clf.score(d_train, t_train))
    print(f"Normal:{mean(scores)}")
    print("\n")
