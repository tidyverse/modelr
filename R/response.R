response_var <- function(model) {
  UseMethod("response_var")
}

#' @export
response_var.default <- function(model, data) {
  stats::formula(model)[[2L]]
}

predictor_vars <- function(model) {
  UseMethod("predictor_vars")
}

#' @export
predictor_vars.default <- function(model, data) {
  all.vars(stats::formula(model)[[3L]])
}

response <- function(model, data) {
  eval(response_var(model), as.data.frame(data))
}
