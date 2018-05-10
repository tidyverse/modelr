
context("formulas")

test_that("add_predictors() combines predictors", {
  expect_identical(add_predictors(~1, ~2, ~3), ~1 + 2 + 3)
})

test_that("add_predictors() combines with fun", {
  expect_identical(add_predictors(~1, ~2, ~3, fun = "*"), ~1 * 2 * 3)
})

test_that("add_predictors() handles lhss", {
  expect_identical(add_predictors(lhs ~ 1, ~2), lhs ~ 1 + 2)
  expect_identical(add_predictors(lhs1 ~ 1, lhs2 ~ 2), lhs1 ~ 1 + 2)
})

test_that("merge_formula() handles lhss", {
  expect_identical(merge_formulas(lhs ~ rhs, lhs ~ rhs), lhs ~ rhs + rhs)
  expect_error(merge_formulas(lhs ~ rhs, other_lhs ~ rhs), "must be identical")
})

test_that("merging formulas fail when scope conflicts within symbols", {
  env <- new.env(parent = emptyenv())
  env$object <- list()
  object <- list()

  f_conflict <- new_formula(NULL, quote(object), env = env)
  expect_error(merge_envs(~object, f_conflict), "conflict for the symbol 'object'")
})

test_that("merging formulas fail when scope conflicts between symbols", {
  env1 <- new.env(parent = emptyenv())
  env1$object <- list()
  env2 <- new.env(parent = emptyenv())
  env2$other_object <- list()
  f1 <- new_formula(NULL, quote(list(object)), env = env1)
  f2 <- new_formula(NULL, quote(list(other_object)), env = env2)
  expect_error(merge_envs(f1, f2), "conflict across symbols")
})


test_that("formulas() fails when supplied non-formula objects", {
  expect_error(formulas(~lhs, NULL), "must contain only formulas")
})

test_that("formulas() combines the lhs", {
  expect_equal(formulas(~lhs, a = ~1, b = other ~ 2), list(a = lhs ~ 1, b = lhs ~ 2))
})

test_that("bytecoded fit_with() works", {
  bc_fit_with <- compiler::cmpfun(fit_with)
  fit <- bc_fit_with(mtcars, lm, list(disp ~ drat))
  expect_is(fit[[1]], "lm")
})
