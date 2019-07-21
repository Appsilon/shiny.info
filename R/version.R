#' Display version of the app
#' 
#' Displays the version of the app by default using VERSION global variable.
#'
#' @param ver (default NULL) custom version number
#' @param position character with position of the parameter. Default "top right".
#' 
#' @export
#'
#' @examples
version <- function(ver = NULL, position = "top right") {
  if (exists("VERSION", envir = parent.frame()))
    ver <- get("VERSION", envir = parent.frame())
  display(ver, position)
}
