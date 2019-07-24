#' Creates a panel for all info boxes so they do not overlap
#'
#' @param ... calls with info elements
#' @param position character with position of the parameter. Default "top right".
#'
#' @return div which wraps your all info boxes to display it in the {position} corner of your shiny app.
#' @export
info_panel <- function(..., position = "top right") {
  display(tagList(...), position = position, type = "info_panel") #nolint
}

#' Wrapper for info_panel function
#'
#' @param ... calls with info elements
#' @param position character with position of the parameter. Default "top right".
#'
#' @return div which wraps your all info boxes to display it in the {position} corner of your shiny app.
#' @export
infoPanel <- function(..., position = "top right") {
 info_panel(..., position = position) 
}
