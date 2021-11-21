
<!-- README.md is generated from README.Rmd. Please edit that file -->

# translatr

<!-- badges: start -->

[![R build
status](https://github.com/tmelliott/translatr/workflows/R-CMD-check/badge.svg)](https://github.com/tmelliott/translatr/actions)
[![Codecov test
coverage](https://codecov.io/gh/tmelliott/translatr/branch/master/graph/badge.svg)](https://codecov.io/gh/tmelliott/translatr?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/translatr)](https://CRAN.R-project.org/package=translatr)

<!-- badges: end -->

The translatr package provides a very simple interface for package
developers to provide translations of the output or user interfaces
(e.g., GUI text). This package **does not** automatically translate
arbitrary text - there are existing packages that do that (such as
[translateR](https://cran.r-project.org/web/packages/translateR/)).

## Installation

<!--
You can install the released version of translatr from [CRAN](https://CRAN.R-project.org) with:

``` r
# install.packages("translatr")
``` -->

The development version is available from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("tmelliott/translatr")
```

## Example

The simplest way to get started is to define a data frame containing one
row for each term, with translations in columns for various languages
you wish to provide:

``` r
library(translatr)
trans_df <- data.frame(id = "hello", en = "Hello", mi = "Kia ora")
tr("hello", "mi", trans_df)
#> [1] "Kia ora"
```

It’s also possible to specify this information in a database, which can
be edited externally. This might provide some performance improvements
if you’re translating lots of terms. This example uses a database, and
also demonstrates setting global options to simplify your code:

``` r
library(RSQLite)
db <- system.file("introduction.sqlite", package = "translatr")
con <- dbConnect(SQLite(), db)

options(
  translatr.language = "mi",
  translatr.con = con,
  translatr.tbl = "intro" # name of the table with translations
)

tr("hello")
#> [1] "Kia ora"
tr("statistics")
#> [1] "tatauranga"
```
