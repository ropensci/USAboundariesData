#' Historical state and county boundaries for the United States of America
#'
#' These datasets contain polygons for historical boundaries in the United
#' States. These boundaries are taken from the Atlas of Historical County
#' Boundaries. State boundaries cover the period from 1783 to 2000, and county
#' boundaries cover the period from 1629 to 2000. The attribute data includes of
#' the changes to the boundaries and the dates with which they valid. For a full
#' description of all of the columns in the data frame, see the
#' \href{http://publications.newberry.org/ahcb/downloads/united_states.html}{documentation
#' in the zip files} provided by AHCB. The datasets are objects of class
#' \code{sf} from the \href{https://cran.r-project.org/package=sf}{sf package}.
#' They are intended to be used with the functions in the \code{USAboundaries}
#' package, but the data objects can also be used on their own. The data
#' attributes associated with these boundaries are unchanged from what is
#' available in the AHCB shapefiles files, with the exception that
#' \code{state_name}, \code{state_abbreviation}, and \code{state_code} columns
#' have been added where necessary for convience in filtering the boundaries.
#'
#' @details The high resolution boundaries have been generalized to a .01 degree
#'   tolerance	(1:2,500,000; 1 inch = 39 miles). The low resolution boundaries
#'   have been generalized to a .05 degree tolerance (1:12,500,000; 1 inch = 197
#'   miles). See the AHCB website for higher-resolution shapefiles.
#'
#'   See the
#'   \href{https://github.com/ropensci/USAboundaries}{USAboundaries
#'   package} for low-resolution state boundaries and for the functions to
#'   access this data.
#'
#' @docType data
#' @keywords dataset
#' @source John H. Long, et al., \emph{Atlas of Historical County Boundaries},
#'   Dr. William M. Scholl Center for American History and Culture, The Newberry
#'   Library, Chicago (2010), \url{http://publications.newberry.org/ahcbp/}.
#'
#'   See also the
#'   \href{http://publications.newberry.org/ahcb/project.html}{AHCB's about
#'   page}.
#' @name ahcb_boundaries
#' @rdname ahcb_boundaries
NULL

#' @name states_historical_lores
#' @rdname ahcb_boundaries
NULL

#' @name states_historical_hires
#' @rdname ahcb_boundaries
NULL

#' @name counties_historical_lores
#' @rdname ahcb_boundaries
NULL

#' @name counties_historical_hires
#' @rdname ahcb_boundaries
NULL
