#' mipwelcona: calculate the development of the concentrations of solvents in pumped groundwater.
#'
#' The development of the concentrations of solvents in pumped groundwater is calculated based on:
#' * streamline calculations (backwards from well screens) in a [MIPWA](https://oss.deltares.nl/web/imod/mipwa-showcase) groundwater model;
#' * Initial concentrations in specified layers;
#' * Levels of concentration layers;
#' * Parameters of different processes.
#'
#' The mipwelcona package is a further development of the program [WELCONA](https://edepot.wur.nl/10147).
#'
#' The following **processes** can be specified:
#' - Dispersion;
#' - Retardation;
#' - Decay.
#'
#'
#' The following **functions** are exported:
#'
#' * \code{\link{mw_read_streamlines}}
#' * \code{\link{mw_read_well_filters}}
#' * \code{\link{mw_conc_init}}
#' * \code{\link{mw_conc_streamlines}}
#' * \code{\link{mw_create_sl_fltr_table}}
#' * \code{\link{mw_conc_filters}}
#'
#' Sample **data sets** are made available by calling the appropiate functions:
#'
#' * \code{\link{mw_example_concentrations}}
#' * \code{\link{mw_example_conc_layer_levels}}
#' * \code{\link{mw_example_base_streamline_conc_table}}
#' * \code{\link{mw_example_conc_streamlines}}
#' * \code{\link{mw_example_sl_fltr_table}}
#'
#' **Example work flow:**
#'
#' * Step 1: read streamlines.
#' ```
#'          fname <- system.file("extdata","streamlines.iff",package="mipwelcona")
#'          strm_lns <- mw_read_streamlines(fname)
#' ```
#' * Step 2: Read well filters.
#' ```
#'          fname <- system.file("extdata","well_filters.ipf",package="mipwelcona")
#'          well_fltrs <- mw_read_well_filters(fname)
#' ```
#' * Step 3: Create concentration layer levels (8 example rasters layers in this case).
#' ```
#'          conc_l_lev <- mw_example_conc_layer_levels()
#' ```
#' * Step 4: Create Initial concentrations of different layers in the subsoil (9 example rasters layers in this case).
#' ```
#'          conc_l <- mw_example_concentrations()
#' ```
#' * Step 5: Initialize base streamline concentration table.
#' ```
#'          conc_strm_lns <- mw_conc_init(strm_lns, conc_l_lev, conc_l)
#' ```
#' * Step 6: Calculate concentrations on streamlines at specified times.
#' ```
#'          conc_streamlines <- mw_conc_streamlines(conc_strm_lns, times=c(1*365,5*365,10*365,25*365), processes=c("dispersion","decay", "retardation"), alpha=0.3, rho=3, labda=0.0001, retard=1)
#' ```
#' * Step 7: Create table with indices linking the streamlines to well filters.
#' ```
#'          sl_fltr_table <- mw_create_sl_fltr_table(strm_lns, well_fltrs, maxdist=100)
#' ```
#' * Step 8: Calculate concentrations (mixed) of selected filters.
#' ```
#'          # Overrule previously created table first for this example. Normally, you wouln't do this!
#'          sl_fltr_table <- mw_example_sl_fltr_table()
#'          conc <- mw_conc_filters( fltr_nrs=c(1,2), well_fltrs, sl_fltr_table, conc_streamlines )
#' ```
#'
#' @docType package
#' @name mipwelcona
#'
#' @importFrom dplyr group_by
#' @importFrom dplyr mutate
#' @importFrom dplyr cur_group_id
#' @importFrom dplyr ungroup
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr distinct
#' @importFrom dplyr arrange
#' @importFrom dplyr group_modify
#' @importFrom dplyr rename
#' @importFrom dplyr bind_rows
#' @importFrom dplyr pull
#' @importFrom dplyr relocate
#' @importFrom dplyr left_join
#'
#' @importFrom magrittr %<>%
#' @importFrom magrittr %>%
#'
#' @importFrom utils read.csv
#'
#' @importFrom raster raster
#' @importFrom raster brick
#' @importFrom raster extract
#'
#' @importFrom stats approx
#' @importFrom stats weighted.mean
#'
#' @importFrom lmomco vec2par
#' @importFrom lmomco cdfpe3
#'
#' @importFrom purrrlyr by_row
#'
#' @importFrom data.table rbindlist
NULL
