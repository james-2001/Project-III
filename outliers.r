library(boot)
library(mc2d)
set.seed(50)

n <- 20
sample <- rexp(n - 1)
data <- append(sample, 25)
r <- 5000

b_mean <- boot(data, function(d, i) mean(d[i]), R = r)

bb_mean <- rep(0, r)
for (i in 1:r) {
    bb_mean[i] <- sum(rdirichlet(1, rep(1, n)) * data)
}

par(mfrow = c(2, 2))
hist(b_mean$t)
abline(v = c(mean(sample), mean(data)))
hist(bb_mean)

plot(ecdf(b_mean$t))
plot(ecdf(bb_mean))
