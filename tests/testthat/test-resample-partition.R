context("resample-partition")

test_that("named numeric vector probabilities are supplied", {
  expect_error(
    resample_partition(mtcars, c(test = "0.8", train = 0.7)),
    "`p` must be a named numeric vector with at least two values."
  )
  expect_error(
    resample_partition(mtcars, c(train = 0.7)),
    "`p` must be a named numeric vector with at least two values."
  )
  expect_error(
    resample_partition(mtcars, c(0.3, 0.7)),
    "`p` must be a named numeric vector with at least two values."
  )
  expect_message(
    resample_partition(mtcars, c(test = 0.8, train = 0.7)),
    "Rescaling `p` to sum to 1."
  )
})

test_that("resample_partition() returns a list", {
  expect_equal(
    class(resample_partition(mtcars, c(test = 0.3, train = 0.7))),
    "list"
  )
})
