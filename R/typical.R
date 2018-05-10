#' Find the typical value
#'
#' For numeric, integer, and ordered factor vectors, it returns the median.
#' For factors, characters, and logical vectors, it returns the most
#' frequent value. If multiple values are tied for most frequent, it returns
#' them all. `NA` missing values are always silently dropped.
#'
#' @param x A vector
#' @param ... Arguments used by methods
#' @export
#' @importFrom stats quantile
#' @examples
#' # median of numeric vector
#' typical(rpois(100, lambda = 10))
#'
#' # most frequent value of character or factor
#' x <- sample(c("a", "b", "c"), 100, prob = c(0.6, 0.2, 0.2), replace = TRUE)
#' typical(x)
#' typical(factor(x))
#'
#' # if tied, returns them all
#' x <- c("a", "a", "b", "b", "c")
#' typical(x)
#'
#' # median of an ordered factor
#' typical(ordered(c("a", "a", "b", "c", "d")))
#'
typical <- function(x, ...) {
  UseMethod("typical")
}

#' @export
typical.numeric <- function(x, ...) {
  stats::median(x, na.rm = TRUE)
}

#' @export
typical.factor <- function(x, ...) {
  counts <- table(x)
  levels(x)[max(counts) == counts]
}

#' @export
typical.character <- function(x, ...) {
  counts <- table(x)
  names(counts)[max(counts) == counts]
}

#' @export
typical.logical <- function(x, ...) {
  mean(x, na.rm = TRUE) >= 0.5
}

#' @export
typical.integer <- function(x, ...) {
  unname(stats::quantile(x, 0.5, type = 1, na.rm = TRUE))
}

#' @export
typical.ordered <- function(x, ...) {
  as.character(stats::quantile(x, 0.5, type = 1, na.rm = TRUE))
}
