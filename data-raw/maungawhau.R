## code to prepare `maungawhau` dataset goes here
mw <- datasets::volcano
mw <- mw[nrow(mw):1,]
y <- seq(from = 6478705, length.out = 87, by = 10)
x <- seq(from = 2667405, length.out = 61, by = 10)
maungawhau <- raster::raster(
  mw,
  xmn = min(x), xmx = max(x),
  ymn = min(y), ymx = max(y),
  crs = "+init=epsg:27200"
)

usethis::use_data(maungawhau, overwrite = TRUE)
