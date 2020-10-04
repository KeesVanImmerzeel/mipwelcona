#' Read streamlines from *.iff file.
#'
#' @param fname Filename (character)
#' @return tibble with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * LAY: Layer number (integer)
#' * X: x-coordinate (numeric)
#' * Y: y-coordinate (numeric)
#' * Z: Z-coordinate (numeric)
#' * TIME: Time, days (numeric)
#' * DIST: Distance traveled since t=0 (meters) (numeric)
#' @details
#' * Resulting dataframe is grouped by streamline number (SL_NR)
#' @examples
#' fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
#' strm_lns <- mw_read_streamlines(fname)
#' @export
mw_read_streamlines <- function(fname) {
  # On a streamline : calculate the distance to previous point.
  .f <- function(data,...) {
    data %>% dplyr::mutate(DIST = sqrt( (dplyr::lag(X, default=X[1]) - X) ^ 2 +
                                          (dplyr::lag(Y, default=Y[1]) - Y) ^ 2 +
                                          (dplyr::lag(Z, default=Z[1]) - Z) ^ 2) )
  }
  n <-
    readLines(fname, n = 1) %>% as.numeric()
  x <- readLines(fname, n = n + 1)
  x <- x[2:length(x)]
  i <-
    c(
      which(x == "PARTICLE_NUMBER"),
      which(x == "ILAY"),
      which(x == "XCRD."),
      which(x == "YCRD."),
      which(x == "ZCRD."),
      which(x == "TIME(YEARS)")
    )
  if (length(i) != 6) {
    stop("Not all information is included in iff-file.")
  }
  x <-
    utils::read.csv(
      fname,
      header = FALSE,
      sep = "",
      dec = ".",
      fill = FALSE,
      skip = n + 1
    )
  x <- x[, i]
  names(x) <- c("SL_NR", "LAY", "X", "Y", "Z", "TIME")
  # Double records are filtered out; group by streamline (SL_NR); add
  x %<>% dplyr::select("X", "Y", "Z", "TIME", "LAY", "SL_NR") %>%
    dplyr::distinct(X, Y, Z, TIME, .keep_all = TRUE) %>% dplyr::group_by(SL_NR) %>%
    dplyr::group_modify(.f) %>% dplyr::mutate(DIST = cumsum(DIST))

  return(x)
}
