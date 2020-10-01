#' Initialise example concentration layer levels.
#'
#' @return rasterbrick with 8 rasters with concentration layer levels.
#' @examples
#' x <- mw_example_conc_layer_levels()
#' names(x)
#' @export
mw_example_conc_layer_levels <- function() {
  fname <-
    system.file("extdata", "concentrations.tif", package = "mipwelcona")
  x1 <- raster::raster(fname)
  x1[] <- 0;
  names(x1) <- c("level")
  x2 <- x1; x2[] <- -10
  x3 <- x1; x3[] <- -20
  x4 <- x1; x4[] <- -30
  x5 <- x1; x5[] <- -40
  x6 <- x1; x6[] <- -50
  x7 <- x1; x7[] <- -60
  x8 <- x1; x8[] <- -70
  return(raster::brick(x1,x2,x3,x4,x5,x6,x7,x8))
}

