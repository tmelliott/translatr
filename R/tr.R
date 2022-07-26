#' Translate strings
#'
#' This function uses i18n translations files to provide multi-lingual support for GUIs build with R.
#'
#' @param id the key referencing the desired text
#' @param language the language to provide. This is best set using `options(translatr.language = "language")`.
#'
#' @return a translated character string
#' @examples
#' cat('Please see README')
#' @md
#' @export
tr <- function(id, language = getOption("translatr.language")) {
    t_env <- get_translations(language)
    if (!exists(language, envir = t_env) || is.null(t_env[[language]][[id]])) {
        language <- getOption("translatr.language")
        t_env <- get_translations(language)
    }

    t_env[[language]][[id]]
}

get_translations <- function(language = getOption("translatr.language")) {
    e <- getOption("translatr.env")

    # if language exists in env, return the env
    if (exists(language, envir = e))
        return(e)

    # add language to env and return the env
    f <- file.path(getOption("translatr.location"), sprintf("%s.json", language))
    if (!file.exists(f)) stop("Invalid location and/or language")
    t <- jsonlite::read_json(f)
    assign(language, t, e)

    invisible(e)
}
