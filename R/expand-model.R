#' Expand a grid for a model
#'
#' This is a wrapper around \code{\link[tidyr]{expand}()} that automatically
#' fills in variables not otherwise provided with their typical values.
#'
#' @param data A data frame
#' @param model A model
#' @param ... Variables passed on to \code{\link[tidyr]{expand}()}
#' @export
#' @examples
#' mod <- lm(mpg ~ wt + cyl + vs, data = mtcars)
#' expand_model(mtcars, mod)
#' expand_model(mtcars, mod, cyl = seq_range(cyl, 9))
expand_model <- function(data, model, ...) {
  expanded <- tidyr::expand(data, ...)

  # Generate grid of typical values
  needed <- setdiff(predictor_vars(model), names(expanded))
  typical <- tidyr::crossing_(lapply(data[needed], typical))

  tidyr::crossing(expanded, typical)
}
