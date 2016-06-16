response <- function(model, data) {
  UseMethod("response")
}

#' @export
response.default <- function(model, data) {
  var <- formula(model)[[2L]]
  eval(var, data)
}
