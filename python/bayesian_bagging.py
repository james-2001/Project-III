from numpy import array_split, array, delete
from sklearn.tree import DecisionTreeClassifier
from numpy.random import dirichlet
from statistics import mode 
from sklearn.datasets import make_classification

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

    def local_fit(self, data, target):
        self.n = len(target)
        bag = [DecisionTreeClassifier().fit(data, target, sample_weight=weight)
               for weight in dirichlet([1]*self.n, self.r)]
        return bag

    def bb_predict(self, new_data, bag = None):
        if bag is None:
            bag = self.estimators
        predictions = [phi.predict(new_data) for phi in bag]
        return [mode([phi[i] for phi in predictions]) for i in range(len(new_data))]

    def cross_val(self, cv = 10):
        partition = array_split(array(list(zip(self.data, self.target))), cv)
        scores = []
        for i in range(cv):
            learning_data, learning_targets = zip(*self.flatten(delete(partition, i)))
            training_data, training_targets = zip(*partition[i])
            bag = self.fit(learning_data, learning_targets, local = True)
            cv_predict = self.bb_predict(training_data, bag)
            scores.append(sum([cv_predict[i]!=training_targets[i] for i in len(training_targets)]))
        return sum(scores)/cv
            

    def flatten(self, t:list):
        return [item for sublist in t for item in sublist]


if __name__ == "__main__":
    d,t = make_classification()
    bag = BayesianBaggingClassifier(n_estimators=25)
    bag.fit(d,t)
    print(bag.cross_val())