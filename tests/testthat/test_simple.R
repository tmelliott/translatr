context("Basic translation")

test_that("Correct translation is returned", {
    trans_df <- data.frame(id = "hello", en = "Hello", mri = "Kia ora")
    expect_equal(tr("hello", "mri", trans_df), "Kia ora")
    expect_equal(tr("hello", "en", trans_df), "Hello")
})
