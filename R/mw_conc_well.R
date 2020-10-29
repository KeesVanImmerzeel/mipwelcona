#' Calculate concentrations of well at times as specified in table created with \code{\link{mw_conc_streamlines}}
#'
#' @param well_nr (unique) Well number (numeric)
#' @inheritParams mw_read_well_filters
#' @inheritParams .mw_conc_fltr
#' @inheritParams .nearest_well_fltr
#' @return Dataframe with the following variables (columns):
#' * Q_WL: Extraction (m3/day; negative is extraction; positive is infiltration) (numeric)
#' * TIME: Time, days (numeric)
#' * CONC: Concentration (numeric)
# @examples
# fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
# well_fltrs <- mw_read_well_filters(fname)
# sl_fltr_table <- mw_example_sl_fltr_table()
# conc_streamlines <- mw_example_conc_streamlines()
# conc <- .mw_conc_well( well_nr=1, well_fltrs, sl_fltr_table, conc_streamlines )
# @export
.mw_conc_well <-
  function(well_nr,
           well_fltrs,
           sl_fltr_table,
           conc_streamlines) {
    fltr_nrs <-
      well_fltrs %>% dplyr::filter(WL_NR == well_nr) %>% dplyr::pull(FLTR_NR)
    if (length(fltr_nrs) < 1) {
      return(NA)
    }
    return(
      mw_conc_filters(
        fltr_nrs,
        well_fltrs,
        sl_fltr_table,
        conc_streamlines
      )
    )
  }
