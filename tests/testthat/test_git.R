context("git")

test_that("test git", {
  # type
  expect_is(git_info(), "shiny.tag.list")
  # empty
  si_str <- as.character(git_info())
  expect_true(any(grepl("shinyinfo_git_info", si_str, fixed = TRUE)))
})
