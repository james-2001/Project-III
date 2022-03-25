x <- 1:10
z <- seq(1,10, length.out = 100)
n <- 100

#par(mfrow = c(2,1) ,oma=c(0,0,2,0))

plot(x,dpois(x,lambda = 1), col = "blue", pch = 16,
     ylab = expression(P(x == k)),
     xlab = "k",
     main = "Poisson, Binomial, and Exponential Density Plots")
lines(x,dpois(x,lambda = 1), col = "blue")

points(x, dbinom(x,n, 1/n), col = "red", pch = 16)
lines(x, dbinom(x,n, 1/n), col = "red")

lines(z, dexp(z), col = "green")

legend(8,0.4,
       legend = c("Po(1)", expression("Bin(n, "*frac(1,n)*" )"), "Exp(1)"),
       col = c("blue", "red", "green"),
       lty = rep(1,3),
       box.lty = 0,
       bg= "transparent")


curve(ppois(x,1), 0, 10, col="blue", ylab = expression(F[n](x)),
      main="Poisson, Binomial, and Exponential CDF Plots")
curve(pexp, 0 ,10, add = T, col="green")
curve(pbinom(x,n,1/n), add = T, col ="red")
legend(7.8,1,
       legend = c("Po(1)", expression("Bin(n, "*frac(1,n)*" )"), "Exp(1)"),
       col = c("blue", "red", "green"),
       lty = rep(1,3),
       box.lty = 0,
       bg= "transparent")

mtext("Poisson, Binomial, and Exponential Density and CDF Plots", outer = T, cex= 1.5)
