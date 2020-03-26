#' Server render function for rendering informations about user session (app URL, username and pixel ratio)
#'
#' @details  Use it with info_value UI function. If you want to use it with toggle_info(),
#'  you have to add outputOptions(output, [session info id], suspendWhenHidden = FALSE) to force
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
#'    info_value("session_info")
#' )
#' 
#' server <- function(input, output, session) {
#'   outputsession_info <- render_session_info()
#'   # next line is required to work with toggle_info()
#'   outputOptions(output, "session_info", suspendWhenHidden = FALSE)
#' }
#' }
#' @export
render_session_info <- function() {
  session <- parent.frame()$session

  url <- glue::glue(
    "url: {isolate(session$clientData$url_protocol)}//
    {isolate(session$clientData$url_hostname)}:
    {isolate(session$clientData$url_port)}"
  )

  user <- glue::glue(
    "user: {isolate(session$user)}"
  )

  pixel_ratio_value <- isolate(session$clientData$pixelratio)
  pixel_ratio_value <- switch(pixel_ratio_value,
    "1" = "not provided",
    "2" = "not provided, Apple Retina",
    pixel_ratio_value
  )

  pixel_ratio <- glue::glue(
    "pixel ratio: {pixel_ratio_value}"
  )

  installExprFunction(url, "func", parent.frame(), FALSE)

  createRenderFunction(
    func,
    function(value, session, name, ...) {
      HTML(paste(url, user, pixel_ratio, sep = "<br/>"))
    }
  )
}
