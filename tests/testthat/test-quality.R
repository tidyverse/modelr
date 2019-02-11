context("quality")

test_that("model quality metrics work as expected", {
  mod <- lm(mpg ~ wt, data = mtcars)

  expect_equal(mse(mod, mtcars), 8.697561, tolerance = 0.0000001)

  expect_equal(rmse(mod, mtcars), 2.949163, tolerance = 0.000001)

  expect_equal(rsquare(mod, mtcars), 0.7528328, tolerance = 0.0000001)

  expect_equal(mae(mod, mtcars), 2.340642, tolerance = 0.0000001)

  expect_equal(
    qae(mod, mtcars),
    c(`5%` = 0.178498526,
      `25%` = 1.000563995,
      `50%`= 2.094619881,
      `75%` = 3.269610822,
      `95%` = 6.17948154)
  )

  expect_equal(mape(mod, mtcars), 0.1260733, tolerance = 0.0000001)

  expect_equal(rsae(mod, mtcars), 0.1165042, tolerance = 0.0000001)

})



