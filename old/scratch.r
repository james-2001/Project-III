library(boot)
set.seed(5)

boot1 <- function(R) {
  t <- rep(0, R)
  for (i in 1:R) {
    resample <- acme[sample(nrow(acme), nrow(acme), replace = T), ]
    t[i] <- cor(resample$market, resample$acme)
  }
  return(t)
}

boot_scratch <- boot1(law, 5000)

theta_hat <- function(data, index){
  return(cor(data[index,1], data[index,2]))
}

boot_library <- boot(law, theta_hat, R = 5000)$t0