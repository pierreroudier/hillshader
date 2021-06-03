library(raster)

data("maungawhau")

# LiDAR data downloaded from LINZ data service
# at https://data.linz.govt.nz/layer/53405-auckland-lidar-1m-dem-2013/
#
# - unzip downloaded archive
# - create VRT: gdalbuildvrt akl-lidar.vrt *.tif
# - reproject and convert to geoTIFF:
#  gdalwarp akl-lidar.vrt akl-lidar.tif -t_srs EPSG:27200 -te 2667405 6478705 2668005 6479565
# - crop to `volcano` footprint:
r <- raster("./data-raw/akl-lidar.tif")

gf <- focalWeight(r, 2, "Gauss")
rg <- focal(r, w = gf)

maungawhau_hr <- r

usethis::use_data(maungawhau_hr, overwrite = TRUE)
