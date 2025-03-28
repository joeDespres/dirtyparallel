% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extendr-wrappers.R
\name{rustylapply}
\alias{rustylapply}
\title{dirtylapply replicates R's lapply: it takes an R list and an R function,
applies the function to each element, and returns a new list of results.}
\usage{
rustylapply(list, func, varargs)
}
\arguments{
\item{list}{A list of elements to process}

\item{func}{An R function to apply}

\item{varargs}{Additional arguments passed to the function}
}
\value{
A list of results from applying \code{func} to each element of \code{list}
}
\description{
dirtylapply replicates R's lapply: it takes an R list and an R function,
applies the function to each element, and returns a new list of results.
}
