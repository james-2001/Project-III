library(rpart)
library(boot)
library(ipred)

s <- sample(seq_len(nrow(kyphosis)), 60)
learning <- kyphosis[s, ]
training <- kyphosis[-s, ]

fit <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis)
pred <- predict(fit, type = "class")

training_classes <- colnames(pred)[max.col(pred, ties.method = "first")]

misclass <- length(which(learning$Kyphosis != training_classes))
r <- misclass / nrow(training)
