import numpy as np
from numpy.lib.function_base import quantile
import scipy as sp
import sklearn.utils as sk


class BB:
    def __init__(self, input_data: list, R: int) -> None:
        self.data = np.array(input_data)
        self.R = R
        self.t0 = np.mean(input_data)
        self.n = len(input_data)
        self.t = self.b_bootstrap()
        

    def b_bootstrap(self):
        dir_samp = np.random.dirichlet([1]*self.n, self.R)
        t = [None] * self.R
        for i in range(self.R):
            t[i] = np.average(self.data, weights=dir_samp[i])
        return t 
 


if __name__ == "__main__":
    norm_data = np.random.normal(0,1,1000)
    bs = BB(norm_data, 5000)
    print(bs.t0)
    print(np.quantile(bs.t, [0.025,0.975]))


