context("info_panel")

test_that("test info_panel", {
  # type
  expect_is(info_panel(), "shiny.tag.list")
  # empty
  si_str <- as.character(info_panel())
  expect_true(any(grepl("<div id=\"shinyinfo_info_panel\" class=\"info_box\"></div>", si_str, fixed = TRUE)))
  # text value
  si_str <- as.character(info_panel(display("Test message"), display("Second test message")))
  expect_true(any(grepl("Test message", si_str, fixed = TRUE)))
  expect_true(any(grepl("Second test message", si_str, fixed = TRUE)))
  # infoPanel
  expect_equal(infoPanel(), info_panel())
})
