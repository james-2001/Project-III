library(boot)

model <- lm(behaviour~plumage, data = ducks)
plot(ducks)
abline(model$coefficients[1], model$coefficients[2])

residual_std_error <- function(data, i){
  d <- data[i]
  ((sum(d**2))/(length(d) - 2))**0.5
  
}


model_intercept <- function(data, i){
  d <- data[i,]
  md <- lm(behaviour ~ plumage, data = d)
  md$coefficients[1]
}


model_grad <- function(data, i){
  d <- data[i,]
  md <- lm(behaviour ~ plumage, data = d)
  md$coefficients[2]
}

residual_boot <- boot(model$residuals, statistic = residual_std_error,
                      R = 5000)

residual_boot.ci <- boot.ci(residual_boot, type = "norm")



duck_resample_grad <- boot(ducks,model_grad, R = 5000)
duck_resample_intercept <- boot(ducks,model_intercept, R = 5000)