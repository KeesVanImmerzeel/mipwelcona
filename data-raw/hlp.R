# Read streamlines.`
fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
strm_lns <- mw_read_streamlines(fname)

# Read well filters.`
fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
well_fltrs <- mw_read_well_filters(fname)

# Read Initial concentrations of different layers in the subsoil (9 raster layers).
conc_l <- mw_example_concentrations()

# Read concentration layer levels (8 rasters layers).
conc_l_lev <- mw_example_conc_layer_levels()

# Determine concentrations (conservative) at all locations (x,y,z) of streamline trajects.
conc_conserv <- .mw_conservative_conc(strm_lns, conc_l_lev, conc_l)



data <- strm_lns %>% dplyr::filter(SL_NR==1)

# On a streamline: calculate the distance to previous point.
.f <- function(data,...) {
  data %>% dplyr::mutate(DIST = sqrt( (dplyr::lag(X, default=X[1]) - X) ^ 2 +
                                      (dplyr::lag(Y, default=Y[1]) - Y) ^ 2 +
                                      (dplyr::lag(Z, default=Z[1]) - Z) ^ 2) )
}

test <- strm_lns %>% dplyr::group_by(SL_NR) %>% dplyr::group_modify(.f) %>% dplyr::mutate(DIST = cumsum(DIST)) %>% ungroup()


