module helloworld

go 1.20

require (
  require github.com/Figaarillo/calculator v0.0.0
  rsc.io/quote v1.5.2
)

replace github.com/Figaarillo/calculator => ../calculator
