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

q <- rep(0, 4)
r <- c(1000, 5000, 1000, 1500)
for (i in 1:4) {
    q[i] <- quantile(bayesian_b(r[i]), 0.025)
}

