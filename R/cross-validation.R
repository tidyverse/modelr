#' Generate \code{n} MCMC cross-validated test-training pairs
#'
#' @inheritParams resample_partition
#' @param n Number of test-training pairs to generate
#' @param test Proportion of observations that should be held out for testing.
#' @return A data frame with \code{n} rows and columns \code{test} and
#'   \code{train}. These are list columns containing \code{\link{resample}}
#'   objects.
#' @export
#' @examples
#' cv <- crossv_mcmc(mtcars, 100)
#'
#' library(purrr)
#' models <- map(cv$train, ~ lm(mpg ~ wt, data = .))
#' errs <- map2_dbl(models, cv$test, rmse)
#' hist(errs)
crossv_mcmc <- function(data, n, test = 0.1) {
  if (!is.numeric(n) || length(n) != 1) {
    stop("`n` must be a single integer.", call. = FALSE)
  }
  if (!is.numeric(test) || length(test) != 1 || test <= 0 || test >= 1) {
    stop("`test` must be a value between 0 and 1.", call. = FALSE)
  }

  p <- c(test = test, train = 1 - test)
  runs <- purrr::rerun(n, resample_partition(data, p))
  cols <- purrr::transpose(runs)

  tibble::as_data_frame(cols)
}
