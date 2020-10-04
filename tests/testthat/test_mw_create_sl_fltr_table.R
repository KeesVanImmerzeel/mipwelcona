test_that("mw_create_sl_fltr_table() results in previous created object.", {
  expect_equal(.mw_create_sl_fltr_table(chk_mw_read_streamlines, chk_mw_read_well_filters), chk_sl_fltr_table)
})


