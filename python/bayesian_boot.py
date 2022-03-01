from numpy import array, ndarray
from numpy.random import dirichlet

def generate_samples(data: ndarray, m: int):
    n = data.shape[0]
    weights = n * dirichlet([1]*n, m)
    return array([array([w[i]*data[i,] for i in range(n)])
                    for w in weights])

