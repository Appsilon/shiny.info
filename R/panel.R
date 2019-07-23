#' Creates a panel for all info boxes so they do not overlap
#'
#' @param position character with position of the parameter. Default "top right".
#' @param ... calls with info elements
#'
#' @return div which wraps your all info boxes to display it in the {position} corner of your shiny app.
#' @export
infoPanel <- function(position = "top left", ...) {
  display(tagList(...), position = position, type = "info_panel")
}
