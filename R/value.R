utils::globalVariables("func")

#' UI output for info value
#'
#' @param id output id to render
#' @param position character with position of the parameter. Default "top right".
#'
#' @return div which wraps rendered value to display it in the {position} corner of your shiny app.
#'
#' @importFrom shiny div
#' @export
#'
info_value <- function(id, position = "top right") {
  type <- paste0("value-", sample(1:1000000, 1))
  display(div(id = id, class = "shiny-html-output"), position = position, type = type)
}

#' Server render function for info value
#'
#' @param expr value to render
#' @param env The environment in which to evaluate expr. Default parent.frame()
#' @param quoted Is expr a quoted expression (with quote())? This is useful if you want to save an
#'  expression in a variable. Default FALSE
#' @param sep A separator passed to cat to be appended after each element.
#' @param add_name Should expression name be added. Default TRUE
#'
#' @details  If you want to use it with toggle_info(),
#'  you have to add outputOptions(output, [info value id], suspendWhenHidden = FALSE) to force
#'  rendering when the value is hidden.
#'
#' @return Shiny render function to be saved as an element of output.
#'
#' @importFrom shiny installExprFunction
#' @importFrom shiny createRenderFunction
#'
#' @examples
#' if(interactive()){
#' library(shiny)
#' library(shiny.info)
#'
#' ui <- fluidPage(
#'   info_value("value_to_display")
#' )
#' 
#' server <- function(input, output, session) {
#'   test_reactive <- reactiveVal("some value")
#'   output$value_to_display <- render_info_value(expr = test_reactive())
#'   # next line is required to work with toggle_info()
#'   outputOptions(output, "value_to_display", suspendWhenHidden = FALSE)
#' }
#' }
#' @export
render_info_value <- function(expr, env = parent.frame(), quoted = FALSE, sep = " ", add_name = TRUE) {
    expr_name <- deparse(substitute(expr))
    if (add_name) {
      expr_name <- paste0(deparse(substitute(expr)), " = ")
    } else {
      expr_name <- NULL
    }

    installExprFunction(expr, "func", env, quoted)

    createRenderFunction(
      func,
      function(value, session, name, ...) {
        paste0(expr_name, paste(utils::capture.output(cat(value, sep = sep)), collapse = "\n"))
      }
    )
}
