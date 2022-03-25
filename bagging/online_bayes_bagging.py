from random import shuffle
from online_bagging import OnlineBaggingClassifier
from sklearn.tree import DecisionTreeClassifier
from numpy.random import exponential
from sklearn.datasets import make_classification


class OnlineBayesianBaggingClassifier(OnlineBaggingClassifier):
    def __init__(self, n_estimators=25) -> None:
        super().__init__(n_estimators)
        self.bagged_data = [{"data": [], "target": [], "weight": []}
                            for _ in range(n_estimators)]

    def online_fit(self, data, target):
        for i in range(len(target)):
            self.process(data[i], target[i])
        self.estimators = [DecisionTreeClassifier().fit(x["data"], x["target"],
                           sample_weight=x["weight"])
                           for x in self.bagged_data]

    def process(self, d, t):
        for i in range(self.r):
            k = exponential()
            self.bagged_data[i]["data"] += [d]
            self.bagged_data[i]["target"] += [t]
            self.bagged_data[i]["weight"] += [k]


if __name__ == "__main__":
    d, t = make_classification(n_samples=300)
    full = list(zip(d, t))
    shuffle(full)
    d, t = zip(*full)
    d_learn, t_learn = d[:210], t[:210]
    d_train, t_train = d[210:], t[210:]
    bbag = OnlineBayesianBaggingClassifier()
    bbag.fit(d_learn, t_learn)
    print(bbag.score(d_train, t_train))
    bag = OnlineBaggingClassifier()
    bag.fit(d_learn, t_learn)
    print(bag.score(d_train, t_train))
