from random import random
import scipy.stats as sp
import numpy as np

x = [random() for _ in range(10)]

bs = sp.bootstrap((x,), np.mean)
print(bs)
