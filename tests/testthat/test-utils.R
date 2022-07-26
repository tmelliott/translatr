test_that("slugify strings are valid object names", {
  expect_equal(slugify("Hello World"), "hello_world")
  expect_equal(slugify("How are you?"), "how_are_you")
  expect_equal(
    slugify("1st Level, 2nd Level"),
    "X_1st_level_2nd_level"
  )
})
