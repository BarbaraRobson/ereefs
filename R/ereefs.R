#' ereefs: Some useful tools for exctracting and visualising eReefs and EMS netcdf data
#'
#' The ereefs package provides several functions:
#'    map_ereefs() Produces surface maps of model variables downloaded directly from NCI servers
#'                 or other EMS netcdf output files.
#'    map_ereefs_movie() Produces an animation of surface maps similar to those produced by map_ereefs,
#'                 except that it currently only works for GBR4 model output.
#'    plume_class() Calculates plume optical classes. Mostly intended as a helper function for the above
#'                 two functions, but can be accessed directly.
#'    get_ereefs_ts() Extracts a time-series at any arbitrary location from GBR4 output
#'    get_ereefs_depth_integrated_ts() Extracts a vertically integrated time-series at any arbitrary location
#'                 from GBR4 output
#'    get_ereefs_depth_specified_ts() Extracts a time-series from a specified depth below the surface at
#'                 any arbitrary location within the GBR4 model domain.
#'
#' @docType package
#' @name ereefs
NULL