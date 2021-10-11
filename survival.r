library(boot)

surv.fn <- function(data, i){
  d <- data[i,]
  d.regression <- lm(log(d$surv) ~ d$dose)
  c(coef(d.regression))
}

surv.boot <- boot(survival, surv.fn, R = 999)
print(surv.boot$t0)