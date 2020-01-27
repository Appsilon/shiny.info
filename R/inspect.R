#' Inspect button UI
#'
#' Helps to easlily stop app at any moment for debugging or checking state.
#'
#' @param label label for debug button. Default "Inspect"
#' @param position character with position of the parameter. Default "top right".
#'
#' @return div with "shinyinfo_inspect_btn".
#' @export
inspect_btn_ui <- function(label = "Inspect", position = "top right") {
  inspect <- tags$div(actionButton("shinyinfo_inspect_btn", label))
  display(inspect, position)
}

#' Inspect button server
#'
#' Helps to easlily stop app at any moment for debugging or checking state.
#'
#' @param input Shiny server input.
#'
#' @return observeEvent for Inspect button
#' @export
inspect_btn_server <- function(input) {
  observeEvent(input$shinyinfo_inspect_btn, {
    browser()
  })
}
