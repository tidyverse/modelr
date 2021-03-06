% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/permute.R
\name{resample_permutation}
\alias{resample_permutation}
\title{Create a resampled permutation of a data frame}
\usage{
resample_permutation(data, columns, idx = NULL)
}
\arguments{
\item{data}{A data frame}

\item{columns}{Columns to be permuted}

\item{idx}{Indices to permute by. If not given, generates them randomly}
}
\value{
A permutation object; use as.data.frame to convert to a permuted
data frame
}
\description{
Create a resampled permutation of a data frame
}
