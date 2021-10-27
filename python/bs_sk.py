import random
from numpy.core.fromnumeric import sort
import sklearn.utils as sk
import numpy as np
import scipy.stats as sp

data = random.sample(range(1000),100)

mu = np.mean(data)

R = 5000
bootstrap = np.array([np.mean(sk.resample(data))
                      for _ in range(R)])

bs_basic_py = sp.bootstrap((data,), np.mean, 
                           method = 'basic').confidence_interval
print(bs_basic_py)

bs_quantiles = sort(bootstrap)[[round(R*0.025),round(R*0.975)]]
bs_basic_me = 2*mu - bs_quantiles
print(sorted(bs_basic_me))



