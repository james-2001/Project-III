from sklearn.datasets import make_classification
from numpy.random import poisson

data, target = make_classification()
full = list(zip(data, target))
r = 25

bagged_data = [{"data": [], "target": []} for _ in range(r)]


def process(new):
    d, t = new
    for i in range(r):
        k = poisson()
        bagged_data[i]["data"] += k*[d]
        bagged_data[i]["target"] += k*[t]


for point in full:
    process(point)

print(bagged_data[0])
