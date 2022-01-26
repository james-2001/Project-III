library(boot)
library(mc2d)
set.seed(50)

data <- rnorm(100)

boot_mean <- function(data, i) {
    mean(data[i])
}

bb_mean <- function(data, R) {
    t <- rep(0, R)
    for (i in 1:R) {
        dir_samp <- mc2d::rdirichlet(1, rep(1, 100))
        t[i] <- weighted.mean(data, dir_samp)
    }
    return(t)
}


r <- seq(from = 10, to = 8000, by = 50)
n <- length(r)
b_bounds <- data.frame("2.5%" = rep(0, n),
                     "97.5%" = rep(0, n))

for (i in 1:n) {
    b <- boot(data, boot_mean, R = r[i])
    b_bounds[i, ] <- quantile(b$t, c(0.025, 0.975))
}

plot_lim <- c(min(b_bounds$X2.5.), max(b_bounds$X97.5.))


#par(mfrow = c(2,0))
# plot(b_bounds$X2.5., col = "red", ylim = plot_lim, type = "l")
# lines(b_bounds$X97.5., col = "green")

bb_bounds <- data.frame("2.5%" = rep(0, n),
                        "50%" = rep(0, n),
                        "97.5%" = rep(0, n))

for (i in 1:n) {
    b <- bb_mean(data, r[i])
    bb_bounds[i, ] <- quantile(b, c(0.025, 0.5, 0.975))
}

plot(bb_bounds$X2.5., col = "red", ylim = plot_lim, type = "l")
lines(bb_bounds$X97.5., col = "green")
lines(bb_bounds$X50)
