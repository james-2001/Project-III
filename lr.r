library(boot)

surv <- survival[-13, ]
model <- lm(log(surv) ~ dose, data = surv)
plot(surv$dose, log(surv$surv))
abline(model)
n<-nrow(surv)

b0 <- model$coefficients[1]
b1 <- model$coefficients[2]
res <- model$residuals
h <- hatvalues(model)
r2 <- res / sqrt(1 - (2 / n))
r1 <- res / sqrt(1 - h)
rbar <- mean(r1)
r1 <- r1 - rbar

b <- data.frame(b0 = rep(0, 5000),
                b1 = rep(0, 5000))
boot_data <- data.frame(x = surv$dose,
                        y = rep(0, n))
for (i in 1:5000) {
    for (j in 1:n) {
        e <- sample(r1, 1)
        boot_data$y[j] <- b0 + (b1 * boot_data$x[j]) + e
    }
    b_model <- lm(y ~ x, data = boot_data)
    b$b0[i] <- b_model$coefficients[1]
    b$b1[i] <- b_model$coefficients[2]
}