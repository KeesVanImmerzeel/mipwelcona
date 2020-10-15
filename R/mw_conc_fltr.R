#' Calculate concentrations of filter at times as specified in table created with \code{\link{.mw_conc_streamlines}}
#'
#' @param fltr_nr (unique) Well number (numeric).
#' @param sl_fltr_table Dataframe as created with the function \code{\link{mw_create_sl_fltr_table}}.
#' @param conc_streamlines Table (tibble) as created with the function \code{\link{mw_init}}.
#' @return Dataframe with the following variables (columns):
#' * FLTR_NR: Streamline number (integer)
#' * TIME: Time, days (numeric)
#' * CONC: Concentration (numeric)
# @examples
# x <- .mw_conc_fltr( fltr_nr=1, sl_fltr_table=chk_sl_fltr_table, conc_streamlines=chk_mw_conc_streamlines)
# @export
.mw_conc_fltr <-
  function(fltr_nr,
           sl_fltr_table,
           conc_streamlines) {
    sl_nrs <-
      sl_fltr_table %>% dplyr::filter(FLTR_NR == fltr_nr) %>% dplyr::select(-c(FLTR_NR)) %>% dplyr::pull(1)
    if (length(sl_nrs) < 1) {
      return(NA)
    }
    conc_streamlines %<>% dplyr::filter(SL_NR %in% sl_nrs)
    df <-
      conc_streamlines %>% dplyr::group_by(TIME) %>% dplyr::summarize(CONC =
                                                                        mean(CONC), .groups = "drop")
    return(cbind(FLTR_NR = fltr_nr, df))
  }
