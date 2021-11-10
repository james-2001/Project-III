n <- 1000
exp <- sort(rexp(n))
x <- round(exp[n]) - 1
edf_exp = integer()
for (i in 1:n) {
  j <- 1
  while (exp[j] < x/i) {
    j <- j + 1
  }
  edf_exp[i] <- j
}
plot(edf_exp, type = 's')