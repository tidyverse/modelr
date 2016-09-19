context("resample")

test_that("resample objects can be accessed with as.data.frame", {
  r <- resample(mtcars, 32:1)

  expect_is(r, "resample")

  d <- as.data.frame(r)
  expect_is(d, "data.frame")
  expect_equal(d$mpg, rev(mtcars$mpg))
})


test_that("resample objects can be accessed with $ or [[", {
  r <- resample(mtcars, 32:1)
  expect_equal(r$mpg, rev(mtcars$mpg))
  expect_equal(r[["mpg"]], rev(mtcars$mpg))
})
