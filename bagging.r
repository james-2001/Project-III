library(rpart)
library(boot)

s <- sample(1:nrow(kyphosis), 60)
learning <- kyphosis[s]
training <- kyphosis[-s]

