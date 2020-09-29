test_that("mw_read_well_filters() results in previous created object.", {
  fname <-
    system.file("extdata", "well_filters.ipf", package = "mipwelcona")
  expect_equal(mw_read_well_filters(fname), chk_mw_read_well_filters)
})


