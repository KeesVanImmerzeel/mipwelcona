# Helper function to remove NA's from a list
na.omit.list <- function(y) { return(y[!sapply(y, function(x) all(is.na(x)))]) }

#' Calculate concentrations (mixed) of selected filters at times as specified in table created with \code{\link{.mw_conc_streamlines}}
#'
#' @param fltr_nrs (unique) Well numbers (numeric vector).
#' @inheritParams .mw_conc_fltr
#' @inheritParams .nearest_well_fltr
#' @return Dataframe with the following variables (columns):
#' * Q: Extraction (m3/day; negative is extraction; positive is infiltration) (numeric)
#' * TIME: Time, days (numeric)
#' * CONC: Concentration (numeric)
# Example with fake data
# @examples
# sl_fltr_table <- chk_sl_fltr_table
# sl_fltr_table[98,]$FLTR_NR <- 2
# sl_fltr_table[99,]$FLTR_NR <- 2
# sl_fltr_table[100,]$FLTR_NR <- 2
# x <- mw_conc_filters( fltr_nrs=c(1,2), well_fltrs=chk_mw_read_well_filters, sl_fltr_table=chk_sl_fltr_table,
#                     conc_streamlines=chk_mw_conc_streamlines )
#' @export
mw_conc_filters <-
  function(fltr_nrs,
           well_fltrs,
           sl_fltr_table,
           conc_streamlines) {
    well_fltrs %<>%  dplyr::filter(FLTR_NR %in% fltr_nrs) %>% dplyr::select(c(FLTR_NR, Q_FLTR))
    if (nrow(well_fltrs) < 1) {
      return(NA)
    }
    conc <-
      apply(fltr_nrs %>% as.array(),
            1,
            .mw_conc_fltr,
            sl_fltr_table,
            conc_streamlines)
    conc %<>% na.omit.list() # Remove results when no concentrations are available
    if (length(conc) == 0) {
      return(NA)
    }
    conc %<>%
      data.table::rbindlist() %>%
      dplyr::left_join(well_fltrs, by = "FLTR_NR") %>%
      dplyr::group_by(TIME) %>%
      dplyr::summarise(CONC = weighted.mean(CONC, Q_FLTR), .groups =
                         "drop") %>%
      dplyr::mutate(Q = sum(well_fltrs$Q_FLTR)) %>%
      dplyr::relocate(Q)
    return(conc)
  }
