#' Create example base streamline concentration table (created with function mw_conc_init()).
#'
#' @return table (tibble) with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * TIME: Time, days (numeric)
#' * DIST: Distance traveled since t=0 (meters) (numeric)
#' * CCONC: Concentration (conservative) (numeric)
#' * D_CCONC: Change in concentration (numeric)
#' @examples
#' x <- mw_example_base_streamline_conc_table()
#' head(x)
#' @export
mw_example_base_streamline_conc_table <- function() {
  return(chk_mw_conc_init)
}

