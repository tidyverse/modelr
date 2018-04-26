context("typical")

test_that("typical.numeric works as expected", {
  x <- c(1, 2, 5)
  expect_equal(typical(x), median(x))
  expect_equal(typical(c(x, NA)), median(x))
})

test_that("typical.character works as exepected", {
  expect_equal(typical(c("a", "a", "b")), "a")
  expect_equal(typical(c("a", "a", "b", "b")), c("a", "b"))
})

test_that("typical.factor works as exepected", {
  expect_equal(typical(factor(c("a", "a", "b"))), "a")
  expect_equal(typical(factor(c("a", "a", "b", "b"))), c("a", "b"))
})

test_that("typical.logical works as exepected", {
  expect_equal(typical(c(TRUE, FALSE, TRUE)), TRUE)
})

test_that("typical.data.frame works as expected", {
  df <- tibble::tribble(
    ~ a, ~ b, ~ c, ~ d,
    1, "a", "c", TRUE,
    2, "b", "c", FALSE,
    5, "a", "d", TRUE
  )
  df[["c"]] <- factor(df[["c"]])
  expect_identical(
    typical(df),
    tibble::tibble(a = 2, b = "a", c = "c", d = TRUE)
  )
})

test_that("typical.data.frame works with non-unique values", {
  df <- tibble::tribble(
    ~ a, ~ b, ~ c, ~ d,
    1, "a", "c", TRUE,
    2, "b", "d", FALSE
  )
  df[["c"]] <- factor(df[["c"]])
  expect_identical(
    typical(df),
    tibble::tribble(
      ~ a, ~ b, ~ c, ~ d,
      1.5, "a", "c", TRUE,
      1.5, "a", "d", TRUE,
      1.5, "b", "c", TRUE,
      1.5, "b", "d", TRUE
    )
  )
})
