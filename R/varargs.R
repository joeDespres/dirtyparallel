dirtylapply <- function(iterator, funct, ..) {

  args <- list(...)
  call_rust_with_varargs(args)

}
