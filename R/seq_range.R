#' Generate a sequence over the range of a vector
#'
#' @param x A numeric vector
#' @param n,by Specify the output sequence either by supplying the
#'   length of the sequence with \code{n}, or the spacing between value
#'   with \code{by}. Specifying both is an error.
#'
#'   I recommend that you name these arguments in order to make it clear to
#'   the reader.
#' @param pretty If \code{TRUE}, will generate a pretty sequence. If \code{n}
#'   is supplied, this will use \code{\link{pretty}()} instead of
#'   \code{\link{seq}()}. If \code{by} is supplied, it will round the first
#'   value to a multiple of \code{by}.
#' @param trim Optionally, trim values off the tails.
#'   \code{trim / 2 * length(x)} values are removed from each tail.
#' @param expand Optionally, expand the range by \code{expand * (1 + range(x)}
#'   (computed after trimming).
#' @export
#' @examples
#' x <- rcauchy(100)
#' seq_range(x, n = 10)
#' seq_range(x, n = 10, trim = 0.1)
#' seq_range(x, by = 1, trim = 0.1)
#'
#' # Make pretty sequences
#' y <- runif(100)
#' seq_range(y, n = 10)
#' seq_range(y, n = 10, pretty = TRUE)
#' seq_range(y, n = 10, expand = 0.5, pretty = TRUE)
#'
#' seq_range(y, by = 0.1)
#' seq_range(y, by = 0.1, pretty = TRUE)
seq_range <- function(x, n, by, trim = NULL, expand = NULL, pretty = FALSE) {
  if (!missing(n) && !missing(by)) {
    stop("May only specify one of `n` and `by`", call. = FALSE)
  }

  if (!is.null(trim)) {
    rng <- stats::quantile(x, c(trim / 2, 1 - trim / 2), na.rm = TRUE)
  } else {
    rng <- range(x, na.rm = TRUE)
  }

  if (!is.null(expand)) {
    rng <- rng + c(-expand / 2, expand / 2) * (rng[2] - rng[1])
  }

  if (missing(by)) {
    if (pretty) {
      pretty(rng, n)
    } else {
      seq(rng[1], rng[2], length.out = n)
    }
  } else {
    if (pretty) {
      rng[1] <- floor(rng[1] / by) * by
      rng[2] <- ceiling(rng[2] / by) * by
    }
    seq(rng[1], rng[2], by = by)
  }

}
