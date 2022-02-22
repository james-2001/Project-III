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

dev.new()
pdf("plots/outliers.pdf")
plot(ecdf(b_mean$t), col = "red", main = NULL)
lines(ecdf(bb_mean))
legend(10, 0.1,
       legend = c("Bayesian Bootstrap", "Efron's Bootstrap"),
       col = c("black", "red"),
       lty = 1, box.lty = 0)
dev.off()