rustylapply_wrapper <- function(iterator, func, ...) {
  varargs <- list(...)
  rustylapply(list = iterator, func = func, varargs = varargs)
}
