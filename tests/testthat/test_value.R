context("value")

test_that("test info_value", {
  # type
  expect_is(info_value("a"), "shiny.tag.list")
  # check id
  si_str <- as.character(info_value("a"))
  expect_true(any(grepl("id=\"a\"", si_str, fixed = TRUE)))
  # check random generator
  si_str1 <- as.character(info_value("a"))
  si_str2 <- as.character(info_value("a"))
  expect_false(si_str1 == si_str2)
})
