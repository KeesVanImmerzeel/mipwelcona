test_that("mw_conc_init() results in previous created object.", {
  conc_l_lev <- mw_example_conc_layer_levels()
  conc_l <- mw_example_concentrations()
  expect_equal(mw_conc_init(chk_mw_read_streamlines, conc_l_lev, conc_l), chk_mw_conc_init)
})
