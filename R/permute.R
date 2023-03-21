#' Generate `n` permutation replicates.
#'
#' A permutation test involves permuting one or more variables in a data set
#' before performing the test, in order to break any existing relationships
#' and simulate the null hypothesis. One can then compare the true statistic
#' to the generated distribution of null statistics.
#'
#' @inheritParams resample_partition
#' @param n Number of permutations to generate.
#' @param ... Columns to permute. This supports bare column names or dplyr
#' [dplyr::select_helpers]
#' @param columns In `permute_`, vector of column names to permute.
#' @param .id Name of variable that gives each model a unique integer id.
#'
#' @return A data frame with `n` rows and one column: `perm`
#' @export
#' @examples
#'
#' library(purrr)
#' perms <- permute(mtcars, 100, mpg)
#'
#' models <- map(perms$perm, ~ lm(mpg ~ wt, data = .))
#' glanced <- map_df(models, broom::glance, .id = "id")
#'
#' # distribution of null permutation statistics
#' hist(glanced$statistic)
#' # confirm these are roughly uniform p-values
#' hist(glanced$p.value)
#'
#' # test against the unpermuted model to get a permutation p-value
#' mod <- lm(mpg ~ wt, mtcars)
#' mean(glanced$statistic > broom::glance(mod)$statistic)
#'
#' @export
permute <- function(data, n, ..., .id = ".id") {
  columns <- tidyselect::vars_select(colnames(data), ...)
  permute_(data, n, columns, .id = .id)
}

#' @rdname permute
#' @export
permute_ <- function(data, n, columns, .id = ".id") {
  perm <- purrr::map(seq_len(n), ~ resample_permutation(data, columns))

  df <- tibble::tibble(perm = perm)
  df[[.id]] <- id(n)
  df
}

#' Create a resampled permutation of a data frame
#'
#' @param data A data frame
#' @param columns Columns to be permuted
#' @param idx Indices to permute by. If not given, generates them randomly
#'
#' @return A permutation object; use as.data.frame to convert to a permuted
#' data frame
#'
#' @export
resample_permutation <- function(data, columns, idx = NULL) {
  if (is.null(idx)) {
    idx <- sample.int(nrow(data))
  }

  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }
  if (!is.character(columns) ||
    !(all(columns %in% colnames(data)))) {
    stop("`columns` must be a vector of column names in `data`", call. = FALSE)
  }
  if (!is.integer(idx) || length(idx) != nrow(data)) {
    stop("`idx` must be an integer vector with the same length as there are ",
      "rows in `data`",
      call. = FALSE
    )
  }

  structure(
    list(
      data = data,
      columns = columns,
      idx = idx
    ),
    class = "permutation"
  )
}

#' @export
print.permutation <- function(x, ...) {
  n <- length(x$idx)
  if (n > 10) {
    id10 <- c(x$idx[1:10], "...")
  } else {
    id10 <- x$idx
  }

  cat("<", obj_sum.permutation(x), "> ", paste(id10, collapse = ", "), "\n",
    sep = ""
  )
}

#' @export
as.integer.permutation <- function(x, ...) {
  x$idx
}

#' @export
as.data.frame.permutation <- function(x, ...) {
  ret <- x$data
  indices <- x$idx
  for (col in x$columns) {
    ret[[col]] <- ret[[col]][indices]
  }
  ret
}

#' @export
dim.permutation <- function(x, ...) {
  c(length(x$idx), ncol(x$data))
}

#' @importFrom tibble obj_sum
#' @method obj_sum resample
#' @export
obj_sum.permutation <- function(x, ...) {
  paste0(
    "permutation (", paste0(x$columns, collapse = ", "), ") [",
    big_mark(nrow(x)), " x ", big_mark(ncol(x)), "]"
  )
}
