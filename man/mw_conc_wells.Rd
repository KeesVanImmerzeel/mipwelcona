% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mw_conc_wells.R
\name{mw_conc_wells}
\alias{mw_conc_wells}
\title{Calculate concentrations (mixed) of selected wells at times as specified in table created with \code{\link{mw_conc_streamlines}}}
\usage{
mw_conc_wells(well_nrs, well_fltrs, sl_fltr_table, conc_streamlines)
}
\arguments{
\item{well_nrs}{Well numbers (numeric vector).}

\item{well_fltrs}{Data frame with wells as read from *.ipf file by the function mw_read_well_filters()}

\item{sl_fltr_table}{Dataframe as created with the function \code{\link{mw_create_sl_fltr_table}}.}

\item{conc_streamlines}{Table (tibble) as created with the function \code{\link{mw_conc_init}}.}
}
\value{
Dataframe with the following variables (columns):
\itemize{
\item Q: Extraction (sum of all filters of well, m3/day; negative is extraction; positive is infiltration) (numeric)
\item TIME: Time, days (numeric)
\item CONC: Concentration (numeric)
}
}
\description{
Calculate concentrations (mixed) of selected wells at times as specified in table created with \code{\link{mw_conc_streamlines}}
}
\examples{
fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
well_fltrs <- mw_read_well_filters(fname)
sl_fltr_table <- mw_example_sl_fltr_table()
conc_streamlines <- mw_example_conc_streamlines()
conc <- mw_conc_wells( well_nrs=c(1,9), well_fltrs, sl_fltr_table, conc_streamlines )
}
