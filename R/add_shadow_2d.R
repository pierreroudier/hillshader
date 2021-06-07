#' @title Add shadow
#'
#' @description Multiplies a texture array or shadow map by a shadow map.
#'
#' @param hillshade A 2D matrix of shadow intensities.
#' @param shadowmap A matrix that indicates the intensity of the shadow at that point. 0 is full darkness, 1 is full light.
#' @param max_darken Default '0.7'. The lower limit for how much the image will be darkened. 0 is completely black, 1 means the shadow map will have no effect.
#' @param rescale_original Ignored.
#'
#' @author Slight modification from Tyler's code in `rayshader::add_shadow`
#'
#' @export
#' @importFrom scales rescale
#'
#' @examples
#'
#' library(rayshader)
#'
#' # Create elevation matrix
#' maungawhau %>%
#'  raster_to_matrix() %>%
#'  # Create hillshade layer using
#'  # ray-tracing
#'  ray_shade() %>%
#'  # Add ambient shading
#'  add_shadow_2d(
#'    ambient_shade(
#'    heightmap = el_mat
#'  )
#'
add_shadow_2d <- function(hillshade, shadowmap, max_darken = 0.7, rescale_original = FALSE) {
  hillshade <- hillshade ^ 2.2
  # This is where we divert from rayshader::add_shadow
  hillshade <- hillshade * scales::rescale(shadowmap[nrow(shadowmap):1,],c(max_darken,1))
  hillshade <- hillshade ^ (1/2.2)
  hillshade
}
