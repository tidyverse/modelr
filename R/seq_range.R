#' Generate a sequence over the range of a vector
#'
#' @param x A numeric vector
#' @param n Length of sequence to generate
#' @param trim Optionally, trim values off the tails.
#'   \code{trim / 2 * length(x)} values are removed from each tail.
#' @export
#' @examples
#' x <- rcauchy(100)
#' seq_range(x, 10)
#' seq_range(x, 10, trim = 0.1)
seq_range <- function(x, n, trim = NULL) {
  if (!is.null(trim)) {
    rng <- stats::quantile(x, c(trim / 2, 1 - trim / 2), na.rm = TRUE)
  } else {
    rng <- range(x, na.rm = TRUE)
  }

  seq(rng[1], rng[2], length = n)
}
