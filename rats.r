library(boot)
library(mc2d)

R <- 5000

model <- lm(log(surv) ~ dose, data = survival)
n <- nrow(survival)

dev.new(width = 20, height = 20)
pdf("ratlm4.pdf")
par(mar = c(5,6,4,1)+.1)
plot(survival$dose, log(survival$surv),
     xlab = "Dose", ylab = "Log(survival rate)",
     cex.lab = 2)
abline(model)
dev.off()

t <- rep(0, R)
for (i in 1:R) {
    pi <- rdirichlet(1, rep(1, n))
    t[i] <- (n * sum(pi * model$residuals**2)) / (n - 2)
}

dev.new()
pdf("t_hist.pdf")
par(mar = c(5,6,4,1)+.1)
hist(t, cex.lab = 2, main = NULL)
abline(v = quantile(t, c(0.025, 0.975)), col = "red")
abline(v = mean(t), col = "blue")
dev.off()

