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
