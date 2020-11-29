context("powered_by")

test_that("test powered_by", {
  # type
  expect_is(powered_by("Appsilon"), "shiny.tag.list")
  # empty
  expect_error(powered_by())
  # not allowed position
  expect_error(powered_by("Test message", position = "upper"))
})