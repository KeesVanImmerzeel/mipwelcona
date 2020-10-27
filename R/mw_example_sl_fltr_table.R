#' Create example Create table with indices linking the streamlines to well filters (as created with function mw_create_sl_fltr_table()).
#'
#' @return dataframe with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * FLTR_NR: Filter number (integer)
#' @examples
#' x <- mw_example_sl_fltr_table()
#' head(x)
#' @export
mw_example_sl_fltr_table <- function() {
  x <- chk_sl_fltr_table
  # Modify in order to be able to illustrate the working of functions depending of this table.
  x[98,]$FLTR_NR <- 2
  x[99,]$FLTR_NR <- 2
  x[100,]$FLTR_NR <- 2
  return(x)
}


