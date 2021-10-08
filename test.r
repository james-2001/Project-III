library(bootstrap)
library(boot)
theta_hat <- function(data, index){
  return(cor(data[index,1], data[index,2]))
}
x <- boot(law, theta_hat, R= 5000)
hist(x$t)
print(x$t0)

#test com