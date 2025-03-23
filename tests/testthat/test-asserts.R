test_that("assert_all_args_named", {

  .f <- \(.x) {
    assert_all_args_named()
  }
  expect_error(.f("hi mom"), regexp = "All arguments to this function must be named.")

  .f <- \(.x) {
    assert_all_args_named()
  }

  expect_no_error(.f(.x = "hi mom"))

  expect_error(rustylapply_wrapper(mat_list, crossprod))

})
