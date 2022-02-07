library(boot)
library(mc2d)

R <- 5000

model <- lm(log(surv) ~ dose, data = survival[-13,])
n <- nrow(survival[-13,])

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


theta_hat <- function(data,i){
    d <- data[i,]
    fit <- lm(log(surv)~dose, data = d)
    v <- sum(fit$residuals**2)/12
    return(v)
    }

eb_t <- boot(survival[-13, ], theta_hat, R = 5000)

dev.new()
pdf("cd_compare.pdf")
plot(ecdf(t-mean(t)),
     main = NULL,
     cex.lab = 1.5)
lines(ecdf(eb_t$t-mean(eb_t$t)), col = "red")
legend(0,.2,
       legend = c("Bayesian Bootstrap", "Efron's Bootstrap"),
       col = c("black", "red"),
       lty = 1, box.lty = 0,
       cex = 1.5)
dev.off()

par(mfrow=c(2,1))
hist(t)
hist(eb_t$t)
