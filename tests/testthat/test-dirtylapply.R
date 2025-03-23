test_that("rustylapply", {

  expect_equal(list(100, 200, 300),
               rustylapply(list = list(a = 1, b = 2, c = 3),
                           func = \(value) value * 100)
  )

  mat_list <- lapply(1:10, \(i) {

    nrow <- 10
    ncol <- 10

    matrix(runif(nrow * ncol), nrow = nrow, ncol = ncol)
  })

  expect_no_error(
    rustylapply(list = mat_list,
                func = \(value) value %*% value)
  )

  expect_equal(
    lapply(mat_list, crossprod),
    rustylapply(mat_list, crossprod)
  )

})

test_that("varargs can get passed", {

  mat_list <- lapply(1:10, \(i) {

    nrow <- 10
    ncol <- 10

    matrix(runif(nrow * ncol), nrow = nrow, ncol = ncol)
  })

  crossprod_with_scale <- \(X, scale) {
    crossprod(X) * scale
  }

  expect_equal(
    lapply(mat_list, crossprod_with_scale, scale = 9),
    rustylapply_wrapper(mat_list, crossprod, scale = 9)
  )

})


