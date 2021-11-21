context("Basic translation")

test_that("Correct translation is returned", {
    trans_df <- data.frame(id = "hello", en = "Hello", mi = "Kia ora")
    expect_equal(tr("hello", "mi", trans_df), "Kia ora")
    expect_equal(tr("hello", "en", trans_df), "Hello")
})

test_that("Translation can accept a fallback language", {
    trans_df <- data.frame(
        id = c("hello", "blargh"),
        en = c("Hello", "Blargh"),
        mi = c("Kia ora", "")
        )
    expect_equal(tr(c("hello", "blargh"), c("mi"), trans_df), c("Kia ora", ""))
    expect_equal(tr(c("hello", "blargh"), c("mi", "en"), trans_df), c("Kia ora", "Blargh"))
})

test_that("Missing IDs are simply returned", {
    trans_df <- data.frame(id = "hello", en = "Hello", mi = "Kia ora")
    expect_equal(tr("good bye", "en", trans_df), "good bye")
})
