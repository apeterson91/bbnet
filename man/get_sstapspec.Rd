% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sstapspec.R
\name{get_sstapspec}
\alias{get_sstapspec}
\title{Retrieve STAP model specification from STAP model formula}
\usage{
get_sstapspec(f, benvo)
}
\arguments{
\item{f}{formula from \code{\link{sstap_glm}}, \code{\link{sstap_glmer}}}

\item{benvo}{Built Environment object - \code{\link[rbenvo]{benvo}} - containing data for model}
}
\value{
\code{\link{sstapspec}} object
}
\description{
Get sstapspec object which details the various components of the sstap model specification
}
