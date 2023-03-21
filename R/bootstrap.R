#' @importFrom broom tidy
NULL

#' Generate `n` bootstrap replicates.
#'
#' @inheritParams resample_partition
#' @family resampling techniques
#' @param n Number of bootstrap replicates to generate
#' @param id Name of variable that gives each model a unique integer id.
#' @return A data frame with `n` rows and one column: `strap`
#' @export
#' @examples
#' library(purrr)
#' boot <- bootstrap(mtcars, 100)
#'
#' models <- map(boot$strap, ~ lm(mpg ~ wt, data = .))
#' tidied <- map_df(models, broom::tidy, .id = "id")
#'
#' hist(subset(tidied, term == "wt")$estimate)
#' hist(subset(tidied, term == "(Intercept)")$estimate)
bootstrap <- function(data, n, id = ".id") {
  bootstrap <- purrr::map(seq_len(n), ~ resample_bootstrap(data))

  df <- tibble::tibble(strap = bootstrap)
  df[[id]] <- id(n)
  df
}

#' Generate a boostrap replicate
#'
#' @param data A data frame
#' @family resampling techniques
#' @export
#' @examples
#' coef(lm(mpg ~ wt, data = resample_bootstrap(mtcars)))
#' coef(lm(mpg ~ wt, data = resample_bootstrap(mtcars)))
#' coef(lm(mpg ~ wt, data = resample_bootstrap(mtcars)))
resample_bootstrap <- function(data) {
  resample(data, sample(nrow(data), replace = TRUE))
}
