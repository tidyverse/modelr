#' Add a reference line (ggplot2).
#'
#' @param h,v Position of horizontal or vertical reference line
#' @param size Line size
#' @param colour Line colour
#' @export
geom_ref_line <- function(h, v, size = 2, colour = "white") {
  if (!missing(h)) {
    ggplot2::geom_hline(yintercept = h, size = size, colour = colour)
  } else if (!missing(v)) {
    ggplot2::geom_vline(xintercept = v, size = size, colour = colour)
  } else {
    stop("Must supply one of `h` and `v`.", call. = FALSE)
  }
}
