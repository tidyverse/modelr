context("data_grid")

x <- tibble::tribble(~ a, ~ b,
                       1,   4,
                       2,   5,
                       2,   6)

expected <- tibble::tibble(a = c(1, 2))


test_that("data_grid works normally", {
  expect_equal(data_grid(x, a), expected)
})

test_that("data_grid_ works with character vector", {
  var <- "a"
  expect_equal(data_grid_(x, var), expected)
})

test_that("data_grid_ works with a formula", {
  expect_equal(data_grid_(x, ~ a), expected)
})

test_that("data_grid_ works with a quoted variable name", {
  expect_equal(data_grid_(x, quote(a)), expected)
})

test_that("data_grid_ works with a named value", {
  var_rng <- seq_range(x[["a"]], by = 0.5)
  var <- "a"
  expect_equal(data_grid_(x, .dots = setNames(list(~ var_rng), var)),
               tibble::tibble(a = var_rng))
})


