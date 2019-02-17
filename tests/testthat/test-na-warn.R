context("test-na-warn")

test_that("na.warn warns when dropping", {
  df <- data.frame(x = 1:5, y = c(1, NA, 3, NA, 5))
  expect_warning(mod <- lm(y ~ x, data = df, na.action = na.warn), "Dropping 2")
  pred <- unname(predict(mod))
  expect_equal(is.na(pred), is.na(df$y))
})
