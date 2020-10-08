## code to prepare `DATASET` dataset goes here


library(raster)
fname <-
  system.file("extdata", "concentrations.tif", package = "mipwelcona")
x <- raster::raster(fname)
 raster::brick(x,x/2,x/4,x/8,x/16,x/32,x/64,x/128,x/256)



usethis::use_data(DATASET, overwrite = TRUE,
                  internal = FALSE)
