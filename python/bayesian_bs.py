import numpy as np
import scipy as sp
import sklearn.utils as sk


class BB:
    def __init__(self, input_data, R) -> None:
        self.data = np.array(input_data)
        self.R = R
        self.t0 = np.mean(input_data)
        self.t = [None]
        self.n = len(input_data)


    def bs_average(self):
        dir_samples = np.random.dirichlet([1]*self.n, self.R)
        self.t = (dir_samples * self.data).sum(axis=1)


if __name__ == "__main__":
    norm_data = np.random.normal(0,1,30)
    bs = BB(norm_data, 5000)


