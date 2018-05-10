#' Compute model quality for a given dataset
#'
#' `rmse` is the root-mean-squared-error, `mae` is the mean
#' absolute error, `qae` is quantiles of absolute error. These can all
#' be interpreted on the scale of the response; `mae` is less sensitive
#' to outliers. `mse` is the mean-squared-error and can be interpreted on
#' the squared scale of the response. `rsquare` is the variance of the
#' predictions divided by the variance of the response.
#'
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
NULL

#' @export
#' @rdname model-quality
mse <- function (model, data){
  x <- residuals(model, data)
  mean(x ^ 2, na.rm = TRUE)
}

#' @export
#' @rdname model-quality
rmse <- function(model, data) {
  x <- residuals(model, data)
  sqrt(mean(x ^ 2, na.rm = TRUE))
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
  stats::var(stats::predict(model, data), na.rm = TRUE) / stats::var(response(model, data), na.rm = TRUE)
}

#' @export
#' @rdname model-quality
#' @param probs Numeric vector of probabilities
qae <- function(model, data, probs = c(0.05, 0.25, 0.5, 0.75, 0.95)) {
  x <- residuals(model, data)
  stats::quantile(abs(x), probs, na.rm = TRUE)
}
