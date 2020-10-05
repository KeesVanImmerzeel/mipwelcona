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


x <- mw_init(strm_lns, conc_l_lev, conc_l)
