#' Hillshader
#'
#' @description .
#'
#' @param elevation Raster
#' @param shader Character. List of `rayshader` shader to sequentially apply. Default to `ray_shade`.
#' @param filename Character. If set, the result if written as a raster file.
#' @param ... Additional parameters
#'
#' @export
#' @importFrom rayshader raster_to_matrix ray_shade lamb_shade ambient_shade
#' @include add_shadow_2d.R matrix_to_raster.R write_raster.R
#'
#' @author Pierre Roudier
#'
hillshader <- function(
  elevation,
  shader = "ray_shade",
  filename = NULL,
  ...
) {

  # Convert raster to matrix
  mat <- raster_to_matrix(elevation)

  # Calculate each shader
  shades <- lapply(
    shader,
    function(shd, ...) {

      # Select shading function
      shader_fun <- switch (
        shd,
        "ray_shade" = rayshader::ray_shade,
        "lamb_shade" = rayshader::lamb_shade,
        "ambient_shade" = rayshader::ambient_shade,
        stop("Wrong shader option", call. = FALSE)
      )

      # Apply shader
      res_shd <- shd(
        heightmap = mat,
        ...
      )

      res_shd
    })

  res <- shades[[1]]

  if (length(shades) > 1) {
    # Sequentially apply other shaders
    for(i in 2:length(shades)) {
      res <- add_shadow_2d(
        hillshade = res,
        shadowmap = shades[[i]]
      )
    }
  }

  if (!is.null(filename)) {
    write_raster(res, filename = filename)
    return(invisible(NULL))
  } else {
    rast <- matrix_to_raster(res, raster = elevation)
    return(rast)
  }

}
