#' Initialise example initial concentrations layers in the subsoil.
#'
#' @return rasterbrick with 9 concentration rasters.
#' @examples
#' x <- mw_example_concentrations()
#' names(x)
#' @export
mw_example_concentrations <- function() {
  fname <-
    system.file("extdata", "concentrations.tif", package = "mipwelcona")
  x <- suppressWarnings(raster::raster(fname))
  return(raster::brick(x, x / 2, x / 4, x / 8, x / 16, x / 32, x / 64, x /
                         128, x / 256))
}

