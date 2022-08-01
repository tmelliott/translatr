.onLoad <- function(libname, pkgname) {
    if (is.null(getOption("translatr.env"))) {
        options(
            translatr.env = new.env()
        )
    }
}
