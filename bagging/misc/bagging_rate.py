from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import cross_val_score

def bagging_rate(data, target):
    bag = BaggingClassifier(n_estimators=25)

    clf = DecisionTreeClassifier()

    return  [1-cross_val_score(method, data, target, cv = 10).mean()
             for method in (bag, clf)]
