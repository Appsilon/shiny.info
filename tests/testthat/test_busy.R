context("busy")

test_that("test busy", {
  # type
  expect_is(busy(), "shiny.tag.list")
  # position argument
  expect_error(busy(position = ""))
  si_str <- as.character(busy(position = "bottom right"))
  expect_true(any(grepl("Busy...", si_str, fixed = TRUE)))
  # loader argument
  si_str <- as.character(busy(loader = "dots"))
  expect_true(any(grepl("Busy...", si_str, fixed = TRUE)))
})
