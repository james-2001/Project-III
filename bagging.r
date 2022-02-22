library(rpart)
library(boot)

s <- sample(seq_len(nrow(kyphosis)), 60)
learning <- kyphosis[s, ]
training <- kyphosis[-s, ]

fit <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis)
pred <- predict(fit, training)

training_classes <- colnames(pred)[max.col(pred, ties.method = "first")]

misclass <- length(which(training$Kyphosis != training_classes))
r <- misclass / nrow(training)
