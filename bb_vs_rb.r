library(mc2d)
library(boot)
library(tictoc)
set.seed(5)

data <- rnorm(5000)

bayesian_b <- function(R) {
    t <- rep(0, R)
    for (i in 1:R) {
        dir_samp <- mc2d::rdirichlet(1, rep(1, 5000))
        t[i] <- weighted.mean(data, dir_samp)
    }
    return(t)
}

theta_hat <- function(data, i){
    mean(data[i])
}
tic("bb")
bb_t <- bayesian_b(5000)
toc()
tic("rb")
rb <- boot(data, theta_hat, 5000)
toc()

par(mfrow = c(1,2))
hist(bb_t)
abline(v = quantile(bb_t, c(0.025, 0.5, 0.975)),
       col = "red")
hist(rb$t)
abline(v = quantile(rb$t, c(0.025, 0.5, 0.975)),
       col = "red")