response_var <- function(model) {
  UseMethod("response_var")
}

#' @export
response_var.default <- function(model, data) {
  stats::formula(model)[[2L]]
}

response <- function(model, data) {
  eval(response_var(model), as.data.frame(data))
}

