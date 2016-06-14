#' Partition a dataset into test and training splits
#'
#' @param data A data frame
#' @param p A named numeric vector giving where the value is the probability
#'   that an observation will be assigned to that group.
#' @export
#' @examples
#' ex <- partition(mtcars, c(test = 0.3, train = 0.7))
#' mod <- lm(mpg ~ wt, data = ex$train)
#' rmse(mod, ex$test)
#' rmse(mod, ex$train)
#'
#' # Repeat 100 times
#' library(purrr)
#' crossv <- transpose(rerun(100, partition(mtcars, c(test = 0.3, train = 0.7))))
#' models <- map(crossv$train, ~ lm(mpg ~ wt, data = .))
#' errs <- map2_dbl(models, crossv$test, rmse)
#' hist(errs)
partition <- function(data, p) {
  if (!is.numeric(p) || length(p) < 2 || !all(has_names(p))) {
    stop("`p` must be a named numeric vector with at least two values.")
  }

  if (abs(sum(p) - 1) > 1e-6) {
    message("Rescaling `p` to sum to 1.")
  }
  # Always rescale so sums exactly to 1
  p <- p / sum(p)

  n <- nrow(data)
  g <- findInterval(seq_len(n) / n, c(0, cumsum(p)), rightmost.closed = TRUE)

  out <- split(data, sample(g))
  names(out) <- names(p)

  out
}
