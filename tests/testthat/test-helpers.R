test_that("", {
  .f <- \(y) {
    print(y)
  }

  f_x <- wrap_first_arg_as_x(.f)

  expect_equal(names(formals(f_x)), c("x", "..."))

})
