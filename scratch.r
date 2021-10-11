library(boot)

# Draw resample: sample size of 5.
# Draw 5 random integers in range 1:14 w/ replacement from uniform
sample_index <- sample(1:14, 5, replace = T)

# Draw the elements from the original sample with those indexs
resample <- law[sample_index,]

# Define our sample statstic (correlation)
theta_hat <- function(data, index){
  return(cor(data[index,1], data[index,2]))
}