#' @title  Write hillshade to a file
#'
#' @description Write an array from a hillshade procedure to a geospatial raster file.
#'
#' @param hillshade A 2D matrix of shadow intensities.
#' @param elevation Original elevation raster.
#' @param filename Character.  Output filename.
#' @param format Character. Output file type. Passed to `raster::writeRaster`.
#' @param ... Additional arguments passed to `raster::writeRaster`.
#'
#' @export
#' @importFrom raster raster setValues writeRaster
#' @include matrix_to_raster.R
#'
#' @author Pierre Roudier
#'
write_raster <- function(hillshade, elevation, filename, format, ...) {

  res <- matrix_to_raster(hillshade, raster = elevation)

  writeRaster(
    x = res,
    filename = filename,
    format = format,
    ...
  )
  invisible(NULL)
}
