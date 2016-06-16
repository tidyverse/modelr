context("response_var")

test_that("can extract response from linear model", {
  mod <- lm(mpg ~ wt, data = mtcars)
  expect_identical(response_var(mod), quote(mpg))
})

test_that("can extract response from loess model", {
  mod <- loess(mpg ~ wt, data = mtcars)
  expect_identical(response_var(mod), quote(mpg))
})
