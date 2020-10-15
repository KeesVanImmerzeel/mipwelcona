## code to prepare `DATASET` dataset goes here

## Re-create check objects.
## ONLY RE-CREATE CHECK OBJECT IF THE EXISTING OBJECT IS NOT CORECT (ANYMORE).
fname <-
  system.file("extdata", "streamlines.iff", package = "mipwelcona")
chk_mw_read_streamlines <- mw_read_streamlines(fname)

fname <-
  system.file("extdata", "well_filters.ipf", package = "mipwelcona")
chk_mw_read_well_filters <- mw_read_well_filters(fname)

chk_sl_fltr_table <- mw_create_sl_fltr_table(chk_mw_read_streamlines, chk_mw_read_well_filters)

  # Read example concentration layer levels (8 rasters layers).
  conc_l_lev <- mw_example_conc_layer_levels()
  # Read example initial concentrations of different layers in the subsoil (9 raster layers).
  conc_l <- mw_example_concentrations()

#Initialize base streamline concentration table.
chk_mw_conc_init <- mw_conc_init(chk_mw_read_streamlines, conc_l_lev, conc_l)

# Calculate concentrations on streamlines at specified times.
chk_mw_conc_streamlines <-
  .mw_conc_streamlines(
    conc_strm_lns=chk_mw_conc_init,
    times = c(0, 1 * 365, 5 * 365, 10 * 365, 25 * 365),
    processes = c("dispersion","decay", "retardation"),
    alpha = 0.3,
    rho = 3,
    labda = 0.0001
  )

#  Calculate concentrations on filter at times as specified in table created with \code{\link{.mw_conc_streamlines}}
chk_mw_conc_fltr <- .mw_conc_fltr(
  fltr_nr = 1,
  sl_fltr_table = chk_sl_fltr_table,
  conc_streamlines = chk_mw_conc_streamlines
)

sl_fltr_table <- chk_sl_fltr_table
sl_fltr_table[98,]$FLTR_NR <- 2
sl_fltr_table[99,]$FLTR_NR <- 2
sl_fltr_table[100,]$FLTR_NR <- 2
chk_mw_conc_well <- .mw_conc_well( well_nr=1, well_fltrs=chk_mw_read_well_filters,
                                   sl_fltr_table, conc_streamlines=chk_mw_conc_streamlines )

## Save internal objects
usethis::use_data(chk_mw_read_streamlines,
                  chk_mw_read_well_filters,
                  chk_sl_fltr_table,
                  chk_mw_conc_init,
                  chk_mw_conc_streamlines,
                  chk_mw_conc_fltr,
                  chk_mw_conc_well,
                  overwrite = TRUE,
                  internal = TRUE)
