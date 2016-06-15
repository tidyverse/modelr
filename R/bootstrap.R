#' Generate \code{n} bootstrap replicates.
#'
#' @inheritParams resample_partition
#' @param n Number of test-training pairs to generate
#' @return A data frame with \code{n} rows and one column: \code{strap}
#' @export
#' @examples
#' library(purrr)
#' boot <- bootstrap(mtcars, 100)
#'
#' models <- map(boot$strap, ~ lm(mpg ~ wt, data = .))
#' tidied <- map_df(models, broom::tidy, .id = "id")
#'
#' hist(subset(tidied, term == "wt")$estimate)
#' hist(subset(tidied, term == "(Intercept)")$estimate)
bootstrap <- function(data, n) {
  bootstrap <- purrr::rerun(n, resample_bootstrap(data))
  tibble::data_frame(strap = bootstrap)
}

#' Generate a boostrap replicate
#'
#' @param data A data frame
#' @inheritParams resampling techniques
#' @export
#' @examples
#' coef(lm(mpg ~ wt, data = resample_bootstrap(mtcars)))
#' coef(lm(mpg ~ wt, data = resample_bootstrap(mtcars)))
#' coef(lm(mpg ~ wt, data = resample_bootstrap(mtcars)))
resample_bootstrap <- function(data) {
  resample(data, sample(nrow(data), replace = TRUE))
}