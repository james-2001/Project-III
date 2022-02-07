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


theta_hat <- function(data, i){
    d <- data[i,]
    fit <- lm(log(surv)~dose, data = d)
    v <- summary(fit)$sigma**2
    }

eb_t <- boot(survival, theta_hat, R = 5000)

dev.new()
pdf("cd_compare.pdf")
plot(ecdf(t),
     main = NULL,
     cex.lab = 1.5)
lines(ecdf(eb_t$t), col = "red")
legend(4.5,0.2,
       legend = c("Bayesian Bootstrap", "Efron's Bootstrap"),
       col = c("black", "red"),
       lty = 1, box.lty = 0,
       cex = 1.5)
dev.off()
