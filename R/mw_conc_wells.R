#' Calculate concentrations (mixed) of selected wells at times as specified in table created with \code{\link{mw_conc_streamlines}}
#'
#' @param well_nrs Well numbers (numeric vector).
#' @inheritParams mw_read_well_filters
#' @inheritParams .mw_conc_fltr
#' @inheritParams .nearest_well_fltr
#' @return Dataframe with the following variables (columns):
#' * Q: Extraction (sum of all filters of well, m3/day; negative is extraction; positive is infiltration) (numeric)
#' * TIME: Time, days (numeric)
#' * CONC: Concentration (numeric)
#' @examples
#' fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
#' well_fltrs <- mw_read_well_filters(fname)
#' sl_fltr_table <- mw_example_sl_fltr_table()
#' conc_streamlines <- mw_example_conc_streamlines()
#' conc <- mw_conc_wells( well_nrs=c(1,9), well_fltrs, sl_fltr_table, conc_streamlines )
#' @export
mw_conc_wells <-
  function(well_nrs,
           well_fltrs,
           sl_fltr_table,
           conc_streamlines) {
    conc <-
      apply(
        well_nrs %>% as.array(),
        1,
        .mw_conc_well,
        well_fltrs,
        sl_fltr_table,
        conc_streamlines
      )
    conc %<>% na.omit.list() # Remove results when no concentrations are available
    if (length(conc) == 0) {
      return(NA)
    }
    conc %<>%
      data.table::rbindlist() %>%
      dplyr::group_by(TIME) %>%
      dplyr::summarise(CONC = weighted.mean(CONC, Q),
                       Q = sum(Q),
                       .groups =
                         "drop") %>%
      dplyr::relocate(Q)
    return(conc)
  }
