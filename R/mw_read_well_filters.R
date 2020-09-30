#' Read wells from *.ipf file.
#'
#' @inheritParams mw_read_streamlines
#' @return dataframe with the following variables (columns):
#' * FLTR_NR: Filter number (integer)
#' * FLTR_ID: Filter ID (character)
#' * WL_NR: (unique) Well number (numeric)
#' * X: x-coordinate (numeric)
#' * Y: y-coordinate (numeric)
#' * BK_FLTR: Top filter relative to reference level (m) (numeric)
#' * OK_FLTR: Bottom filter relative to reference level (m) (numeric)
#' * Q_FLTR: Extraction (m3/day; negative is extraction; positive is infiltration) (numeric)
#' @details
#'   The same WL_NR is assigned to filters that have equal coordinates.
#' @examples
#' fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
#' well_fltrs <- mw_read_well_filters(fname)
#' @export
mw_read_well_filters <- function(fname) {
  x <-
    readLines(fname, n = 2) %>% as.numeric()
  nr_fltrs <- x[1] # Number of filters
  n <- x[2]
  x <- readLines(fname, n = n + 2)
  x <- x[3:length(x)]
  i <-
    c(
      which(x == "X"),
      which(x == "Y"),
      which(x == "ID"),
      which(x == "Q_ASSIGNED"),
      which(x == "BKFILT_NAP"),
      which(x == "OKFILT_NAP")
    )
  if (length(i) != 6) {
    stop("Not all information is included in ipf-file.")
  }
  x <-
    utils::read.csv(
      fname,
      header = FALSE,
      sep = ",",
      dec = ".",
      fill = FALSE,
      skip = n + 3,
      nrows=nr_fltrs
    )
  x <- x[, i]
  names(x) <- c("X", "Y", "FLTR_ID", "Q_FLTR", "BK_FLTR", "OK_FLTR")
  x$FLTR_NR <- 1:nrow(x)
  x %<>% dplyr::group_by(X,Y) %>% dplyr::mutate( WL_NR= dplyr::cur_group_id()) %>% dplyr::ungroup()
  return(x)
}

