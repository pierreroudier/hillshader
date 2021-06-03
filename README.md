
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hillshader

<!-- badges: start -->
<!-- badges: end -->

The `hillshader` package is a wrapper around `rayshader` to create
hillshade relief maps using ray-tracing.

## Installation

You can install the development version of hillshader with the `remotes`
package:

``` r
remotes::install_github("pierreroudier/hillshader")
```

## First steps

### The `hillshader` function

``` r
library(raster)
#> Loading required package: sp
library(rayshader)

library(hillshader)
```

``` r
plot(maungawhau_hr)
```

<img src="man/figures/README-mwh-1.png" width="100%" />

``` r
hs <- hillshader(elevation = maungawhau_hr)
plot_map(hs)
```

<img src="man/figures/README-hillshader-1.png" width="100%" />

### More shaders!

``` r
hs <- hillshader(
  elevation = maungawhau_hr, 
  shader = c("ray_shade", "ambient_shade")
)

plot_map(hs)
```

<img src="man/figures/README-hillshader2-1.png" width="100%" />

### Changing sun position

``` r
hs <- hillshader(
  elevation = maungawhau_hr, 
  shader = c("ray_shade", "ambient_shade"),
  sunangle = 180,
  sunaltitude = 25
)

plot_map(hs)
```

<img src="man/figures/README-hillshader3-1.png" width="100%" />

### Saving to file

``` r
hillshader(
  elevation = maungawhau_hr, 
  shader = c("ray_shade", "ambient_shade"),
  sunangle = 180,
  sunaltitude = 25,
  filename = "hillshade.tif"
)
```

## Advanced use in the `rayshader` pipelines

The `hillshader` package provides three functions that can be used
within the `rayshader` pipelines:

-   `add_shadow_2d`,
-   `matrix_to_raster`,
-   `write_raster`

``` r
el_mat <- raster_to_matrix(maungawhau_hr)

el_mat %>% 
  ray_shade %>%
  add_shadow_2d(
    ambient_shade(
      heightmap = el_mat
    )
  ) %>% 
  write_raster(
    elevation = maungawhau_hr,
    filename = "hillshade.tif"
  )
```
