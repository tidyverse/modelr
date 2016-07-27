#' Generate a data grid.
#'
#' To visualise a model, it is very useful to be able to generate an
#' evenly spaced grid of points from the data. \code{data_grid} helps you
#' do this by wrapping around \code{\link[tidyr]{expand}()}.
#'
#' @param data A data frame
#' @param ... Variables passed on to \code{\link[tidyr]{expand}()}
#' @param .model A model.  If supplied, any predictors needed for the model
#'   not present in \code{...} will be filled in with "\link{typical}" values.
#' @export
#' @seealso \code{\link{seq_range}()} for generating ranges from continuous
#'   variables.
#' @examples
#' data_grid(mtcars, vs, am)
#'
#' # For continuous variables, seq_range is useful
#' data_grid(mtcars, mpg = seq_range(mpg, 10))
#'
#' # If you optionally supply a model, missing predictors will
#' # be filled in with typical values
#' mod <- lm(mpg ~ wt + cyl + vs, data = mtcars)
#' data_grid(mtcars, .model = mod)
#' data_grid(mtcars, cyl = seq_range(cyl, 9), .model = mod)
data_grid <- function(data, ..., .model = NULL) {
  expanded <- tidyr::expand(data, ...)

  if (is.null(.model))
    return(expanded)

  # Generate grid of typical values
  needed <- setdiff(predictor_vars(.model), names(expanded))
  typical <- tidyr::crossing_(lapply(data[needed], typical))

  tidyr::crossing(expanded, typical)
}
