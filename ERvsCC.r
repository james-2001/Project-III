library(boot)

trends <- read.csv("data/ercc.csv")

cor.stat <- function(data, i) {
  cor(data[i,1], data[i,2])
}

bs.trend <- boot(trends, cor.stat, R = 5000)
hist(bs.trend$t)
bs.ci <- boot.ci(bs.trend, type = "perc")