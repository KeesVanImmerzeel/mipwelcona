#' Calculate concentrations of well at times as specified in table created with \code{\link{.mw_conc_streamlines}}
#'
#' @param well_nr (unique) Well number (numeric)
#' @inheritParams mw_read_well_filters
#' @inheritParams .mw_conc_fltr
#' @inheritParams .nearest_well_fltr
#' @return Dataframe with the following variables (columns):
#' * WL_NR: (unique) Well number (numeric)
#' * TIME: Time, days (numeric)
#' * CONC: Concentration (numeric)
# @examples
# x <- .mw_conc_well( well_nr=1, chk_mw_read_well_filters, chk_sl_fltr_table,
#                     chk_mw_conc_streamlines )
# @export
.mw_conc_well <-
  function(well_nr,
           well_fltrs,
           sl_fltr_table,
           conc_streamlines) {
    well_fltrs <- well_fltrs %>% dplyr::filter(WL_NR == well_nr)
    if (nrow(well_fltrs) < 1) {
      return(NA)
    }
    conc <-
      purrrlyr::by_row(well_fltrs,
                       ..f = .mw_conc_fltr,
                       sl_fltr_table ,
                       conc_streamlines ,
                       .collate = "rows") %>% dplyr::select(FLTR_NR, Q_FLTR, TIME, CONC) %>%
      dplyr::group_by(TIME) %>%
      dplyr::summarise(WCONC = weighted.mean(CONC, Q_FLTR)) %>% dplyr::mutate(WL_NR=well_nr) %>% dplyr::relocate(WL_NR)

    return(conc)
  }
