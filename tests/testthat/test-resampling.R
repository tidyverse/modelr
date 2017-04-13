context("resampling")

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(purrr))

d <- mtcars %>%
  head(30) %>%
  mutate(row = row_number())

test_that("Can perform cross validation", {
  cross <- crossv_kfold(d, k = 5)

  expect_equal(nrow(cross), 5)

  trains <- map(cross$train, as.data.frame)
  expect_true(all(map_dbl(trains, nrow) == 24))

  tests <- map(cross$test, as.data.frame)
  expect_true(all(map_dbl(tests, nrow) == 6))

  overlaps <- map2(map(trains, "row"), map(tests, "row"), intersect)
  expect_true(all(lengths(overlaps) == 0))
})


test_that("Can perform bootstrapping", {
  boot <- mtcars %>%
    bootstrap(5)

  expect_equal(nrow(boot), 5)

  for (b in boot$strap) {
    bd <- as.data.frame(b)
    expect_equal(nrow(bd), nrow(mtcars))
    expect_true(all(bd$mpg %in% mtcars$mpg))
    expect_false(all(bd$mpg == mtcars$mpg))
  }
})


test_that("Can perform permutation", {
  perm <- mtcars %>%
    permute(5, mpg)

  expect_equal(nrow(perm), 5)

  for (p in perm$perm) {
    pd <- as.data.frame(p)
    expect_equal(mtcars$cyl, pd$cyl)
    expect_equal(mtcars$hp, pd$hp)
    expect_equal(sort(mtcars$mpg), sort(pd$mpg))
    # chance of permutation being the same is basically nil
    expect_false(all(mtcars$mpg == pd$mpg))
  }
})
