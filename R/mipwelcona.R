#' mipwelcona: calculate the development of the concentrations of solvents in pumped groundwater..
#'
#' This package exports no sample data sets/objects:
#'
#' This package exports the following functions:
#'
#' * \code{\link{mw_read_streamlines}}
#' * \code{\link{mw_read_well_filters}}
#' * \code{\link{mw_conc_init}}
#' * \code{\link{mw_conc_streamlines}}
#' * \code{\link{mw_create_sl_fltr_table}}
#' * \code{\link{mw_conc_filters}}
#'
#' * \code{\link{mw_example_concentrations}}
#' * \code{\link{mw_example_conc_layer_levels}}
#' * \code{\link{mw_example_base_streamline_conc_table}}
#' * \code{\link{mw_example_conc_streamlines}}
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
