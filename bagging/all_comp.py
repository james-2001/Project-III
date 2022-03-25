from random import shuffle
from statistics import mean
from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.datasets import load_wine, load_digits, load_iris, make_classification
from online_bagging import OnlineBaggingClassifier
from online_bayes_bagging import OnlineBayesianBaggingClassifier
from bayesian_bagging import BayesianBaggingClassifier


def split_data(d, t):
    full = list(zip(d, t))
    shuffle(full)
    d, t = zip(*full)
    n = len(t)*2//3
    return d[:n], t[:n], d[n:], t[n:]


for loader in [load_iris]:
    m = 500
    print(loader.__name__)
    if loader is make_classification:
        data, target = loader()
    else:
        full = loader()
        data, target = full.data, full.target
    d_learn, t_learn, d_train, t_train = split_data(data, target)
    
    clf = [BaggingClassifier(n_estimators=25).fit(d_learn,t_learn) for _ in range(m)]
    print(f"Bagging:{mean([1-phi.score(d_train, t_train) for phi in clf])}")

    scores = []
    for _ in range(m):
        clf = BayesianBaggingClassifier(n_estimators=25)
        clf.fit(d_learn, t_learn)
        scores.append(1-clf.score(d_train, t_train))
    print(f"Bayes Bag:{mean(scores)}")
    
    scores=[]
    for _ in range(m):
        clf = OnlineBaggingClassifier(n_estimators=25)
        clf.online_fit(d_learn, t_learn)
        scores.append(1-clf.score(d_train, t_train))
    print(f"Online: {mean(scores)}")

    scores=[]
    for _ in range(m):
        clf = OnlineBayesianBaggingClassifier(n_estimators=25)
        clf.online_fit(d_learn, t_learn)
        scores.append(1-clf.score(d_train, t_train))
    print(f"Online Bayes: {mean(scores)}")

    scores=[]
    for _ in range(m):
        clf = DecisionTreeClassifier().fit(d_learn, t_learn)
        scores.append(1-clf.score(d_train, t_train))
    print(f"Normal:{mean(scores)}")
    print("\n")
