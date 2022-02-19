library(boot)

trends <- read.csv("data/ercc.csv")

cor.stat <- function(data, i) {
  cor(data[i,1], data[i,2])
}

r = 5000

bs <- boot(trends, cor.stat, R = r)

bs.ci.norm1 <- boot.ci(bs, type = "norm")
bs.ci.basic1 <- boot.ci(bs, type = "basic")
bs.ci.perc1 <- boot.ci(bs, type = "perc")

hist(bs$t)
abline(v = bs.ci.norm1$normal[c(2,3)], col = 3)
abline(v = bs.ci.basic1$basic[c(4,5)], col = 2)
abline(v = bs.ci.perc1$percent[c(4,5)], col = 4)

bs.bias <- mean(bs$t - bs$t0)
bs.std <- var(bs$t)**0.5
bs.ci.norm2 <- c(bs$t0 - bs.bias - 1.96*bs.std, bs$t0 - bs.bias + 1.96*bs.std)

bs.sorted <- sort(bs$t)
bs.quantiles <- c(bs.sorted[round(r*0.975)], bs.sorted[round(r*0.025)])
bs.ci.basic2 <- 2*bs$t0 - bs.quantiles

bs.ci.perc2 <- sort(bs.quantiles)
# bs bias is small so might be a reasonable assumption
