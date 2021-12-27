library(mc2d)
library(boot)
set.seed(50)

data <- rnorm(500)
bb <- function(data, R) {
    t <- rep(0, R)
    for (i in 1:R) {
        dir_samp <- mc2d::rdirichlet(1, rep(1, 500))
        t[i] <- weighted.mean(data, dir_samp)
    }
    return(t)
}

theta_hat <- function(data, i){
    mean(data[i])
}
data_bb <- bb(data, 5000)
data_b <- boot(data, theta_hat, 5000)
