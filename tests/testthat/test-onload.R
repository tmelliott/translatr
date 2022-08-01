test_that("env is created when package loads", {
    options(translatr.env = NULL)
    expect_null(getOption("translatr.env"))
    translatr:::.onLoad()
    expect_type(getOption("translatr.env"), "environment")
})
