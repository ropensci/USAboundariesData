## Test environments
* local OS X 10.10.4 install, R 3.2.1
* Ubuntu 12.04 (on travis-ci), R 3.2.1
* Debian (via Docker), R-devel
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs.

There was one NOTE:

* checking installed package size ... NOTE
  installed size is 48.8Mb
  sub-directories of 1Mb or more:
    data  48.7Mb

This package is over the 5MB data limit prescribed by the R package documentation. However, this is a data only package which will be infrequently updated. The code to access this data is all in the 'USAboundaries' package. 

