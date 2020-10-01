#' Determine the concentration layer numbers.
#'
#' @inheritParams mw_create_sl_fltr_table
#' @param conc_l_lev Levels of concentration layers (RasterBrick)
#' @return Numbers of the concentration layer (integer vector)
# @examples
#' fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
#' strm_lns <- mw_read_streamlines(fname)
#' conc_l_lev <- mw_example_conc_layer_levels()
#' x <- .mw_get_conc_layer_nr(strm_lns, conc_l_lev)
#' @export
.mw_get_conc_layer_nr <- function(strm_lns, conc_l_lev) {
  #x conc_l_level and z-level (1 record)
  .f <- function(x) {
    n <- length(x)
    i <- which(x[1:(n-1)]<x[n])
    if (length(i)>0) {
      return(min(i))
    } else {
      return(n)
    }
  }
  x <- raster::extract(conc_l_lev,cbind(strm_lns$X,strm_lns$Y)) %>% as.data.frame()
  x$Z <- strm_lns$Z
  x %<>% as.matrix()
  apply(x,1,.f)
}

