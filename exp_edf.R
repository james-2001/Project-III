
exp <- sort(rexp(1000))
x<-round(exp[1000])-1
edf_exp = integer(x)
for(i in 1:100){
  j<-1
  while (exp[j] < x/i){
    j <- j + 1
  }
  edf_exp[i]=j
}
plot(edf_exp)