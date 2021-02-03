#' Translate text
#'
#' The translate function returns the translation of a text by ID.
#'
#' You can set the default language for your session using `options(translatr.language = 'māori')`, otherwise "english" will be used (by default). Similarly, you can specify the translation dictionary with the option `translatr.table`, or by supplying `translatr.con` and `translatr.tbl` to connect to a database with a table containing the translations.
#'
#'
#' @param textid the character ID of the string to translate
#' @param language the language code to translate to. Users may specify a second language as a fallback by passing a vector of length 2.
#' @param table a data.frame-like object with translations
#' @param id_col index or name of the column containing text IDs
#' @param con a database connection containing necessary translation tables
#' @param tbl the name of the table in the database containing the translations
#'
#' @export
#' @examples
#' trans_df <- data.frame(id = "hello", en = "Hello", mri = "Kia ora")
#' tr("hello", "mri", trans_df)
#'
#' \dontrun{
#' require(RSQLite)
#' con <- dbConnect(SQLite(), system.file("introduction.sqlite", package = "translatr"))
#' options(translatr.con = con, translatr.tbl = "intro")
#' tr("hello", "fr")
#' tr("statistics", "mri")
#' }
tr <- function(textid, language, table, id_col = 1L, con, tbl) {
    if (missing(language) || is.null(language))
        language <- getOption("translatr.language")
    if (is.null(language)) language <- colnames(table)[2]

    # try dialects (en -> en-gb, en-us etc; OR en-us -> en-gb, en)

    language <- tolower(language)

    if (missing(table) || is.null(table))
        table <- getOption("translatr.table")
    if (is.null(table)) {
        if (missing(con) || is.null(con))
            con <- getOption("translatr.con")
        if (missing(tbl) || is.null(tbl))
            tbl <- getOption("translatr.tbl")

        if (!(is.null(con) || is.null(tbl)))
            table <- dplyr::tbl(con, tbl)
    }
    if (is.null(table))
        stop("Please specify translation table")

    .translate(table, textid, language, id_col = id_col)
}

.translate <- function(table, id, lang, id_col) UseMethod(".translate")

.translate.data.frame <- function(table, id, lang, id_col = 1L) {
    if (!lang[1] %in% colnames(table))
        stop(sprintf("I don't speak %s", lang[1]))

    rownames(table) <- table[[id_col]]
    colnames(table) <- tolower(colnames(table))

    final <- ifelse(id %in% rownames(table), table[id, lang[1]], id)
    if (length(lang) > 1L)
        final <- ifelse(is.na(final) | final == "", table[id, lang[2]], final)
    final
}

.translate.tbl_sql <- function(table, id, lang, id_col) {
    if (is.numeric(id_col)) id_col <- colnames(table)[id_col]

    table <- table %>%
        dplyr::filter(!!rlang::ensym(id_col) == !!id) %>%
        dplyr::select(!!id_col, !!lang)

    dplyr::collect(table) %>% dplyr::pull(!!lang)
}
