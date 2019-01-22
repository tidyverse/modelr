context("test-cross-validate")

test_that("number of crossfolds is a single integer", {
   expect_error(
    crossv_kfold(mtcars, k = "0"),
    "`k` must be a single integer"
  )
  expect_error(
    crossv_kfold(mtcars, k = c(1, 2)),
    "`k` must be a single integer"
  )
})

test_that("% of observations held out for testing is between 0 and 1", {
  expect_error(
    crossv_mc(mtcars, n = 100, test = "0.8"),
    "`test` must be a value between 0 and 1"
  )
  expect_error(
    crossv_mc(mtcars, n = 100, test = c(0.1, 0.5)),
    "`test` must be a value between 0 and 1"
  )
  expect_error(
    crossv_mc(mtcars, n = 100, test = -0.8),
    "`test` must be a value between 0 and 1"
  )
  expect_error(
    crossv_mc(mtcars, n = 100, test = 1),
    "`test` must be a value between 0 and 1"
  )
  expect_error(
    crossv_mc(mtcars, n = 100, test = 2),
    "`test` must be a value between 0 and 1"
  )
})


test_that("number of training pairs to generate is a single integer", {
  expect_error(crossv_mc(mtcars, n = c(1,2)), "`n` must be a single integer")
  expect_error(crossv_mc(mtcars, n = "0"), "`n` must be a single integer")
})

test_that("crossv_kfold() and crossv_mc() return a tibbles", {
  expect_equal(
    class(crossv_kfold(mtcars, 5)),
    c("tbl_df", "tbl", "data.frame")
  )

  expect_equal(
    class(crossv_mc(mtcars, 5)),
    c("tbl_df", "tbl", "data.frame")
  )
})
