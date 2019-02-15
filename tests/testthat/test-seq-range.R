context("seq-range")

test_that("seq_range() can generate error messages and typical values", {
  x <- 1:4
  expect_error(
    seq_range(x, by = 0.1, n = 10, expand = 0.5, pretty = TRUE),
    "one of"
  )
  expect_equal(seq_range(x, n = 4), c(1, 2, 3, 4))

  out <- seq_range(x, n = 3, expand = 0.5, pretty = TRUE)
  expect_equal(out, c(0, 2, 4, 6))

  out <- seq_range(x, by = 150, expand = 0.5, pretty = TRUE)
  expect_equal(out, c(0, 150))
})
