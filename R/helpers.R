#' Assert That All Arguments Are Named
#'
#' Throws an error if any argument passed to the current function is not named.
#' This is designed for use in contexts where strict argument naming is required,
#' such as experimental or unsafe parallel processing.
#'
#' @return Invisibly returns `NULL` if all arguments are named. Otherwise, an error is thrown.
#'
#' @details
#' This assertion is useful in functions that rely on precise, named inputs —
#' especially when doing unconventional things like calling R functions from multiple
#' Rust threads. Unnamed arguments can introduce ambiguity and unpredictable behavior
#' in such contexts.
#'
#' If any argument is unnamed or has an empty name (`""`), the function throws
#' an error with a message explaining the requirement.
#'
#' @export
#'
assert_all_args_named <- function() {

  call <- sys.call(-1)
  args <- as.list(call)[-1]
  arg_names <- names(args)

  if (is.null(arg_names) || any(!nzchar(arg_names))) {
    stop(
      "All arguments to this function must be named.\n",
      "We're doing some crazy parallel stuff under the hood, and unnamed args\n",
      "could lead to chaos. Please name all your arguments explicitly."
    )
  }
}
#' Rename the First Argument of a Function
#'
#' Utility to rename the first argument of a function to `"x"`.
#' This is mostly a temporary hack to standardize argument names
#' during development or metaprogramming workflows.
#'
#' @param fn A function object whose first argument will be renamed.
#'
#' @return The same function with its first formal argument renamed to `"x"`.
#'
#' @details
#' This is intended for internal or experimental use. It directly modifies
#' the function's formals, which may break things if used carelessly.
#'
#' Hopefully, we don’t keep this!
#'
#' @export
wrap_first_arg_as_x <- function(fn) {

  function(x, ...) {
    fn(x, ...)
  }
}
