context("test-data-grid.R")

test_that("can generate typical values", {
  df <- tibble::tibble(
    x = rep(c("a", "b"), each = 5),
    y = rep(c("a", "b"), 5),
    z = rnorm(10)
  )
  mod <- lm(z ~ x + y, data = df)
  out <- data_grid(df, .model = mod)

  expect_equal(out$x, c("a", "a", "b", "b"))
  expect_equal(out$y, c("a", "b", "a", "b"))
})

test_that("data_grid() works as expected when no model is supplied", {
  expect_equal(
    tidyr::expand(mtcars, cyl = seq_range(cyl, 9)),
    data_grid(mtcars, cyl = seq_range(cyl, 9))
  )
})

test_that("data_grid() returns a tibble", {
  mod <- lm(mpg ~ wt + cyl + vs, data = mtcars)
  expect_equal(
    class(data_grid(mtcars, .model = mod)),
    c("tbl_df", "tbl", "data.frame")
  )
})
