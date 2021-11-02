library(boot)

male_cats <- catsM[,c(2,3)]
model <- lm(Hwt~Bwt, data = male_cats)
plot(male_cats)
abline(model$coefficients[1], model$coefficients[2])

residual_std_error <- function(data, i){
  d <- data[i]
  ((sum(d**2))/(length(d) - 2))**0.5
  
}


residual_boot <- boot(model$residuals, statistic = residual_std_error,
                      R = 5000)

residual_boot.ci <- boot.ci(residual_boot, type = "norm")