#' UI output for info value
#'
#' @param id output id to render
#' @param position character with position of the parameter. Default "top right".
#' @importFrom shiny div
#' @return div which wraps rendered value to display it in the {position} corner of your shiny app.
#' @export
info_value <- function(id, position = "top right") {
  display(div(id = id, class = "shiny-text-output"), position = position, type = "value")
}

#' Server render function for info value
#'
#' @param expr value to render
#' @param env The environment in which to evaluate expr.
#' @param quoted Is expr a quoted expression (with quote())? This is useful if you want to save an expression in a variable.
#' @param sep A separator passed to cat to be appended after each element.
#' @importFrom shiny installExprFunction
#' @importFrom shiny createRenderFunction
#' @return Shiny render function to be save as an element of output.
#' @usage output$test <- render_info_value("test value")
#' @export
render_info_value <- function(expr, env = parent.frame(), quoted = FALSE, sep = " ") {
    installExprFunction(expr, "func", env, quoted)

    createRenderFunction(
      func,
      function(value, session, name, ...) {
        paste(utils::capture.output(cat(value, sep = sep)), collapse = "\n")
      }
    )
}
