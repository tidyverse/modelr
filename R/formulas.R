#' Fit a list of formulas
#'
#' `fit_with()` is a pipe-friendly tool that applies a list of
#' formulas to a fitting function such as [stats::lm()].
#' The list of formulas is typically created with [formulas()].
#'
#' Assumes that `.f` takes the formula either as first argument
#' or as second argument if the first argument is `data`.  Most
#' fitting functions should fit these requirements.
#' @param data A dataset used to fit the models.
#' @param .f A fitting function such as [stats::lm()],
#'   [lme4::lmer()] or [rstanarm::stan_glmer()].
#' @param .formulas A list of formulas specifying a model.
#' @param ... Additional arguments passed on to `.f`
#' @seealso [formulas()]
#' @export
#' @examples
#' # fit_with() is typically used with formulas().
#' disp_fits <- mtcars %>% fit_with(lm, formulas(~disp,
#'   additive = ~drat + cyl,
#'   interaction = ~drat * cyl,
#'   full = add_predictors(interaction, ~am, ~vs)
#' ))
#'
#' # The list of fitted models is named after the names of the list of
#' # formulas:
#' disp_fits$full
#'
#' # Additional arguments are passed on to .f
#' mtcars %>% fit_with(glm, list(am ~ disp), family = binomial)
fit_with <- function(data, .f, .formulas, ...) {
  args <- list(...)

  # Supply .f quoted, otherwise the whole fitting function is inlined
  # in the call recorded in the fit objects
  map(.formulas, function(formula) {
    inject(.f(!!formula, data = data, !!!args))
  })
}

#' Create a list of formulas
#'
#' `formulas()` creates a list of two-sided formulas by merging a
#' unique left-hand side to a list of right-hand sides.
#' @param .response A one-sided formula used as the left-hand side of
#'   all resulting formulas.
#' @param ... List of formulas whose right-hand sides will be merged
#'   to `.response`.
#' @export
#' @examples
#' # Provide named arguments to create a named list of formulas:
#' models <- formulas(~lhs,
#'   additive = ~var1 + var2,
#'   interaction = ~var1 * var2
#' )
#' models$additive
#'
#' # The formulas are created sequentially, so that you can refer to
#' # previously created formulas:
#' formulas(~lhs,
#'   linear = ~var1 + var2,
#'   hierarchical = add_predictors(linear, ~(1 | group))
#' )
formulas <- function(.response, ...) {
  formulas <- tibble::lst(...)
  validate_formulas(.response, formulas)
  map(formulas, set_lhs, .response)
}

#' @rdname formulas
#' @export
formulae <- formulas

validate_formulas <- function(response, formulas) {
  if (!is_formula(response) || length(response) != 2) {
    stop(".response must be a one-sided formula", call. = FALSE)
  }

  if (!length(formulas)) {
    stop("No formula provided", call. = FALSE)
  }
  purrr::walk(formulas, function(f) {
    if (!is_formula(f)) {
      stop("'...' must contain only formulas", call. = FALSE)
    }
  })
}

set_lhs <- function(f, lhs) {
  env <- merge_envs(lhs, f)
  new_formula(f_rhs(lhs), f_rhs(f), env)
}

#' Add predictors to a formula
#'
#' This merges a one- or two-sided formula `f` with the
#' right-hand sides of all formulas supplied in `...`.
#' @param f A formula.
#' @param ... Formulas whose right-hand sides will be merged to
#'   `f`.
#' @param fun A function name indicating how to merge the right-hand
#'   sides.
#' @export
#' @examples
#' f <- lhs ~ rhs
#' add_predictors(f, ~var1, ~var2)
#'
#' # Left-hand sides are ignored:
#' add_predictors(f, lhs1 ~ var1, lhs2 ~ var2)
#'
#' # fun can also be set to a function like "*":
#' add_predictors(f, ~var1, ~var2, fun = "*")
add_predictors <- function(f, ..., fun = "+") {
  rhss <- map(list(f, ...), f_zap_lhs)
  rhs <- reduce(rhss, merge_formulas, fun = fun)
  env <- merge_envs(f, rhs)

  new_formula(f_lhs(f), f_rhs(rhs), env)
}

merge_formulas <- function(f1, f2, fun = "+") {
  rhs <- call(fun, f_rhs(f1), f_rhs(f2))

  lhss <- compact(map(list(f1, f2), f_lhs))
  if (length(lhss) == 0) {
    lhs <- NULL
  } else {
    lhs <- reduce_common(lhss, "Left-hand sides must be identical")
  }

  env <- merge_envs(f1, f2)
  new_formula(lhs, rhs, env)
}

merge_envs <- function(f1, f2) {
  symbols_f1 <- find_symbols(f1)
  symbols_f2 <- find_symbols(f2)

  conflicts <- intersect(symbols_f1, symbols_f2)
  conflicts_envs <- compact(map(conflicts, find_env_conflicts, f1, f2))

  all_symbols <- union(symbols_f1, symbols_f2)
  nonconflicts <- setdiff(all_symbols, conflicts)
  nonconflicts_envs <- compact(map(nonconflicts, find_env_nonconflicts, f1, f2))

  all_envs <- c(conflicts_envs, nonconflicts_envs)

  if (length(all_envs) == 0) {
    environment(f1)
  } else {
    reduce_common(
      all_envs,
      "Cannot merge formulas as their scopes conflict across symbols"
    )
  }
}

find_env_conflicts <- function(symbol, f1, f2) {
  env1 <- find_binding_env(symbol, environment(f1))
  env2 <- find_binding_env(symbol, environment(f2))

  if (is.null(env1) || is.null(env2)) {
    return(env1 %||% env2)
  }

  if (!identical(env1, env2)) {
    stop("Cannot merge formulas as their scopes conflict for the symbol '",
      symbol, "'",
      call. = FALSE
    )
  }

  env1
}

find_env_nonconflicts <- function(symbol, f1, f2) {
  env1 <- find_binding_env(symbol, environment(f1))
  env2 <- find_binding_env(symbol, environment(f2))
  env1 %||% env2
}

find_binding_env <- function(symbol, env) {
  if (exists(symbol, envir = env)) {
    env
  } else if (!identical(env, emptyenv())) {
    find_binding_env(symbol, parent.env(env))
  } else {
    NULL
  }
}
