library(mc2d)

b_boot <- function(data, statistic, R) {
    if (is.null(dim(data))) {
        n <- length(data)
    }
    else {
        n <- dim(data)[1]
    }
    weights <- mc2d::rdirichlet(R, rep(1, n))
    t <- rep(0, R)
    for (i in 1:R) {
        resample <- n * data * weights[i, ]
        t[i] <- statistic(resample)
    }
    return(t)
}

bb_ci <- function(t, level) {
    return(quantile(t, c((1 - level) / 2, level + (1 - level) / 2)))
}
