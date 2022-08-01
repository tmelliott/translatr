op <- options()
i18n <- system.file("i18n", package = "translatr")
op.translatr <- list(
    translatr.location = i18n,
    translatr.language = "en"
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

test_that("Error checking", {
    options(
        translatr.location = NULL,
        translatr.language = NULL,
        translatr.env = new.env()
    )

    expect_error(tr("welcome"))
    expect_error(tr("welcome", "mi"))
    expect_error(tr("welcome", "mi", "not/a/directory"))

    expect_error(tr("hello", "de", i18n))
    expect_warning(tr("goodbye", "fr", i18n))

    options(translatr.env = NULL)
    expect_warning(tr("welcome", "en", i18n))
})
