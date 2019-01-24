context("geom-ref-line")

test_that("can generate typical outputs and error message", {
  sim <- tibble::tribble(
           ~x,          ~y,       ~resid,
           1L, 4.199912967, -2.072442018,
           1L,  7.51063411,  1.238279125,
           1L, 2.125472778, -4.146882207
           )
  p <- ggplot2::ggplot(sim, ggplot2::aes(x, resid))
  expect_error( # error message created when no reference line is provided
    p + geom_ref_line() +
      ggplot2::geom_point(),
    "Must supply one of `h` and `v`."
  )
  expect_equal(
    p + geom_ref_line(h = 0),
    p + ggplot2::geom_hline(yintercept = 0, size = 2, colour = "white")
  )
  expect_equal(
    p + geom_ref_line(v = 0),
    p + ggplot2::geom_vline(xintercept = 0, size = 2, colour = "white")
  )
})
