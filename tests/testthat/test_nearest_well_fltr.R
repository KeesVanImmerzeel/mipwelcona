test_that(".nearest_well_fltr() results in expected filter number (FLTR_NR).", {
  particle <- c(X=271877.5, Y=554247.5, Z=-41.237)
  expect_equal(.nearest_well_fltr(particle, chk_mw_read_well_filters, maxdist = 100), 1)
  chk_mw_read_well_filters
})


