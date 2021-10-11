library(boot)
set.seed(5)


boot1 <- function(data, n) {
  correlations <- integer(n)
  for (i in 1:n) {
    sample_index <- sample(1:14, 5, replace = T)
    resample <- law[sample_index,]
    resample.cor <- cor(resample$LSAT, resample$GPA)
    correlations[i] <- resample.cor
  }
  mean(correlations)
}

statistic.me <- boot1(law, 1000)

theta_hat <- function(data, index){
  return(cor(data[index,1], data[index,2]))
}

statistic.r <- boot(law, theta_hat, R = 5000)$t0