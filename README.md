
<!-- README.md is generated from README.Rmd. Please edit that file -->

# translatr

<!-- badges: start -->

[![R-CMD-check](https://github.com/tmelliott/translatr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/tmelliott/translatr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/tmelliott/translatr/branch/develop/graph/badge.svg)](https://codecov.io/gh/tmelliott/translatr?branch=develop)
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
However, this package has been designed to be compatible with
translation tools such as [crowdin](https://crowdin.com). See the
‘Crowdin’ Vignette for details.

This package is very lightweight (only one dependency, **jsonlite**).
There is a similar package
[shiny.i18n](https://github.com/Appsilon/shiny.i18n) with some more
advanced featuers, but this has a load of dependencies that make it
bloated for non-shiny applications.

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

To get started, you’ll need a directory, typically called `i18n`, with
your translation files.

``` r
library(translatr)

i18n_dir <- system.file("i18n", package = "translatr")
list.files(i18n_dir)
#> [1] "en.json" "mi.json"
jsonlite::prettify(readLines(file.path(i18n_dir, "en.json")))
#> {
#>     "hello": "Hello everyone!"
#> }
#> 
```

The `tr()` function is used to translate strings by looking them up in
the translation dictionary by key:

``` r
tr("hello", "mi", i18n_dir)
#> [1] "Kia ora koutou!"
```

Of course, this is tedious if you have lots of strings to translate\! To
avoid this, you can specify ‘language’ and ‘location’ as global options:

``` r
options(
  translatr.location = i18n_dir,
  translatr.language = "en"
)
tr("hello")
#> [1] "Hello everyone!"
tr("hello", "mi")
#> [1] "Kia ora koutou!"
```

You can change the global options at any time, for example when a user
changes their preferences.

``` r
tr("hello")
#> [1] "Hello everyone!"
options(translatr.language = "mi")
tr("hello")
#> [1] "Kia ora koutou!"
```
