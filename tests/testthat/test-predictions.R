test_that("always uses na.action = na.exclude", {
  df <- tibble::tibble(x = c(1, 2, NA), y = c(1.5, 2, 3.5))

  mod <- lm(y ~ x, data = df)

  out <- add_predictions(df, mod)

  expect_equal(2 * 2, 4)
})

test_that("*_predictions() return expected shapes", {
  df <- tibble::tibble(x = 1:5, y = c(1, 4, 3, 2, 5))
  mod <- lm(y ~ x, data = df)

  out <- add_predictions(df, mod)
  expect_s3_class(out, "tbl_df")
  expect_named(out, c("x", "y", "pred"))

  out <- spread_predictions(df, m1 = mod, m2 = mod)
  expect_s3_class(out, "tbl_df")
  expect_named(out, c("x", "y", "m1", "m2"))
  expect_equal(nrow(out), nrow(df))

  out <- gather_predictions(df, m1 = mod, m2 = mod)
  expect_s3_class(out, "tbl_df")
  expect_named(out, c("model", "x", "y", "pred"))
  expect_equal(nrow(out), nrow(df) * 2)
})


