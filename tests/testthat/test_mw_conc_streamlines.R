test_that("mw_conc_streamlines() results in previous created object.", {
  expect_equal( mw_conc_streamlines(
    chk_mw_conc_init,
    times = c(0, 1 * 365, 5 * 365, 10 * 365, 25 * 365),
    processes = c("dispersion","decay", "retardation"),
    alpha = 0.3,
    rho = 3,
    labda = 0.0001
  ), chk_mw_conc_streamlines)
})
