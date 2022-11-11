test_that("number of crossfolds is a single integer", {
  expect_error(crossv_kfold(mtcars, k = "0"), "single integer")
  expect_error(crossv_kfold(mtcars, k = c(1, 2)), "single integer")
})

test_that("% of observations held out for testing is between 0 and 1", {
  expect_error(crossv_mc(mtcars, n = 100, test = 2), "value between")
})

test_that("number of training pairs to generate is a single integer", {
  expect_error(crossv_mc(mtcars, n = c(1,2)), "single integer")
  expect_error(crossv_mc(mtcars, n = "0"), "single integer")
})

test_that("crossv_kfold() and crossv_mc() return tibbles", {
  out <- crossv_kfold(mtcars, 5)
  expect_s3_class(out, "tbl_df")

  out <- crossv_mc(mtcars, 5)
  expect_s3_class(out, "tbl_df")
})
