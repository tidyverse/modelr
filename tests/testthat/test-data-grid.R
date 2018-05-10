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
