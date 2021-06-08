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
#' @returns This function is used for the side-effect of writing values to a file.
#'
#' @export
#'
#' @importFrom raster raster setValues writeRaster
#' @include matrix_to_raster.R
#'
#' @author Pierre Roudier
#'
#' @examples
#'
#' library(rayshader)
#'
#' out_fn <- paste0(tempfile(), ".tif")
#'
#' # Create elevation matrix
#' el_mat <- maungawhau %>%
#'  raster_to_matrix()
#'
#'  el_mat %>%
#'  # Create hillshade layer using
#'  # ray-tracing
#'  ray_shade() %>%
#'  # Add ambient shading
#'  add_shadow_2d(
#'    ambient_shade(
#'      heightmap = el_mat
#'    )
#'  ) %>%
#'  write_raster(
#'    elevation = maungawhau,
#'    filename = out_fn
#'  )
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
