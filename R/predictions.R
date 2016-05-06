#' Add predictions to a data frame
#'
#' @param data A data frame used to generate the predictions.
#' @param ... Name-value pairs giving the variable name and model.
#' @export
#' @examples
#' m1 <- lm(mpg ~ wt, data = mtcars)
#' m2 <- lm(mpg ~ poly(wt, 2), data = mtcars)
#' mtcars %>%
#'   add_predictions(m1 = m1, m2 = m2)
add_predictions <- function(data, ...) {
  models <- list(...)
  for (nm in names(models)) {
    data[[nm]] <- predict(models[[nm]], data)
  }
  data
}

