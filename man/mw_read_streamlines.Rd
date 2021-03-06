% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mw_read_streamlines.R
\name{mw_read_streamlines}
\alias{mw_read_streamlines}
\title{Read streamlines from *.iff file.}
\usage{
mw_read_streamlines(fname)
}
\arguments{
\item{fname}{Filename (character)}
}
\value{
tibble with the following variables (columns):
\itemize{
\item SL_NR: Streamline number (integer)
\item X: x-coordinate (numeric)
\item Y: y-coordinate (numeric)
\item Z: Z-coordinate (numeric)
\item TIME: Time, days (numeric)
\item DIST: Distance traveled since t=0 (meters) (numeric)
}
}
\description{
Read streamlines from *.iff file.
}
\details{
\itemize{
\item Resulting dataframe is grouped by streamline number (SL_NR)
}
}
\examples{
fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
strm_lns <- mw_read_streamlines(fname)
}
