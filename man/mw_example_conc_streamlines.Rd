% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mw_example_conc_streamlines.R
\name{mw_example_conc_streamlines}
\alias{mw_example_conc_streamlines}
\title{Create example concentrations on streamlines at specified times (created with function mw_conc_streamlines()).}
\usage{
mw_example_conc_streamlines()
}
\value{
tibble with the following variables (columns):
\itemize{
\item SL_NR: Streamline number (integer)
\item TIME: Time, days (numeric)
\item CONC: Concentration (numeric)
}
}
\description{
Create example concentrations on streamlines at specified times (created with function mw_conc_streamlines()).
}
\examples{
x <- mw_example_conc_streamlines()
head(x)
}
