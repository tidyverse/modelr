context("resample")

test_that("resample works as expected", {
  df <- tibble::tibble(a = 1:5)
  idx <- 2:3
  foo <- resample(df, idx)
  expect_is(foo, "resample")
  expect_identical(foo$data, df)
  expect_identical(as.integer(foo), idx)
})

test_that("resample works with numeric idx arg", {
  df <- tibble::tibble(a = 1:5)
  idx <- c(3, 2)
  foo <- resample(df, idx)
  expect_is(foo, "resample")
  expect_identical(foo$data, df)
  expect_identical(as.integer(foo), as.integer(idx))
})

test_that("resample raises error for non-data.frame `data`", {
  expect_error(resample(1:5, tibble::tibble(a = 1)),
               regexp = "`data` must be a data frame")
})

test_that("resample raises error for non-numeric `idx`", {
  expect_error(resample(tibble::tibble(a = 1:10), c("1", "2")),
               regexp = "`idx` must be an integer vector")
})

test_that("as.data.frame.resample works", {
  df <- tibble::tibble(a = 1:5)
  idx <- c(3, 2)
  expect_identical(as.data.frame(resample(df, idx)), df[idx, ])
})

test_that("as.integer.resample works", {
  df <- tibble::tibble(a = 1:5)
  idx <- c(3L, 2L)
  expect_identical(as.integer(resample(df, idx)), idx)
})

test_that("dim.resample works", {
  df <- tibble::tibble(a = 1:5)
  idx <- c(3L, 2L)
  expect_identical(dim(resample(df, idx)), c(2L, 1L))
})
