context("cross validation")

df <- data.frame(x = 1:100)

test_that("seed enables reproducible results", {

  expect_identical(
    crossv_mc(df, n = 3, seed = 10),
    crossv_mc(df, n = 3, seed = 10)
  )

  expect_false(identical(
    crossv_mc(df, n = 3, seed = 10),
    crossv_mc(df, n = 3, seed = 234)
  ))

  expect_identical(
    crossv_kfold(df, seed = 10),
    crossv_kfold(df, seed = 10)
  )

  expect_false(identical(
    crossv_kfold(df, seed = 10),
    crossv_kfold(df, seed = 234)
  ))

})
