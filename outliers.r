library(boot)
library(mc2d)
set.seed(50)

n <- 10
sample <- rexp(n - 1)
data <- append(sample, 25)
r <- 5000

b_mean <- boot(data, function(d, i) mean(d[i]), R = r)

weights <- rdirichlet(r, rep(1, n))
bb_mean <- rep(0, r)
for (i in 1:r) {
    bb_mean[i] <- sum(weights[i, ] * data)
}

par(mfrow = c(2, 2))
hist(b_mean$t)
hist(bb_mean)

plot(ecdf(b_mean$t))
lines(ecdf(bb_mean), col = "red")
