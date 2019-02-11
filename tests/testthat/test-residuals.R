context("residuals")

test_that("prediction functions return expected outputs", {
  df <- tibble::data_frame(
    x = sort(runif(100)),
    y = 5 * x + 0.5 * x ^ 2 + 3 + rnorm(length(x))
  )
  m1 <- lm(y ~ x, data = df)
  m2 <- lm(y ~ poly(x, 2), data = df)
  m3 <- lm(y ~ poly(x, 3), data = df)

  # spread_residuals() and gather_residuals() are the reverse of each other
  expect_equal(
    spread_residuals(df, m1, m2, m3) %>%
      tidyr::gather(model, resid, -y, -x),
    gather_residuals(df, m1, m2, m3)
  )

  expect_equal(
    gather_residuals(df, m1, m2, m3) %>%
      tidyr::spread(model, resid),
    spread_residuals(df, m1, m2, m3)
  )

  # *_residuals() leaves class unchanged
  expect_equal(
    class(add_residuals(df, m1)),
    c("tbl_df", "tbl", "data.frame")
  )
  expect_equal(
    class(spread_residuals(df, m1, m2, m3)),
    c("tbl_df", "tbl", "data.frame")
  )
  expect_equal(
    class(gather_residuals(df, m1, m2, m3)),
    c("tbl_df", "tbl", "data.frame")
  )
})
