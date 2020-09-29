## code to prepare `DATASET` dataset goes here

## Prepare check objects
fname <-
  system.file("extdata", "streamlines.iff", package = "mipwelcona")
chk_mw_read_streamlines <- mw_read_streamlines(fname)
fname <-
  system.file("extdata", "well_filters.ipf", package = "mipwelcona")
chk_mw_read_well_filters <- mw_read_well_filters(fname)

## Save internal objects
usethis::use_data(chk_mw_read_streamlines,
                  chk_mw_read_well_filters,
                  overwrite = TRUE,
                  internal = TRUE)
