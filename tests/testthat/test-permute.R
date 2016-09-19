context("permute")

test_that("resample_permutation generates permutations of one column", {
  p <- resample_permutation(mtcars, "mpg")

  expect_is(p, "permutation")

  expect_true(any(p$mpg != mtcars$mpg))
  expect_equal(sort(p$mpg), sort(mtcars$mpg))
  expect_equal(p$cyl, mtcars$cyl)
  expect_equal(p$am, mtcars$am)
})

test_that("permute generates n permutations", {
  ps <- permute(mtcars, "mpg", 100)

  expect_is(ps, "tbl_df")
  expect_equal(nrow(ps), 100)
  expect_is(ps$perm, "list")

  p <- ps$perm[[1]]
  expect_is(p, "permutation")

  expect_true(any(p$mpg != mtcars$mpg))
  expect_equal(sort(p$mpg), sort(mtcars$mpg))
  expect_equal(p$cyl, mtcars$cyl)
  expect_equal(p$am, mtcars$am)
})
