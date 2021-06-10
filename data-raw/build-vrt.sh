#!/bin/bash

# Build VRT
gdalbuildvrt akl-lidar.vrt lds-auckland-lidar-1m-dem-2013-GTiff/*.tif
