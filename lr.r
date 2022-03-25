library(boot)
library(mc2d)

surv <- survival[-13,]
model <- lm(log(surv) ~ dose, data = surv)
n <- nrow(surv)

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
    e <- sample(r1, n, replace = T)
    boot_data$y <- b0 + (b1 * surv$dose) + e
    b_model <- lm(y ~ x, data = boot_data)
    b[i, ] <- b_model$coefficients
}

bb <- data.frame(b0 = rep(0, 5000),
                 b1 = rep(0, 5000))
boot_data <- data.frame(x = surv$dose,
                        y = rep(0, n))
# for (i in 1:5000) {
#     e <- r1 * n * rdirichlet(1, rep(1, n))
#     boot_data$y <- c(b0 + (b1 * surv$dose) + e)
#     b_model <- lm(y ~ x, data = boot_data)
#     bb[i, ] <- b_model$coefficients
# }

beta <- function(data, i){
    data = data[i, ]
    lm(log(surv)~ dose, data = data)$coefficients
}
b0<-boot(surv, beta0, 5000)