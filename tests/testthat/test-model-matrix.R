context("model-matrix")

test_that("model_matrix() returns a tibble", {
  out <- model_matrix(iris, Sepal.Length ~ Species)
  expect_s3_class(out, "tbl_df")
})
