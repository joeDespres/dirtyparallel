test_that("rustylapply", {

  expect_equal(list(100, 200, 300),
               rustylapply_wrapper(iterator = list(a = 1, b = 2, c = 3),
                                   func = \(x) x * 100)
  )


  expect_equal(list(100, 200, 300),
               rustylapply_wrapper(iterator = list(a = 1, b = 2, c = 3),
                                   func = \(y) y * 100)
  )

  mat_list <- lapply(1:10, \(i) {

    nrow <- 10
    ncol <- 10

    matrix(runif(nrow * ncol), nrow = nrow, ncol = ncol)
  })

  expect_no_error(
    rustylapply_wrapper(iterator = mat_list,
                        func = \(x) x %*% x)
  )

  expect_equal(
    lapply(mat_list, crossprod),
    rustylapply_wrapper(iterator = mat_list, func = crossprod)
  )


})

test_that("varargs can get passed", {

  mat_list <- lapply(1:10, \(i) {

    nrow <- 10
    ncol <- 10

    matrix(runif(nrow * ncol), nrow = nrow, ncol = ncol)
  })

  crossprod_with_scale <- \(x, scale) {
    crossprod(x = x) * scale
  }

  out <- rustylapply_wrapper(iterator = mat_list, func = crossprod_with_scale, scale = 9)

  expect_equal(
    lapply(mat_list, crossprod_with_scale, scale = 9),
    rustylapply_wrapper(iterator = mat_list, func = crossprod_with_scale, scale = 9)
  )

})


test_that("multiple varargs can get passed", {

  mat_list <- lapply(1:10, \(i) {

    nrow <- 10
    ncol <- 10

    matrix(runif(nrow * ncol), nrow = nrow, ncol = ncol)
  })

  crossprod_with_scale <- \(x, scale, thirtyfive) {
    (cor(x = x) * scale) + thirtyfive
  }

  expect_equal(
    lapply(mat_list, crossprod_with_scale, scale = 9, thirtyfive = 35),
    rustylapply_wrapper(iterator = mat_list, func = crossprod_with_scale, scale = 9, thirtyfive = 35)
  )

})
