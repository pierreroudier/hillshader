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
r <- raster("./data-raw/akl-lidar.vrt")
r_p <- projectRaster(r, crs = "+init=epsg:27200")

r_p_c <- crop(r_p, extent(maungawhau))
maungawhau_hr <- r_p_c

usethis::use_data(maungawhau_hr, overwrite = TRUE)
