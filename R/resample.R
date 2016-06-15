#' A "lazy" resample.
#'
#' Often you will resample a dataset hundreds or thousands of times. Storing
#' the complete resample each time would be very inefficient so this class
#' instead stores a "pointer" to the original dataset, and a vector of row
#' indexes. To turn this into a regular data frame, call \code{as.data.frame},
#' to extract the indices, use \code{as.integer}.
#'
#' @param data The data frame
#' @param idx A vector of integer indexes indicating which rows have
#'   been selected. These values should lie between 1 and \code{nrow(data)}
#'   but they are not checked by this function in the interests of performance.
#' @export
#' @examples
#' resample(mtcars, 1:10)
#'
#' b <- bootstrap(mtcars)
#' b
#' as.integer(b)
#' as.data.frame(b)
#'
#' # Many modelling functions will do the coercion for you, so you can
#' # use a resample object directly in the data argument
#' lm(mpg ~ wt, data = b)
resample <- function(data, idx) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }
  if (!is.integer(idx)) {
    stop("`idx` must be an integer vector.", call. = FALSE)
  }

  structure(
    list(
      data = data,
      idx = idx
    ),
    class = "resample"
  )
}

#' @export
print.resample <- function(x, ...) {
  n <- length(x$idx)
  if (n > 10) {
    id10 <- c(x$idx[1:10], "...")
  } else {
    id10 <- x$idx
  }

  cat(
    "<resample of ", big_mark(n), " rows> ", paste(id10, collapse = ", "), "\n",
    sep = ""
  )
}

#' @export
as.integer.resample <- function(x, ...) {
  x$idx
}

#' @export
as.data.frame.resample <- function(x, ...) {
  x$data[x$idx, , drop = FALSE]
}
