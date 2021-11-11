import numpy as np
import scipy as sp
import sklearn.utils as sk


class BB:
    def __init__(self, input_data, R) -> None:
        self.data = input_data
        self.R = R
        self.t0 = None
        self.t = [None]

    def expectation(self,dist):
        return sum([point[1]*point[0] for point in dist])


    def bb_replication(self):
        samp = sk.resample(self.data)
        uniform_sample = [0] + sorted(np.random.uniform(0,1,16)) + [1]
        gaps = [uniform_sample[i+1] - uniform_sample[i] for i in range(15)]
        bb_dist = list(zip(samp, gaps))
        bb_mean = self.expectation(bb_dist)
        return bb_mean

    def bayesian_bs(self):
        self.t = [self.bb_replication(self.data) for _ in range(self.R)]
        self.t0 = np.mean(self.t)
        return self.t
    

if __name__ == "__main__":
    norm_data = np.random.normal(0,1,30)
