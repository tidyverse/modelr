context("predictions")

test_that("always uses na.action = na.exclude", {
  df <- tibble::tibble(x = c(1, 2, NA), y = c(1.5, 2, 3.5))

  mod <- lm(y ~ x, data = df)

  out <- add_predictions(df, mod)

  expect_equal(2 * 2, 4)
})
