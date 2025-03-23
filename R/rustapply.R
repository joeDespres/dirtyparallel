#' Wrapper for `rustylapply`
#'
#' A thin wrapper around `rustylapply()` that enables applying an R function
#' across an iterator using potentially unsafe parallelism via Rust threads.
#' This wrapper forwards additional arguments to the applied function, making
#' it easier to use from R.
#'
#' @param iterator A list-like object to iterate over.
#' @param func An R function to apply to each element of the iterator.
#' @param ... Additional arguments passed to `func`. These will be captured
#'   and passed as a `varargs` list into `rustylapply`.
#'
#' @return A list of results, with one element per item in the iterator.
#'
#' @details
#' This function is part of an experimental setup that calls R functions from
#' multiple Rust threads without regard for thread-safety. It is *not safe*
#' and should be used only for exploratory or benchmarking purposes, not in
#' production. The goal is to prototype dirty parallelism and investigate
#' performance characteristics when disregarding R's single-threaded
#' constraints.
#'
#' @export
#'
rustylapply_wrapper <- function(iterator, func, ...) {

  assert_all_args_named()

  varargs <- list(...)

  # TODO: lets hope we can get rid of this
  f_x <- wrap_first_arg_as_x(func)

  rustylapply(list = iterator, func = f_x, varargs = varargs)
}
