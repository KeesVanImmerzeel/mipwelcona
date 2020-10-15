#' Determine the concentration layer numbers.
#'
#' @inheritParams mw_create_sl_fltr_table
#' @param conc_l_lev Levels of concentration layers (RasterBrick).
#' @return Numbers of the concentration layer corresponding to all locations (x,y,z) of
#'   streamline trajects (integer vector).
# @examples
#' x <- .mw_get_conc_layer_nr(strm_lns=chk_mw_read_streamlines, conc_l_lev=mw_example_conc_layer_levels())
# @export
.mw_get_conc_layer_nr <- function(strm_lns, conc_l_lev) {
  .f <- function(x) {
    n <- length(x) - 1
    stats::approx(
      x[1:n],
      y = 1:n,
      xout = x[n + 1],
      method = "constant",
      rule = c(2:2)
    )$y
  }

  x <-
    raster::extract(conc_l_lev, cbind(strm_lns$X, strm_lns$Y)) %>% as.data.frame()
  x$Z <- strm_lns$Z
  x %>% as.matrix() %>% apply(1, .f)
}



