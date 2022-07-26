op <- options()
op.translatr <- list(
    translatr.location = file.path("i18n"),
    translatr.language = "en",
    translatr.env = new.env()
)
options(op.translatr)
on.exit(options(op))

test_that("correct translations returned", {
    expect_equal(tr("welcome"), "Welcome")
    expect_equal(tr("welcome", "fr"), "Bienvenue")
})

test_that("missing translations return default language", {
    expect_equal(
        tr("demo_message", "fr"),
        "This is a demonstration message!"
    )
})
