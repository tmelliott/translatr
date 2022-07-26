slugify <- function(x) {
    # only allow lower-case letters, numbers, and underscores
    # replace spaces with "_", everything else with ""
    x <- gsub(" ", "_", tolower(x))
    x <- gsub("[^a-z0-9\\_]", "", x)
    # if first character is not a number, prefix "X"
    paste0(ifelse(grepl("^[^a-z]", x), "X_", ""), x)
}
