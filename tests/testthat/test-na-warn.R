context("test-na-warn")

test_that("Check dropping NA warning", {
  df <- tibble::tibble(
    x = 1:10,
    y = c(5.1, 9.7, NA, 17.4, 21.2, 26.6, 27.9, NA, 36.3, 40.4)
  )
  missing <- sum(!stats::complete.cases(df))

  expect_warning(
    lm(y ~ x, data = df, na.action = na.warn),
    paste0("Dropping ", missing, " rows with missing values")
  )
})
