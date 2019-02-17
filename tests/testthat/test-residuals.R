context("residuals")

test_that("*_residuals() return expected shapes", {
  df <- tibble::tibble(x = 1:5, y = c(1, 4, 3, 2, 5))
  m1 <- lm(y ~ x, data = df)
  m2 <- lm(y ~ poly(x, 2), data = df)

  out <- spread_residuals(df, m1, m2)
  expect_s3_class(out, "tbl_df")
  expect_named(out, c("x", "y", "m1", "m2"))
  expect_equal(nrow(out), nrow(df))

  out <- gather_residuals(df, m1, m2)
  expect_s3_class(out, "tbl_df")
  expect_named(out, c("model", "x", "y", "resid"))
  expect_equal(nrow(out), nrow(df) * 2)

  out <- add_residuals(df, m1)
  expect_s3_class(out, "tbl_df")
  expect_named(out, c("x", "y", "resid"))
})
