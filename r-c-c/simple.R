dyn.load("simple.so")
.C("simple", n=as.integer(5), x=as.double(rnorm(5)))
