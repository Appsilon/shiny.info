context("version")

test_that("test version", {
  # type
  expect_is(version(), "shiny.tag.list")
  # text value
  si_str <- as.character(version("1.0.0"))
  expect_true(any(grepl("<div id=\"shinyinfo_version\" class=\"info_box\">1.0.0</div>", si_str, fixed = TRUE)))
  expect_true(any(grepl("1.0.0", si_str, fixed = TRUE)))
  # variable value
  VERSION <- "1.2.0" #nolint
  si_str <- as.character(version())
  expect_true(any(grepl("<div id=\"shinyinfo_version\" class=\"info_box\">1.2.0</div>", si_str, fixed = TRUE)))
  expect_true(any(grepl("1.2.0", si_str, fixed = TRUE)))
})
