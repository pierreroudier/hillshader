#' Hillshader
#'
#' @description .
#'
#' @param elevation Raster, a digital elevation model.
#' @param shader Character. List of `rayshader` shader(s) to sequentially apply. Defaults to `ray_shade`.
#' @param filename Character. If set, the result if written as a raster file. Defaults to `NULL`.
#' @param ... Additional parameters to be passed to the either shader functions or to `raster::writeRaster`.
#'
#' @returns Either a `RasterLayer` of light intensities (hillshade), or writes the result to disk if `filename` is set.
#'
#' @export
#'
#' @importFrom rayshader raster_to_matrix ray_shade lamb_shade ambient_shade
#' @include utils.R add_shadow_2d.R matrix_to_raster.R write_raster.R
#'
#' @author Pierre Roudier
#'
#' @examples
#'
#' # Simple example
#' library(raster)
#'
#' hs <- hillshader(maungawhau)
#' plot(hs)
#'
hillshader <- function(
  elevation,
  shader = "ray_shade",
  filename = NULL,
  ...
) {

  dots <- list(...)

  # Convert raster to matrix
  mat <- raster_to_matrix(elevation)

  # Calculate each shader
  shades <- lapply(
    shader,
    function(shd) {

      # Select shading function
      shader_fun <- switch (
        shd,
        "ray_shade" = rayshader::ray_shade,
        "lamb_shade" = rayshader::lamb_shade,
        "ambient_shade" = rayshader::ambient_shade,
        stop("Wrong shader option", call. = FALSE)
      )

      args_shader <- dots
      args_shader$heightmap <- mat

      # Subset arguments list to suit shader function
      args_shader <- .subset_args(fun = shader_fun, args = args_shader)

      # Apply shader
      res_shd <- do.call(shader_fun, args_shader)

      res_shd
    })

  res <- shades[[1]]

  if (length(shades) > 1) {
    # Sequentially apply other shaders
    for(i in 2:length(shades)) {

      args_shadow <- dots
      args_shadow$hillshade <- res
      args_shadow$shadowmap <- shades[[i]]

      # Subset arguments list to suit `add_shadow_2d` function
      args_shadow <- .subset_args(fun = add_shadow_2d, args = args_shadow)

      res <- do.call(
        add_shadow_2d,
        args_shadow
      )

    }
  }

  if (!is.null(filename)) {

    args_write_raster <- dots
    args_write_raster$hillshade <- res
    args_write_raster$elevation <- elevation
    args_write_raster$filename <- filename

    do.call(write_raster, args_write_raster)
    return(invisible(NULL))

  } else {
    rast <- matrix_to_raster(res, raster = elevation)
    return(rast)
  }

}
