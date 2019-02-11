context("model-matrix")

test_that("model_matrix() returns a tibble", {
  expect_equal(
    class(model_matrix(iris, Sepal.Length ~ Species)),
    c("tbl_df", "tbl", "data.frame")
  )
})
