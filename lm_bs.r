library(boot)

male_cats <- catsM[,c(2,3)]
model <- lm(Hwt~Bwt, data = male_cats)
abline(model$coefficients[1], model$coefficients[2])


residual_boot <- boot(model$residuals,statistic = function(data,i){mean(data[i])},
                      R = 5000)

residual_boot.ci <- boot.ci(residual_boot, type = "norm")
# symmetric about 0: evidence residuals are normally distrubutes