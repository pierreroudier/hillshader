
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
