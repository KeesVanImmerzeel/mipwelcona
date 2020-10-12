#' Concentrations (conservative) at all locations (x,y,z) of streamline trajects.
#'
#' @inheritParams .mw_get_conc_layer_nr
#' @param conc_l Concentration layers (RasterBrick).
#' @return Concentration (conservative) at all locations (x,y,z) of
#'   streamline trajects (integer vector).
# @examples
#' x <- .mw_conservative_conc(chk_mw_read_streamlines, mw_example_conc_layer_levels(), mw_example_concentrations())
# @export
.mw_conservative_conc <- function(strm_lns, conc_l_lev, conc_l) {
  #x: (concentrations in layers, i); i=concentration layer number
  .f <- function(x) {
    n <- length(x)
    return(x[x[n]])
  }
  x <- raster::extract(conc_l,cbind(strm_lns$X,strm_lns$Y)) %>% as.data.frame()
  x$i <- .mw_get_conc_layer_nr(strm_lns, conc_l_lev)
  apply(x,1,.f)
}

