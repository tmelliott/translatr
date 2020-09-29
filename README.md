
<!-- README.md is generated from README.Rmd. Please edit that file -->
translatr
=========

<!-- badges: start -->
[![R build status](https://github.com/tmelliott/translatr/workflows/R-CMD-check/badge.svg)](https://github.com/tmelliott/translatr/actions) [![Codecov test coverage](https://codecov.io/gh/tmelliott/translatr/branch/master/graph/badge.svg)](https://codecov.io/gh/tmelliott/translatr?branch=master) <!-- badges: end -->

The translatr package provides a very simple interface for package developers to provide translations of the output or user interfaces (e.g., GUI text).

Installation
------------

You can install the released version of translatr from [CRAN](https://CRAN.R-project.org) with:

``` r
# install.packages("translatr")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tmelliott/translatr")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(translatr)
trans_df <- data.frame(id = "welcome", en = "Welcome", mri = "Haere mai")
tr("welcome", "mri", trans_df)
#> [1] "Haere mai"
```
