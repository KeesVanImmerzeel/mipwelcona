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

## Save internal objects
usethis::use_data(chk_mw_read_streamlines,
                  chk_mw_read_well_filters,
                  chk_sl_fltr_table,
                  overwrite = TRUE,
                  internal = TRUE)
