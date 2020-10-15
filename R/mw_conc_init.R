#' Initialize base streamline concentration table.
#'
#' @inheritParams .mw_conservative_conc
#' @return table (tibble) with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * TIME: Time, days (numeric)
#' * DIST: Distance traveled since t=0 (meters) (numeric)
#' * CCONC: Concentration (conservative) (numeric)
#' * D_CCONC: Change in concentration (numeric)
#' @details
#' Add concentrations (conservative) at all locations (x,y,z) of streamline trajects and
#' remove redundant records (no concentration change).
#' @examples
#' fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
#' strm_lns <- mw_read_streamlines(fname)
#' x <- mw_conc_init(strm_lns, conc_l_lev=mw_example_conc_layer_levels(),
#'      conc_l=mw_example_concentrations())
#' @export
mw_conc_init <- function(strm_lns, conc_l_lev, conc_l) {
  # Per streamline (data): change in (conservative) concentration;
  # Remove lines with 0 concentration change.
  .f <- function(data,...) {
    data %>% dplyr::mutate(D_CCONC = CCONC - dplyr::lag(CCONC) ) %>%
      dplyr::filter(D_CCONC > 0 | is.na(D_CCONC) )
  }
  strm_lns$CCONC <- .mw_conservative_conc(strm_lns, conc_l_lev, conc_l)
  strm_lns %<>% dplyr::group_modify(.f) %>% dplyr::select(-c(X,Y,Z))
  return(strm_lns)
}
