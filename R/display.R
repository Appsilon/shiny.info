#' Display message on the top-right corner
#'
#' @param message character with any message you want
#'
#' @return div which wraps your message to display it in the top-right corner of your shiny app.
#' @export
display <- function(message) {
  style = "
    position: absolute;
    top: 0;
    right: 0;
    width: auto;
    height: auto;
    background-color: #E0E0E0;
    padding: 3px 8px;
    font-size: 12px;"

  div(style = style, message)
}
