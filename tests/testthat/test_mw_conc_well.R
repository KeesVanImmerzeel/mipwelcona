test_that(".mw_conc_well() results in previous created object.", {
  sl_fltr_table <- chk_sl_fltr_table
  sl_fltr_table[98,]$FLTR_NR <- 2
  sl_fltr_table[99,]$FLTR_NR <- 2
  sl_fltr_table[100,]$FLTR_NR <- 2
  expect_equal(
    .mw_conc_well( well_nr=1, well_fltrs=chk_mw_read_well_filters,
                   sl_fltr_table, conc_streamlines=chk_mw_conc_streamlines ),
    chk_mw_conc_well
  )
})
