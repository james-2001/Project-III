library(bootstrap)
library(boot)
theta_hat <- function(data, index){
  return(cor(data[index,1], data[index,2]))
}
o_np_bs <- boot(law, theta_hat, R = 5000)
hist(o_np_bs$t, nclass = 50)

quantil.perc <- boot.ci(boot.out = o_np_bs, type = "perc")
abline(v = tail(quantil.perc$percent, n = 2), col = 2, lwd = 2)

quantil.BCa <- boot.ci(boot.out = o_np_bs, type = "bca")
abline(v = tail(quantil.BCa$bca, n = 2), lwd = 2, col = 4)
