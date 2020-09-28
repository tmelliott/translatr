## code to prepare `DATASET` dataset goes here
trans_df <- data.frame(
    id = c("welcome", "hello"),
    en = c("Welcome", "Hello"),
    mri = c("Haere mai", "Kia ora"),
    fr = c("Bienvenue", "Bonjour")
)

library(RSQLite)
db <- "inst/introduction.sqlite"
con <- dbConnect(SQLite(), db)
dbWriteTable(con, "intro", trans_df, overwrite = TRUE)
