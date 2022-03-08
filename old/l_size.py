from bagging_rate import bagging_rate
from sklearn.datasets import make_classification
from numpy import array, mean

def compare_rates():
    data_small, target_small = make_classification(n_samples=50)
    data_big, target_big = make_classification(n_samples=500)

    bag_small, clf_small = bagging_rate(data_small, target_small)
    bag_big, clf_big = bagging_rate(data_big, target_big)
    return [bag_big/clf_big, bag_small/clf_small]


rep_rates = array([compare_rates() for _ in range(100)])
print(mean(rep_rates, axis=0)) #[1.0414588  1.06114575]