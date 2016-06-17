#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' @importFrom purrr map reduce compact %||%
NULL

reduce_common <- function(x, msg = "Objects must be identical",
                          operator = identical) {
  reduce(x, function(.x, .y) {
    if (!operator(.x, .y)) {
      stop(msg, call. = FALSE)
    }
    .y
  })
}


has_name <- function(x) {
  nms <- names(x)
  if (is.null(nms)) {
    rep(FALSE, length(x))
  } else {
    !(is.na(nms) | nms == "")
  }
}

big_mark <- function(x, ...) {
  mark <- if (identical(getOption("OutDec"), ",")) "." else ","
  formatC(x, big.mark = mark, ...)
}

id <- function(n) {
  width <- nchar(n)
  sprintf(paste0("%0", width, "d"), seq_len(n))
}
