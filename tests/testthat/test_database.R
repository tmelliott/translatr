context("Database translations")

require(RSQLite)

db <- system.file("introduction.sqlite", package = "translatr")
con <- dbConnect(SQLite(), db)
on.exit(dbDisconnect(con))

test_that("Basic database translations return correct text", {
    expect_equal(tr("hello", "mri", con = con, tbl = "intro"), "Kia ora")
    expect_equal(tr("statistics", "en", con = con, tbl = "intro"), "statistics")
})
