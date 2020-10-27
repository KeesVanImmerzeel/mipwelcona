#' Create example concentrations on streamlines at specified times (created with function mw_conc_streamlines()).
#'
#' @return tibble with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * TIME: Time, days (numeric)
#' * CONC: Concentration (numeric)
#'
#' @examples
#' x <- mw_example_conc_streamlines()
#' head(x)
#' @export
mw_example_conc_streamlines <- function() {
  return(chk_mw_conc_streamlines)
}
