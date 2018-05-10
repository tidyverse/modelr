#' Compute model quality for a given dataset
#'
#' @description
#' Three summaries are immediately interpretible on the scale of the response
#' variable:
#' * `rmse()` is the root-mean-squared-error
#' * `mae()` is the mean absolute error
#' * `qae()` is quantiles of absolute error.
#'
#' Other summaries have varying scales and interpretations:
#' * `mape()` mean absolute percentage error.
#' * `rsae()` is the relative sum of absolute errors.
#' * `mse()` is the mean-squared-error.
#' * `rsquare()` is the variance of the predictions divided by the
#'   variance of the response.
#' @param model A model
#' @param data The dataset
#' @name model-quality
#' @examples
#' mod <- lm(mpg ~ wt, data = mtcars)
#' mse(mod, mtcars)
#' rmse(mod, mtcars)
#' rsquare(mod, mtcars)
#' mae(mod, mtcars)
#' qae(mod, mtcars)
#' mape(mod, mtcars)
#' rsae(mod, mtcars)
NULL

#' @export
#' @rdname model-quality
mse <- function(model, data) {
  x <- residuals(model, data)
  mean(x^2, na.rm = TRUE)
}

#' @export
#' @rdname model-quality
rmse <- function(model, data) {
  x <- residuals(model, data)
  sqrt(mean(x^2, na.rm = TRUE))
}

#' @export
#' @rdname model-quality
mae <- function(model, data) {
  x <- residuals(model, data)
  mean(abs(x), na.rm = TRUE)
}

#' @export
#' @rdname model-quality
rsquare <- function(model, data) {
  x <- residuals(model, data)
  y <- response(model, data)

  1 - stats::var(x, na.rm = TRUE) / stats::var(y, na.rm = TRUE)
}

#' @export
#' @rdname model-quality
#' @param probs Numeric vector of probabilities
qae <- function(model, data, probs = c(0.05, 0.25, 0.5, 0.75, 0.95)) {
  x <- residuals(model, data)
  stats::quantile(abs(x), probs, na.rm = TRUE)
}

#' @export
#' @rdname model-quality
mape <- function(model, data) {
  x <- residuals(model, data)
  y <- response(model, data)
  mean(abs(x / y), na.rm = TRUE)
}

#' @export
#' @rdname model-quality
rsae <- function(model, data) {
  x <- residuals(model, data)
  y <- response(model, data)

  miss <- is.na(x) | is.na(y)
  sum(abs(x[!miss])) / sum(abs(y[!miss]))
}
