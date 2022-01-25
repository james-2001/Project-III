library(boot)
library(mc2d)
set.seed(50)

data <- rnorm(100)

boot_mean <- function(data, i) {
    mean(data[i])
}
r <- seq(from = 10, to = 8000, by = 50)
n <- length(r)
bounds <- data.frame("2.5%" = rep(0, n),
                     "97.5%" = rep(0, n))

for (i in 1:n) {
    b <- boot(data, boot_mean, R = r[i])
    bounds[i, ] <- quantile(b$t, c(0.025, 0.975))
}

plot_lim <- c(min(bounds$X2.5.), max(bounds$X97.5.))

plot(bounds$X2.5., col = "red", ylim = plot_lim, type = "l")
lines(bounds$X97.5., col = "green")
