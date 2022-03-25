from sklearn.tree import DecisionTreeClassifier
from numpy.random import dirichlet, exponential, seed
from statistics import mode
from sklearn.datasets import load_wine, make_classification, load_iris
from random import shuffle

class BayesianBaggingClassifier:
    def __init__(self, n_estimators=25) -> None:
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


    def bb_predict(self, new_data, bag=None):
        if bag is None:
            bag = self.estimators
        predictions = [phi.predict(new_data) for phi in bag]
        return [mode([phi[i] for phi in predictions])
                for i in range(len(new_data))]

    def cross_val(self, data, target, cv=10):
        scores = []
        n = len(target)
        for i in range(n//cv):
            learning_data = list(data)[:i*cv]+list(data)[min(cv*(i+1), n):]
            learning_targets = list(target)[:i*cv]+list(target)[min(cv*(i+1),
                                                                    n):]
            training_data = data[i*cv:min((i+1)*cv, n)]
            training_targets = target[i*cv:min((i+1)*cv, n)]
            bag = self.local_fit(data=learning_data, target=learning_targets)
            cv_predict = self.bb_predict(training_data, bag)
            scores.append(sum([cv_predict[i] != training_targets[i]
                               for i in range(len(training_targets))])/len(
                               training_targets))
        return sum(scores)/cv

    def score(self, t_data, t_target):
        n = len(t_target)
        preds = self.bb_predict(t_data)
        return sum([preds[i] == t_target[i] for i in range(n)])/n


if __name__ == "__main__":
    iris = load_wine()
    d,t = iris.data, iris.target
    f = list(zip(d,t))
    shuffle(f)
    d,t = zip(*f)
    d_l, t_l, d_t, t_t = d[:100], t[:100], d[100:], t[100:]
    bag = BayesianBaggingClassifier()
    bag.fit(d_l, t_l)
    print(bag.score(d_t,t_t))
    clf = DecisionTreeClassifier().fit(d_l, t_l)
    print(clf.score(d_t, t_t))

