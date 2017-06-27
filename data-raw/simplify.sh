#!/bin/sh

set -x

# mapshaper ./temp/ahcb/US_HistStateTerr_Gen01.shp -o format=geojson historical/histstates.geojson
# mapshaper ./temp/ahcb/US_HistCounties_Gen01.shp -o format=geojson historical/histcounties.geojson
# mapshaper ./congressional-districts/congress-lt20.shp -o format=geojson historical/histcongress.geojson

geo2topo histstates=historical/histstates.geojson histcounties=historical/histcounties.geojson histcongress=historical/histcongress.geojson -q 1e5 -o historical/historical.topojson


