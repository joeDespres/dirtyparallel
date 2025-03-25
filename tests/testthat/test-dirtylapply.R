create_matrix <- function(nrow = 10, ncol = 10) {
  matrix(runif(nrow * ncol), nrow = nrow, ncol = ncol)
}

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
    create_matrix()
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
    create_matrix()
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
    create_matrix()
  })

  crossprod_with_scale <- \(x, scale, thirtyfive) {
    (cor(x = x) * scale) + thirtyfive
  }

  expect_equal(
    lapply(mat_list, crossprod_with_scale, scale = 9, thirtyfive = 35),
    rustylapply_wrapper(iterator = mat_list, func = crossprod_with_scale, scale = 9, thirtyfive = 35)
  )

})

test_that("big matrix opts", {

  n <- 100

  mat_list <- lapply(1:50, \(i, n) {

    create_matrix(nrow = n, ncol = n)

  }, n = n)

  a <- create_matrix(nrow = n, ncol = n)
  b <- create_matrix(nrow = n, ncol = n)
  c <- create_matrix(nrow = n, ncol = n)
  d <- create_matrix(nrow = n, ncol = n)
  e <- create_matrix(nrow = n, ncol = n)


  mat_ops <- function(x, a, b, c, d, e) {
    x %*% a %*% b %*% c %*% d %*% e
  }

  start <- Sys.time()
  rustylapply_wrapper(iterator = mat_list, func = mat_ops, a = a, b = b, c = c, d = d, e = e)
  print(paste("Point 1: ", round(difftime(Sys.time(), start, units = "secs"), 5), "Seconds"))

  expect_equal(
    lapply(X = mat_list, FUN = mat_ops, a = a, b = b, c = c, d = d, e = e),
    rustylapply_wrapper(iterator = mat_list, func = mat_ops, a = a, b = b, c = c, d = d, e = e)
  )

})
