#' Calculate the distance between two points.
#'
#' @param x Coordinates of points (x1,y1,x2,y2) (numeric)
#' @return distance (numeric)
# @examples
#' x <- c(271877.5, 554247.5, 271910, 554210)
#' .dist(x)
# @export
.dist <- function(x) {
  sqrt((x[1]-x[3])^2 + (x[2]-x[4])^2)
}

#' Find the nearest well filter of a particle on a streamline.
#'
#' @param particle Location of particle (x,y,z) (numeric vector)
#' @param well_fltrs Data frame with wells as read from *.ipf file by the function mw_read_well_filters()
#' @param maxdist The maximum distance the particle can be from a well filter if it is to be a selection candidate.
#' @seealso [mw_read_well_filters()]
#' @return nearest well filter number (numeric)
# @examples
#' particle <- c(X=271877.5, Y=554247.5, Z=-41.237)
#' fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
#' well_fltrs <- mw_read_well_filters(fname)
#' .nearest_well_fltr(particle, well_fltrs, maxdist = 100)
# @export
.nearest_well_fltr <- function(particle, well_fltrs, maxdist = 100) {
  FLTR_NR <- NA

  # Calculate distance of particle to all wells.
  X <-
    data.frame(particle[1],
               particle[2],
               well_fltrs$X,
               well_fltrs$Y,
               FLTR_NR = well_fltrs$FLTR_NR, row.names = NULL) %>% as.matrix()
  well_fltrs$distance <- apply(X, 1, .dist)

  # Only consider well filters:
  #   - matching (approximately) the vertical (Z) level of the particle;
  #   - at a distance < mindist
  # Select from these filters the filters with the smallest distance to the particle
  well_fltrs %<>% dplyr::mutate(fltr_length=BK_FLTR-OK_FLTR)
  well_fltrs %<>% dplyr::filter(BK_FLTR+0.5*fltr_length >= particle[3] &
                                OK_FLTR-0.5*fltr_length <= particle[3] &
                                distance <= maxdist) %>% dplyr::slice(which.min(distance))
  n <- nrow(well_fltrs)
  if (n >= 1) {
    # There are well filters with top/bottoms matching the vertical (Z) level of the particle.
    FLTR_NR <- well_fltrs[1, ]$FLTR_NR
  }
  return(FLTR_NR)
}

#' Create table with indices linking the streamlines to well filters.
#'
#' @param strm_lns Streamlines as read from function mw_read_streamlines()
#' @param well_fltrs Well filters as read from function mw_read_well_filters()
#' @return dataframe with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * FLTR_NR: Filter number (integer)
#' @examples
#' fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
#' strm_lns <- mw_read_streamlines(fname)
#' fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
#' well_fltrs <- mw_read_well_filters(fname)
#' sl_fltr_table <- mw_create_sl_fltr_table(strm_lns, well_fltrs)
#' @export
mw_create_sl_fltr_table <- function(strm_lns, well_fltrs){
  X <- strm_lns %>% dplyr::filter(TIME==0) %>% as.matrix()
  fltr_nrs <- apply(X,1,.nearest_well_fltr,well_fltrs, maxdist = 1000)
  df <- data.frame(SL_NR=X[,"SL_NR"], FLTR_NR=fltr_nrs)
  return(df)
}
