test_that("mw_read_streamlines() results in previous created object.", {
  fname <-
    system.file("extdata", "streamlines.iff", package = "mipwelcona")
  expect_equal(mw_read_streamlines(fname), chk_mw_read_streamlines)
})
