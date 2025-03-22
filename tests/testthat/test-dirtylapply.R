test_that("dirtylapply", {

  expect_equal(list(100, 200, 300),
               dirtylapply(list = list(a = 1, b = 2, c = 3),
                           func = \(value) value * 100)
  )

  mat_list <- lapply(1:10, \(i) {

    nrow <- 10
    ncol <- 10

    matrix(runif(nrow * ncol), nrow = nrow, ncol = ncol)
  })

  expect_no_error(
    dirtylapply(list = mat_list,
                func = \(value) value %*% value)
  )

})
