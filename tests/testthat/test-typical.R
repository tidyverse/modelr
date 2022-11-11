test_that("typical.numeric works as expected", {
  x <- c(1, 2, 5)
  expect_equal(typical(x), median(x))
  expect_equal(typical(c(x, NA)), median(x))
})

test_that("typical.character works as exepected", {
  expect_equal(typical(c("a", "a", "b")), "a")
  expect_equal(typical(c("a", "a", "b", "b", NA_character_)), c("a", "b"))
  expect_equal(typical(c("a", "a", "b", "b")), c("a", "b"))
})

test_that("NA values are considered typical", {
  x <- c(NA, NA, NA, "x")
  expect_equal(typical(x), NA_character_)

  f <- factor(x, exclude = NULL)
  expect_equal(typical(f), NA_character_)
})

test_that("typical.factor works as exepected", {
  expect_equal(typical(factor(c("a", "a", "b"))), "a")
  expect_equal(typical(factor(c("a", "a", "b", NA))), "a")
  expect_equal(typical(factor(c("a", "a", "b", "b"))), c("a", "b"))
})

test_that("typical.logical works as exepected", {
  expect_equal(typical(c(TRUE, FALSE, TRUE)), TRUE)
  expect_equal(typical(c(TRUE, TRUE, FALSE, FALSE)), TRUE)
  expect_equal(typical(c(TRUE, FALSE, TRUE, NA)), TRUE)
})

test_that("typical.ordered works as expected", {
  expect_identical(typical(ordered(c("d", "d", "a", "b"))), "b")
  expect_identical(typical(ordered(c("d", "d", "a", "b", NA))), "b")
})

test_that("typical.integer works as expected", {
  expect_equal(typical(c(1L, 2L, 3L, 8L)), 2)
  expect_equal(typical(c(1L, 2L, 3L, 8L, NA_integer_)), 2)
})
