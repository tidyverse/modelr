#' Generate an exclusive partitioning of a data frame
#'
#' @param data A data frame
#' @param p A named numeric vector giving where the value is the probability
#'   that an observation will be assigned to that group.
#' @inheritParams resampling techniques
#' @export
#' @examples
#' ex <- resample_partition(mtcars, c(test = 0.3, train = 0.7))
#' mod <- lm(mpg ~ wt, data = ex$train)
#' rmse(mod, ex$test)
#' rmse(mod, ex$train)
resample_partition <- function(data, p) {
  if (!is.numeric(p) || length(p) < 2 || !all(has_name(p))) {
    stop("`p` must be a named numeric vector with at least two values.")
  }

  if (abs(sum(p) - 1) > 1e-6) {
    message("Rescaling `p` to sum to 1.")
  }
  # Always rescale so sums exactly to 1
  p <- p / sum(p)

  n <- nrow(data)
  g <- findInterval(seq_len(n) / n, c(0, cumsum(p)), rightmost.closed = TRUE)

  idx <- split(seq_len(n), sample(g))
  names(idx) <- names(p)

  map(idx, resample, data = data)
}
