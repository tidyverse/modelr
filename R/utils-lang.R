
find_symbols <- function(lang) {
  if (is.call(lang)) {
    find_symbols_call(lang)
  } else if (is.symbol(lang)) {
    as.character(lang)
  } else {
    character(0)
  }
}

find_symbols_call <- function(lang) {
  fun_name <- as.character(lang[[1]])

  if (fun_name %in% c("$", "@")) {
    as.character(lang[[2]])
  } else if (fun_name %in% c("::", ":::")) {
    character(0)
  } else {
    res <- map(as.list(lang[-1]), find_symbols)
    purrr::flatten_chr(res)
  }
}

f_zap_lhs <- function(f) {
  lazyeval::f_new(lazyeval::f_rhs(f), env = lazyeval::f_env(f))
}

is_formula <- function(f) {
  inherits(f, "formula")
}
