#' Handle missing values with a warning
#'
#' This NA handler ensures that those models that support the
#' `na.action` parameter do not silently drop missing values. It
#' wraps around [stats::na.exclude()] so that there is one
#' prediction/residual for input row. To apply it globally, run
#' `options(na.action = na.warn)`.
#'
#' @param object A data frame
#' @export
#' @examples
#' df <- tibble::tibble(
#'   x = 1:10,
#'   y = c(5.1, 9.7, NA, 17.4, 21.2, 26.6, 27.9, NA, 36.3, 40.4)
#' )
#' # Default behaviour is to silently drop
#' m1 <- lm(y ~ x, data = df)
#' resid(m1)
#'
#' # Use na.action = na.warn to warn
#' m2 <- lm(y ~ x, data = df, na.action = na.warn)
#' resid(m2)
na.warn <- function(object) {
  missing <- sum(!stats::complete.cases(object))
  if (missing > 0) {
    warning("Dropping ", missing, " rows with missing values", call. = FALSE)
  }

  stats::na.exclude(object)
}
