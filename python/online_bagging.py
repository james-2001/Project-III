from numpy.random import poisson
from sklearn.tree import DecisionTreeClassifier
from sklearn.datasets import make_classification
from statistics import mode


class OnlineBaggingClassifier:
    def __init__(self, n_estimators=25) -> None:
        self.r = n_estimators
        self.estimators = []
        self.bagged_data = [{"Data": [], "Target": []}*n_estimators]

    def online_bag(self, data, target):
        for i in range(len(target)):
            self.process(data[i], target[i])
        self.estimators = [DecisionTreeClassifier().fit(x["data"], x["target"])
                           for x in self.bagged_data]

    def process(self, d, t):
        for i in range(self.r):
            k = poisson()
            self.bagged_data[i]["data"] += k*[d]
            self.bagged_data[i]["target"] += k*[t]

    def ob_predict(self, d):
        predictions = [phi.predict(d) for phi in self.estimators]
        return [mode([phi[i] for phi in predictions])
                for i in range(len(d))]

    def score(self, d, t):
        n = len(t)
        predictions = self.ob_predict(d)
        return sum([predictions[i] != t[i] for i in range(n)])/n


if __name__ == "__main__":
    d, t = make_classification()
    online_bag = OnlineBaggingClassifier()
