context("display")

test_that("test display", {
  # type
  expect_is(display("Test message"), "shiny.tag.list")
  # empty
  expect_error(display())
  # not allowed position
  expect_error(display("Test message", position = "upper"))
  # text value
  si_str <- as.character(display("Test message"))
  expect_true(any(grepl("<div id=\"shinyinfo_message\" class=\"info_box\">Test message</div>", si_str, fixed = TRUE)))
  expect_true(any(grepl("Test message", si_str, fixed = TRUE)))
})
