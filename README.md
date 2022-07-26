
<!-- README.md is generated from README.Rmd. Please edit that file -->

# translatr

<!-- badges: start -->

[![R build
status](https://github.com/tmelliott/translatr/workflows/R-CMD-check/badge.svg)](https://github.com/tmelliott/translatr/actions)
[![Codecov test
coverage](https://codecov.io/gh/tmelliott/translatr/branch/main/graph/badge.svg)](https://codecov.io/gh/tmelliott/translatr?branch=main)
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

To get started, first create translation files, typically stored in a
directory `i18n`.

``` r
i18n_temp <- file.path(tempdir(), "i18n")
dir.create(i18n_temp)
jsonlite::write_json(
  list("hello" = "Hello everyone!"),
  file.path(i18n_temp, "en.json"),
  pretty = TRUE,
  auto_unbox = TRUE
)
jsonlite::write_json(
  list("hello" = "Kia ora koutou!"),
  file.path(i18n_temp, "mi.json"),
  pretty = TRUE,
  auto_unbox = TRUE
)
```

Now set the options so `translatr` knows where to look for translations,
which language to use, and where to cache the files in memory:

``` r
library(translatr)
options(
  translatr.location = i18n_temp,
  translatr.language = "en",
  translatr.env = new.env()
)
```

Now, just use the handy `tr()` function to translate text.

``` r
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
