context("geom-ref-line")

test_that("at least one ref line position argument is supplied", {
  expect_error(geom_ref_line(), "one of")
})
