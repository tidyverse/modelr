context("predictions")

test_that("always uses na.action = na.exclude", {
  df <- tibble::tibble(x = c(1, 2, NA), y = c(1.5, 2, 3.5))

  mod <- lm(y ~ x, data = df)

  out <- add_predictions(df, mod)

  expect_equal(2 * 2, 4)
})

test_that("functions return tibbles", {
  df <- tibble::data_frame(
    x = sort(runif(100)),
    y = 5 * x + 0.5 * x ^ 2 + 3 + rnorm(length(x))
  )
  m1 <- lm(y ~ x, data = df)
  m2 <- lm(y ~ poly(x, 2), data = df)
  m3 <- lm(y ~ poly(x, 3), data = df)

  # return tibbles
  expect_equal(
    class(add_predictions(df, m1)),
    c("tbl_df", "tbl", "data.frame")
  )
  expect_equal(
    class(spread_predictions(df, m1, m2, m3)),
    c("tbl_df", "tbl", "data.frame")
  )
  expect_equal(
    class(gather_predictions(df, m1, m2, m3)),
    c("tbl_df", "tbl", "data.frame")
  )

  # outputs have expected dimensions
  expect_equal(
    dim(add_predictions(df, m1)),
    c(100, 3)
  )
  expect_equal(
    dim(spread_predictions(df, m1, m2, m3)),
    c(100, 5)
  )
  expect_equal(
    dim(gather_predictions(df, m1, m2, m3)),
    c(300, 4)
  )
})


