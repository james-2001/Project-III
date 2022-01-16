library(boot)
library(mc2d)

R <- 5000

model <- lm(log(surv) ~ dose, data = survival)
n <- nrow(survival)

t <- rep(0, R)
for (i in 1:R) {
    pi <- rdirichlet(1, rep(1,n))
    t[i] <- sum(pi * model$residuals**2) / (n - 2)
}