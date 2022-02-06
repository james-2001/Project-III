library(mc2d)
library(boot)
set.seed(50)

n <- 500

data <- rnorm(n)
bb_mean <- function(data, R) {
    t <- rep(0, R)
    for (i in 1:R) {
        dir_samp <- mc2d::rdirichlet(1, rep(1, n))
        t[i] <- weighted.mean(data, dir_samp)
    }
    return(t)
}


bb_quant <- function(data, R, q) {
    t <- rep(0, R)
    dir_samp <- mc2d::rdirichlet(R, rep(1, n))
    for (i in 1:R) {
        cum_sum <- 0
        j <- 1
        while (cum_sum <= q) {
            cum_sum <- cum_sum + dir_samp[i, j]
            j <- j + 1
        }
        t[i] <- data[i]
    }
    return(t)
}


mean_hat <- function(data, i){
    mean(data[i])
}
data_bb_mean <- bb_mean(data, 5000)
data_b <- boot(data, mean_hat, 5000)

hist(data_b$t, freq = F)

m <- mean(data_b$t)
s <- var(data_b$t)**0.5
curve(dnorm(x,m,s), add = T)