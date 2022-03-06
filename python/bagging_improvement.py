from bagging_rate import bagging_rate
from sklearn.datasets import load_wine, make_classification, load_iris, load_digits
from numpy import array, mean, append

for loader in [load_iris, load_digits, load_wine, make_classification]:
    dataset = loader()
    if loader == make_classification:
        data, target = dataset
    else:
        data, target = dataset.data, dataset.target
    improvements = array([bagging_rate(data, target) for _ in range(100)])
    improvements = mean(improvements, axis=0)
    improvements = append(improvements,100*(1-improvements[0]/improvements[1]))
    print(f"{loader.__name__}:{improvements}%")
