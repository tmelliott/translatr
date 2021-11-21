## code to prepare `DATASET` dataset goes here
trans_df <- data.frame(
    id = c("welcome", "hello", "statistics"),
    en = c("Welcome", "Hello", "statistics"),
    mi = c("Haere mai", "Kia ora", "tatauranga"),
    fr = c("Bienvenue", "Bonjour", "les statistiques")
)

library(RSQLite)
db <- "inst/introduction.sqlite"
con <- dbConnect(SQLite(), db)
dbWriteTable(con, "intro", trans_df, overwrite = TRUE)
