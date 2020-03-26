#' Create a JS condition for a key
#'
#' @param key key to convert into a condition
#' @param to_lower should the key be converted to lowercase. Default TRUE
#'
#' @return JS condition for checking shortcut
#' @keywords internal
.key_condition <- function(key, to_lower = TRUE) {
  switch(
    key,
    Alt = "e.altKey == true",
    Ctrl = "e.ctrlKey == true",
    Shift = "e.shiftKey == true",
    glue("e.key == '{ifelse(to_lower,tolower(key),key)}'")
  )
}

#' Create a JS condition for a shortcut
#'
#' @param shortcut keys that should be checked. Shortcut can include special keys:
#'  Ctrl, Alt, Shift. Keys should be separated with '+' sign. Default Ctrl+Shift+K
#'
#' @return JS condition for checking shortcut
#' @keywords internal
.shortcut_condition <- function(shortcut) {
  shortcut <- unlist(strsplit(shortcut, "+", fixed = TRUE))

  if ("Shift" %in% shortcut) {
    to_lower <- FALSE
  } else {
    to_lower <- TRUE
  }

  condition <- lapply(shortcut, .key_condition, to_lower = to_lower)
  do.call(paste, c(condition, sep = " && "))
}

#' Toggle showing info with keyboard shortcut
#'
#' @param shortcut keys that trigger showing info. Shortcut can include special keys:
#'  Ctrl, Alt, Shift. Keys should be separated with '+' sign. Default Ctrl+Shift+K
#' @param hidden_on_start should info panels be hidden on start of the application? Default TRUE.
#'
#' @details toggle_info() should be added in the header of the application in ui.R,
#'  since it adds a script with toggle functionality. If you want to use it with info_value,
#'  you have to add outputOptions(output, [info value id], suspendWhenHidden = FALSE) to force
#'  rendering when the value is hidden.
#'
#' @return JS script that adds toggle functionality.
#'
#' @examples
#' if (interactive()){
#' library(shiny)
#' library(shiny.info)
#'
#' ui <- fluidPage(
#'   toggle_info(),
#'   shiny.info::display("test message"),
#'   shiny.info::info_value("test_input_value", "bottom right"),
#'   textInput(inputId = "test_input", label = NULL)
#' )
#'
#' server <- function(input, output, session) {
#'   output$test_input_value <- shiny.info::render_info_value(input$test_input)
#'   outputOptions(output, "test_input_value", suspendWhenHidden = FALSE)
#' }
#'
#' shinyApp(ui = ui, server = server)
#' }
#' @export
#' @import glue
toggle_info <- function(shortcut = "Ctrl+Shift+K", hidden_on_start = TRUE) {
  shortcut_condition <- .shortcut_condition(shortcut)

  if (hidden_on_start) {
    hide <- "$(document).ready(
    function() {{
      $('div.info_box').hide();
    }}
  );"
  } else {
    hide <- ""
  }

  js <- glue::glue("
  {hide}

  $(document).on('keydown', function(e) {{
    if({shortcut_condition}) {{
      $('div.info_box').toggle();
    }}
  }});")

  tags$script(HTML(js))
}
