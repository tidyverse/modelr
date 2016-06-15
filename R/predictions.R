#' Add predictions to a data frame
#'
#' @param data A data frame used to generate the predictions.
#' @param model,var \code{add_predictions} takes a single \code{model}; the
#'   output column will be called \code{pred}
#' @param ... \code{gather_predictions} and \code{spread_predictions} take
#'   multiple models. The name will be taken from either the argument
#'   name of the name of the model.
#' @param .pred,.model The variable names used by \code{gather_predictions}.
#' @return A data frame. \code{add_prediction} adds a single new column,
#'   \code{.pred}, to the input \code{data}. \code{spread_predictions} adds
#'   one column for each model. \code{gather_prections} adds two columns
#'   \code{.model} and \code{.pred}, and repeats the input rows for
#'   each model.
#' @export
#' @examples
#' df <- tibble::data_frame(
#'   x = sort(runif(100)),
#'   y = 5 * x + 0.5 * x ^ 2 + 3 + rnorm(length(x))
#' )
#' plot(df)
#'
#' m1 <- lm(y ~ x, data = df)
#' grid <- data.frame(x = seq(0, 1, length = 10))
#' grid %>% add_predictions(m1)
#'
#' m2 <- lm(y ~ poly(x, 2), data = df)
#' grid %>% spread_predictions(m1, m2)
#' grid %>% gather_predictions(m1, m2)
add_predictions <- function(data, model, var = "pred") {
  data[[var]] <- stats::predict(model, data)
  data
}

#' @rdname add_predictions
#' @export
spread_predictions <- function(data, ...) {
  models <- tibble::lst(...)
  for (nm in names(models)) {
    data[[nm]] <- stats::predict(models[[nm]], data)
  }
  data
}

#' @rdname add_predictions
#' @export
gather_predictions <- function(data, ..., .pred = "pred", .model = "model") {
  models <- tibble::lst(...)

  df <- purrr::map2(models, .pred, add_predictions, data = data)
  names(df) <- names(models)

  dplyr::bind_rows(df, .id = .model)
}
