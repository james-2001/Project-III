from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import cross_val_score
from sklearn.datasets import make_classification

def bagging_rate(data, target):
    bag = BaggingClassifier(n_estimators=25)
    bag = bag.fit(data, target)

    clf = DecisionTreeClassifier()
    clf = clf.fit(data, target)

    return  [cross_val_score(method, data, target, cv = 10).mean()
             for method in (bag, clf)]
