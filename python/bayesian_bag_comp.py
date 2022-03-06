from bayesian_bagging import BayesianBaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import BaggingClassifier
from sklearn.datasets import make_classification, load_iris, load_digits, load_wine
from random import shuffle
from sklearn.model_selection import cross_val_score

for loader in [make_classification, load_iris, load_wine, load_digits]:
    n=500
    if loader is make_classification:
        data, target = loader()
    else:
        full = loader()
        data, target = full.data, full.target
    aggregate = list(zip(data,target))
    shuffle(aggregate)
    l_ag, t_ag = aggregate[:int(len(data)*2/3)], aggregate[int(len(data)*2/3):]
    l_data, l_target = zip(*l_ag)
    t_data, t_target = zip(*t_ag)

    normal = sum([1-DecisionTreeClassifier().fit(l_data, l_target).score(t_data, t_target) for _ in range(n)])/n
    bag = sum([1-BaggingClassifier(n_estimators=25).fit(l_data,l_target).score(t_data, t_target) for _ in range(n)])/n
    b_bag = []
    for _ in range(n):
        b = BayesianBaggingClassifier(n_estimators=25)
        b.fit(l_data,l_target)
        b_bag.append(b.score(t_data, t_target))
    b_bag = sum(b_bag)/n
    print(f"{loader.__name__}:\n\nNormal:{normal}\nBagging:{bag}\nBayesian: {b_bag}\n\n")