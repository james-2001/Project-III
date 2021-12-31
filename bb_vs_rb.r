library(mc2d)
library(boot)
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

n <- 10
r <- seq(500, 5000, length.out = n)
bb_cis <- data.frame("r" = r, "lower" = rep(0, n),
                     "upper" = rep(0, n))

for (i in 1:n) {
    bb_cis$lower[i] <- quantile(bayesian_b(r[i]), 0.025)
    bb_cis$upper[i] <- quantile(bayesian_b(r[i]), 0.975)
}
