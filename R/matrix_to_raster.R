#' Matrix to Raster
#'
#' @description Turns a matrix into a Raster
#'
#' @param matrix The input matrix, typically the output of a `rayshader` operation
#' @param raster The original raster from which `matrix` is derived. Can be an `Extent` object.
#' @param crs If an `Extent` object is passed to the `raster` option, the corresponding coordinate reference system information.
#'
#' @export
#' @importFrom raster extent projection raster flip
#'
#' @author Pierre Roudier
#'
matrix_to_raster <- function(matrix, raster, crs = NULL) {

  if (is(raster, "RasterLayer")) {
    e <- extent(raster)
    crs <- projection(raster)
  } else if (is(raster, "Extent")) {
    e <- raster
    if (is.null(crs)) {
      stop("If the option `raster` is an `Extent` objetc, you need to pass the coordinate reference system using the `crs` option.", call. = FALSE)
    }
  } else {
    stop("Option `raster` must be either an object of class `RasterLayer` or `Extent`.", call. = FALSE)
  }

  m <- t(matrix)
  r <- raster(m)
  r <- flip(r, direction = "x")

  extent(r) <- e
  projection(r) <- projection(raster)

  return(r)
}
