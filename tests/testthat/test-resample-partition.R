context("resample-partition")

test_that("resample_partition() generates error messages & warnings", {
  expect_error(
    resample_partition(mtcars, c(test = "0.8", train = 0.7)),
    "numeric vector"
  )
  expect_error(
    resample_partition(mtcars, c(train = 0.7)),
    "numeric vector"
  )
  expect_error(
    resample_partition(mtcars, c(0.3, 0.7)),
    "numeric vector"
  )
  expect_message(
    resample_partition(mtcars, c(test = 0.8, train = 0.7)),
    "sum to"
  )
})

test_that("resample_partition() returns a list", {
  out <- resample_partition(mtcars, c(test = 0.3, train = 0.7))
  expect_true(is.list(out))
})
