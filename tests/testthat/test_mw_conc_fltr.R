test_that(".mw_conc_fltr() results in previous created object.", {
  expect_equal(
    .mw_conc_fltr(
      fltr_nr = 1,
      sl_fltr_table = chk_sl_fltr_table,
      conc_streamlines = chk_mw_conc_streamlines
    ),
    chk_mw_conc_fltr
  )
})
