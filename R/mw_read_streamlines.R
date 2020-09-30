#' Read streamlines from *.iff file.
#'
#' @param fname Filename (character)
#' @return dataframe with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * LAY: Layer number (integer)
#' * X: x-coordinate (numeric)
#' * Y: y-coordinate (numeric)
#' * Z: Z-coordinate (numeric)
#' * TIME: Time, years (numeric)
#' @examples
#' fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
#' strm_lns <- mw_read_streamlines(fname)
#' @export
mw_read_streamlines <- function(fname) {
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
  x %<>% dplyr::select("X", "Y", "Z", "TIME", "LAY", "SL_NR")
  return(x)
}
