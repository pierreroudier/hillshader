.add_shadow_2d <- function(hillshade, shadowmap, max_darken = 0.7) {
  hillshade <- hillshade ^ 2.2
  # This is where we divert from rayshader::add_shadow
  hillshade <- hillshade * scales::rescale(shadowmap[nrow(shadowmap):1,],c(max_darken,1))
  hillshade <- hillshade ^ (1/2.2)
  hillshade
}

