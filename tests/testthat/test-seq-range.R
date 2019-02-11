context("seq-range")

test_that("seq_range() works as expected", {
  set.seed(145)
  x <- rcauchy(100)

  expect_error(
    seq_range(x, by = 0.1, n = 10, expand = 0.5, pretty = TRUE),
    "May only specify one of `n` and `by`"
  )
  expect_equal(
    seq_range(x, n = 3, trim = 0.1),
    c(-6.4088086, -0.4412197, 5.5263692)
  )
  expect_equal(
    seq_range(x, n = 3),
    c(-445.56189, -209.92452,  25.71285),
    tolerance = 0.0000001
  )
  expect_equal(
    seq_range(x, by = 4, trim = 0.1),
    c(-6.408809, -2.408809, 1.591191),
    tolerance = 0.000001
  )
  expect_equal(
    seq_range(x, n = 3, expand = 0.5, pretty = TRUE),
    c(-600, -400, -200, 0, 200)
  )
  expect_equal(
    seq_range(x, by = 150, expand = 0.5, pretty = TRUE),
    c(-600, -450, -300, -150, 0, 150)
  )
})
