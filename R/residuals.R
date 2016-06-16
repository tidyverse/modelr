#' Add residuals to a data frame
#'
#' @param data A data frame used to generate the residuals
#' @param model,var \code{add_residuals} takes a single \code{model}; the
#'   output column will be called \code{pred}
#' @param ... \code{gather_residuals} and \code{spread_residuals} take
#'   multiple models. The name will be taken from either the argument
#'   name of the name of the model.
#' @param .resid,.model The variable names used by \code{gather_residuals}.
#' @return A data frame. \code{add_prediction} adds a single new column,
#'   \code{.pred}, to the input \code{data}. \code{spread_residuals} adds
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
#' df %>% add_residuals(m1)
#'
#' m2 <- lm(y ~ poly(x, 2), data = df)
#' df %>% spread_residuals(m1, m2)
#' df %>% gather_residuals(m1, m2)
add_residuals <- function(data, model, var = "resid") {
  data[[var]] <- residuals(model, data)
  data
}

#' @rdname add_residuals
#' @export
spread_residuals <- function(data, ...) {
  models <- tibble::lst(...)
  for (nm in names(models)) {
    data[[nm]] <- residuals(models[[nm]], data)
  }
  data
}

#' @rdname add_residuals
#' @export
gather_residuals <- function(data, ..., .resid = "resid", .model = "model") {
  models <- tibble::lst(...)

  df <- purrr::map2(models, .resid, add_residuals, data = data)
  names(df) <- names(models)

  dplyr::bind_rows(df, .id = .model)
}

residuals <- function(model, data) {
  response(model, data) - stats::predict(model, data)
}
