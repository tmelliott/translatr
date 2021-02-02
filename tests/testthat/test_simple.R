context("Basic translation")

test_that("Correct translation is returned", {
    trans_df <- data.frame(id = "hello", en = "Hello", mri = "Kia ora")
    expect_equal(tr("hello", "mri", trans_df), "Kia ora")
    expect_equal(tr("hello", "en", trans_df), "Hello")
})

test_that("Translation can accept a fallback language", {
    trans_df <- data.frame(
        id = c("hello", "blargh"),
        en = c("Hello", "Blargh"),
        mri = c("Kia ora", "")
        )
    expect_equal(tr(c("hello", "blargh"), c("mri"), trans_df), c("Kia ora", ""))
    expect_equal(tr(c("hello", "blargh"), c("mri", "en"), trans_df), c("Kia ora", "Blargh"))
})

test_that("Missing IDs are simply returned", {
    trans_df <- data.frame(id = "hello", en = "Hello", mri = "Kia ora")
    expect_equal(tr("good bye", "en", trans_df), "good bye")
})
