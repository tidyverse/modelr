#' Construct a design matrix
#'
#' This is a thin wrapper around [stats::model.matrix()] which
#' returns a tibble. Use it to determine how your modelling formula is
#' translated into a matrix, an thence into an equation.
#'
#' @param data A data frame
#' @param formula A modelling formula
#' @param ... Other arguments passed onto [stats::model.matrix()]
#' @return A tibble.
#' @export
#' @examples
#' model_matrix(mtcars, mpg ~ cyl)
#' model_matrix(iris, Sepal.Length ~ Species)
#' model_matrix(iris, Sepal.Length ~ Species - 1)
model_matrix <- function(data, formula, ...) {
  out <- stats::model.matrix(formula, data = data, ...)
  mostattributes(out) <- NULL

  tibble::as_tibble(out)
}
