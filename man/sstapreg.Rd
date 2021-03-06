% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sstapreg.R
\name{sstapreg}
\alias{sstapreg}
\title{Create a sstapreg object}
\usage{
sstapreg(object)
}
\arguments{
\item{object}{A list provided by one of the \code{sstap_*} modeling functions.}
}
\value{
A sstapreg object
}
\description{
The returned model object from the \pkg{rsstap} functions - methods can be 
called on this to identify STAP effects and any problems with model convergence 
or other diagnostics.
}
