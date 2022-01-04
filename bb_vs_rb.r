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

theta_hat <- function(data, i){
    mean(data[i])
}

bb_t <- bayesian_b(5000)
rb <- boot(data, theta_hat, 5000)

par(mfrow = c(1,2))
hist(bb_t)
abline(v = quantile(bb_t, c(0.025, 0.5, 0.975)),
       col = "red")
hist(rb$t)
abline(v = quantile(rb$t, c(0.025, 0.5, 0.975)),
       col = "red")

# n <- 3
# r <- seq(500, 5000, length.out = n)
# bb_cis <- data.frame("r" = r, "lower" = rep(0, n),
#                      "upper" = rep(0, n))

# for (i in 1:n) {
#     bb_cis$lower[i] <- quantile(bayesian_b(r[i]), 0.025)
#     bb_cis$upper[i] <- quantile(bayesian_b(r[i]), 0.975)
# }
