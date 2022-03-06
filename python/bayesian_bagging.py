from numpy import array_split, array, delete, partition
import numpy as np
from sklearn.tree import DecisionTreeClassifier
from numpy.random import dirichlet
from statistics import mode 
from sklearn.datasets import make_classification, load_digits

class BayesianBaggingClassifier:
    def __init__(self, n_estimators) -> None:
        self.data = []
        self.target = []
        self.r = n_estimators
        self.estimators = []
        self.n = len(self.target)

    def fit(self, data, target):
        self.estimators = self.local_fit(data, target)
        self.data = data
        self.target = target
        self.n = len(self.target)

    def local_fit(self, data, target):
        loc_n = len(target)
        bag = [DecisionTreeClassifier().fit(data, target, sample_weight=weight)
               for weight in dirichlet([1]*loc_n, self.r)]
        return bag

    def bb_predict(self, new_data, bag = None):
        if bag is None:
            bag = self.estimators
        predictions = [phi.predict(new_data) for phi in bag]
        return [mode([phi[i] for phi in predictions]) for i in range(len(new_data))]

    def cross_val(self, data, target, cv = 10):
        scores = []
        n = len(target)
        for i in range(n//cv):
            learning_data = list(data)[:i*cv]+list(data)[min(cv*(i+1),n):]
            learning_targets = list(target)[:i*cv]+list(target)[min(cv*(i+1),n):]
            training_data = data[i*cv:min((i+1)*cv, n)]
            training_targets = target[i*cv:min((i+1)*cv, n)]
            bag = self.local_fit(data=learning_data, target=learning_targets)
            cv_predict = self.bb_predict(training_data, bag)
            scores.append(sum([cv_predict[i]!=training_targets[i] for i in range(len(training_targets))])/len(training_targets))
        return sum(scores)/cv
    
    def score(self, t_data, t_target):
        n=len(t_target)
        preds = self.bb_predict(t_data)
        return sum([preds[i]!=t_target[i] for i in range(n)])/n
            

if __name__ == "__main__":
    d,t = make_classification()
    dl, tl = d[:30], t[:30]
    dt,tt = d[30:], t[30:]
    print(len(t))
    bag = BayesianBaggingClassifier(n_estimators=25)
    bag.fit(dl,tl)
    print(bag.score(dt,tt))