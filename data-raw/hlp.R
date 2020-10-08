# Read streamlines.`
fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
strm_lns <- mw_read_streamlines(fname)

# Read well filters.`
fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
well_fltrs <- mw_read_well_filters(fname)

# Read example initial concentrations of different layers in the subsoil (9 raster layers).
conc_l <- mw_example_concentrations()

# Read example concentration layer levels (8 rasters layers).
conc_l_lev <- mw_example_conc_layer_levels()

#Initialize base streamline concentration table.
conc_strm_lns <- mw_init(strm_lns, conc_l_lev, conc_l)

times <- c(0, 1 * 365, 5 * 365, 10 * 365, 25 * 365)
processes <- c("dispersion","decay", "retardation")
alpha <- 0.3
rho <- 3
labda <- 0.0001
retard=1

x <-
  .mw_conc_streamlines(
    conc_strm_lns=conc_strm_lns,
    times = c(0, 1 * 365, 5 * 365, 10 * 365, 25 * 365),
    processes = c("dispersion","decay", "retardation"),
    alpha = 0.3,
    rho = 3,
    labda = 0.0001,
    retard=1
  )



