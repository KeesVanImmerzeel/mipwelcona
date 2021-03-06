% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mw_conc_fltr.R
\name{.mw_conc_fltr}
\alias{.mw_conc_fltr}
\title{Calculate concentrations of filter at times as specified in table created with \code{\link{mw_conc_streamlines}}}
\usage{
.mw_conc_fltr(fltr_nr, sl_fltr_table, conc_streamlines)
}
\arguments{
\item{fltr_nr}{(unique) Well number (numeric).}

\item{sl_fltr_table}{Dataframe as created with the function \code{\link{mw_create_sl_fltr_table}}.}

\item{conc_streamlines}{Table (tibble) as created with the function \code{\link{mw_conc_init}}.}
}
\value{
Dataframe with the following variables (columns):
\itemize{
\item FLTR_NR: Streamline number (integer)
\item TIME: Time, days (numeric)
\item CONC: Concentration (numeric)
}
}
\description{
Calculate concentrations of filter at times as specified in table created with \code{\link{mw_conc_streamlines}}
}
