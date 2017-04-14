#' Find the typical value
#'
#' For numeric vectors, it returns the median. For factors, characters, and
#' logical vectors, it returns the most frequent value. If multiple values are
#' tied for most frequent, it returns them all. \code{NA} missing values are
#' always silently dropped.
#'
#' @param x A vector
#' @export
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
typical <- function(x) {
  UseMethod("typical")
}

#' @export
typical.numeric <- function(x) {
  stats::median(x, na.rm = TRUE)
}

#' @export
typical.factor <- function(x) {
  counts <- table(x)
  levels(x)[max(counts) == counts]
}

#' @export
typical.character <- function(x) {
  counts <- table(x)
  names(counts)[max(counts) == counts]
}

#' @export
typical.logical <- function(x) {
  mean(x, na.rm = TRUE) >= 0.5
}
