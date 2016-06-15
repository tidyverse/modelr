#' Generate a boostrap replicate
#'
#' @param data A data frame
#' @export
#' @examples
#' coef(lm(mpg ~ wt, data = bootstrap(mtcars)))
#'
#' library(purrr)
#' bootstraps <- rerun(100, bootstrap(mtcars))
#' models <- map(bootstraps, ~ lm(mpg ~ wt, data = .))
#' tidied <- map_df(models, broom::tidy, .id = "id")
#'
#' hist(subset(tidied, term == "wt")$estimate)
#' hist(subset(tidied, term == "(Intercept)")$estimate)
bootstrap <- function(data) {
  resample(data, sample(nrow(data), replace = TRUE))
}
