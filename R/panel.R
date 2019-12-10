#' Creates a panel for all info boxes so they do not overlap
#'
#' @param ... calls with info elements
#' @param position character with position of the parameter. Default "top right".
#' @importFrom shiny tagList
#' @return div which wraps your all info boxes to display it in the position corner of your shiny app.
#' @export
info_panel <- function(..., position = "top right") {
  elements <- lapply(list(...), display, position = position)
  display(tagList(list = elements), position = position, type = "info_panel")
}

#' Wrapper for info_panel function
#'
#' @param ... calls with info elements
#' @param position character with position of the parameter. Default "top right".
#'
#' @return div which wraps your all info boxes to display it in the position corner of your shiny app.
#' @export
infoPanel <- function(..., position = "top right") { #nolint
 info_panel(..., position = position)
}
