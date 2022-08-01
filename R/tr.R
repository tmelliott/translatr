#' Translate strings
#'
#' This function uses i18n translations files to provide multi-lingual support for GUIs build with R. The best way to get started is to load this package and then set the `translatr.language` and `translatr.location` global options:
#' ```
#' options(
#'   translatr.language = 'mi',
#'   translatr.location = '/path/to/i18n'
#' )
#' ```
#'
#' @param id the key referencing the desired text
#' @param language the language to provide, looks for `getOption(translatr.language)` by default.
#' @param location the location of translation files, looks for `getOption(translatr.location)` by default.
#' @return a translated character string
#' @examples
#' tr('hello', 'mi', system.file('i18n', package = 'transitr'))
#' @md
#' @export
tr <- function(id,
               language = getOption("translatr.language"),
               location = getOption("translatr.location")) {

    if (is.null(language)) stop("Please specify a language")
    if (is.null(location)) stop("Please specify a location")
    if (!dir.exists(location)) stop("Please specify a valid location")

    t_env <- get_translations(language, location)
    if (!exists(language, envir = t_env) || is.null(t_env[[language]][[id]])) {
        if (is.null(getOption('translatr.language'))) {
            warning("No translation found.")
            return(id)
        }
        language <- getOption("translatr.language")
        t_env <- get_translations(language, location)
    }

    t_env[[language]][[id]]
}

get_translations <- function(language, location) {
    e <- getOption("translatr.env")

    # if language exists in env, return the env
    if (exists(language, envir = e))
        return(e)

    # add language to env and return the env
    f <- file.path(location, sprintf("%s.json", language))
    if (!file.exists(f)) stop("Invalid location and/or language")
    t <- jsonlite::read_json(f)
    assign(language, t, e)

    invisible(e)
}
