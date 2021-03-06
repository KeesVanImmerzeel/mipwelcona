% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mw_read_well_filters.R
\name{mw_read_well_filters}
\alias{mw_read_well_filters}
\title{Read wells from *.ipf file.}
\usage{
mw_read_well_filters(fname)
}
\arguments{
\item{fname}{Filename (character)}
}
\value{
dataframe with the following variables (columns):
\itemize{
\item FLTR_NR: Filter number (integer)
\item FLTR_ID: Filter ID (character)
\item WL_NR: (unique) Well number (numeric)
\item X: x-coordinate (numeric)
\item Y: y-coordinate (numeric)
\item BK_FLTR: Top filter relative to reference level (m) (numeric)
\item OK_FLTR: Bottom filter relative to reference level (m) (numeric)
\item Q_FLTR: Extraction (m3/day; negative is extraction; positive is infiltration) (numeric)
}
}
\description{
Read wells from *.ipf file.
}
\details{
The same WL_NR is assigned to filters that have equal coordinates.
}
\examples{
fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
well_fltrs <- mw_read_well_filters(fname)
}
