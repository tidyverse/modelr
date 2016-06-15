#' Compute model quality for a given dataset
#'
#' \code{rmse} is the root-mean-squared-error, \code{mae} is the median
#' absolute error, \code{qae} is quantiles of absolute error. These can both
#' be interpreted on the scale of the response; \code{mae} is less sensitive
#' to outliers. \code{rsquare} is the variance of the predictions divided by
#' by the variance of the response.
#'
#' @param model A model
#' @param data The dataset
#' @name model-quality
#' @examples
#' mod <- lm(mpg ~ wt, data = mtcars)
#' rmse(mod, mtcars)
#' rsquare(mod, mtcars)
#' mae(mod, mtcars)
#' qae(mod, mtcars)
NULL

#' @export
#' @rdname model-quality
rmse <- function(model, data) {
  x <- residuals(model, data)
  sqrt(mean(x ^ 2))
}

#' @export
#' @rdname model-quality
mae <- function(model, data) {
  x <- residuals(model, data)
  mean(abs(x))
}

#' @export
#' @rdname model-quality
rsquare <- function(model, data) {
  stats::var(stats::predict(model, data)) / stats::var(response(model, data))
}

#' @export
#' @rdname model-quality
#' @param probs Numeric vector of probabilit
qae <- function(model, data, probs = c(0.05, 0.25, 0.5, 0.75, 0.95)) {
  x <- residuals(model, data)
  stats::quantile(abs(x), probs)
}
