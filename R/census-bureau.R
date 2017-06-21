#' Cartographic boundary files from the U.S. Census Bureau
#'
#' The U.S. Census Bureau provides
#' \href{https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html}{cartographic
#' boundary files} for current U.S. boundaries. The datasets in this package
#' provide a selection of boundaries from the 2016 Census files. They are
#' objects of class \code{sf} from the
#' \href{https://cran.r-project.org/package=sf}{sf package}. They are intended
#' to be used with the functions in the \code{USAboundaries} package, but the
#' data objects can also be used on their own. The data attributes associated
#' with these boundaries is unchanged from what is available in the Census
#' boundary files, with the exception that \code{state_name} and
#' \code{state_abbreviation} columns have been added where necessary for
#' convience in filtering the boundaries.
#'
#' The following objects are included in this package:
#'
#' \describe{\item{congress_contemporary_hires}{Congressional district
#' boundaries for the 115th Congress, 1:500k resolution.}
#' \item{congress_contemporary_lores}{Congressional district boundaries for the
#' 114th Congress, 1:20m resolution.} \item{counties_contemporary_hires}{County
#' boundaries, 1:500k resolution.} \item{counties_contemporary_lores}{County
#' boundaries, 1:20m resolution.} \item{states_contemporary_hires}{State
#' boundaries, 1:500k resolution.} \item{zipcodes}{Centroids of Zip Code
#' Tabulation Areas.} }
#'
#' See the \href{https://cran.r-project.org/package=USAboundaries}{USAboundaries
#' package} for low-resolution state boundaries and for the functions to access
#' this data.
#'
#' @references U.S. Census Bureau,
#'   \href{https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html}{Cartographic
#'    Boundary Shapefiles} (2017).
#'
#'   See the U.S. Census Bureau's
#'   "\href{https://www.census.gov/geo/reference/geoidentifiers.html}{Understanding
#'    Geographic Identifiers (GEOIDs)}" and their
#'   "\href{https://www.census.gov/geo/reference/geocodes.html}{Geographic
#'   Codes}" pages for the details of this attribute data.
#' @name census_boundaries
#' @rdname census_boundaries
NULL

#' @name congress_contemporary_hires
#' @rdname census_boundaries
NULL

#' @name congress_contemporary_lores
#' @rdname census_boundaries
NULL

#' @name counties_contemporary_hires
#' @rdname census_boundaries
NULL

#' @name counties_contemporary_lores
#' @rdname census_boundaries
NULL

#' @name states_contemporary_hires
#' @rdname census_boundaries
NULL

#' @name zipcodes
#' @rdname census_boundaries
NULL
