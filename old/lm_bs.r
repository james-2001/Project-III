library(boot)

model <- lm(plumage~behaviour, data = ducks)

plot(ducks, ylim = c(-3, 20))
abline(model$coefficients, col = "black")
abline(confint(model)[,1], col = "blue")
abline(confint(model)[,2], col = "blue")

model_intercept <- function(data, i){
  d <- data[i,]
  md <- lm(plumage ~ behaviour, data = d)
  md$coefficients[1]
}


model_grad <- function(data, i){
  d <- data[i,]
  md <- lm(plumage ~ behaviour, data = d)
  md$coefficients[2]
}


duck_grad <- boot(ducks,model_grad, R = 5000)
duck_grad.ci <- boot.ci(duck_grad, type = 'perc')
duck_intercept <- boot(ducks,model_intercept, R = 5000)
duck_intercept.ci <- boot.ci(duck_intercept, type = 'perc')

abline(duck_intercept$t0, duck_grad$t0, col = "red", lty = "dashed")

abline(duck_intercept.ci$percent[4], duck_grad.ci$percent[4], col = "green")
abline(duck_intercept.ci$percent[5], duck_grad.ci$percent[5], col = "green")
