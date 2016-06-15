#' Add residuals to a data frame
#'
#' @param data A data frame used to generate the predictions.
#' @param ... Name-value pairs giving the variable name and model.
#' @export
#' @examples
#' m1 <- lm(mpg ~ wt, data = mtcars)
#' m2 <- lm(mpg ~ poly(wt, 2), data = mtcars)
#' mtcars %>%
#'   add_residuals(m1 = m1, m2 = m2)
add_residuals <- function(data, ...) {
  models <- list(...)

  for (nm in names(models)) {
    model <- models[[nm]]
    data[[nm]] <- residuals(model, data)
  }
  data
}


response <- function(model, data) {
  UseMethod("response")
}

#' @export
response.lm <- function(model, data) {
  var <- stats::terms(model)[[2]]
  eval(var, as.data.frame(data))
}


residuals <- function(model, data) {
  response(model, data) - stats::predict(model, data)
}
