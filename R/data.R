#' Height and income data.
#'
#' You might have heard that taller people earn more. Is it true? You can
#' try and answer the question by exploring this dataset extracted from the
#' \href{https://www.nlsinfo.org}{National Longitudinal Study}, which is
#' sponsored by the U.S. Bureau of Labor Statistics.
#'
#' This contains data as at 2012.
#' @format
#' \describe{
#'  \item{income}{Yearly income. The top two percent of values were averaged
#'    and that average was used to replace all values in the top range. }
#'  \item{height}{Height, in feet}
#'  \item{weight}{Weight, in pounds}
#'  \item{age}{Age, in years, between 47 and 56.}
#'  \item{marital}{Marital status}
#'  \item{sex}{Sex}
#'  \item{education}{Years of education}
#'  \item{afqt}{Percentile score on Armed Forces Qualification Test.}
#' }
"heights"


#' Simple simulated datasets
#'
#' These simple simulated datasets are useful for teaching modelling
#' basics.
#'
#' @name sim
NULL

#' @rdname sim
"sim1"

#' @rdname sim
"sim2"

#' @rdname sim
"sim3"

#' @rdname sim
"sim4"
