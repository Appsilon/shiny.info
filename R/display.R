#' Display message on the top-right corner
#'
#' @param message character with any message you want
#'
#' @return div which wraps your message to display it in the top-right corner of your shiny app.
#' @export
display <- function(message) {
  tagList(
    tags$head(
      tags$style(
        HTML("
        #shinyinfo {
        position: absolute;
        top: 0;
        right: 0;
        width: auto;
        height: auto;
        color: #000000;
        background-color: #f5f5f5;
        padding: 3px 8px;
        font-size: 12px;
        z-index = 9999;
        }
        #shinyinfo a {
        color: #0099f9;
        }
        ")
      )
    ),
    div(id = "shinyinfo", message)
  )
}


#' Powered by
#' 
#' Displays information about authors of the shiny app.
#'
#' @param company_name character with the creator of the app
#' @param link link to the creator's website
#'
#' @return div with "powered by".
#' @export
#' @importFrom shiny a p
powered_by <- function(company_name, link="#") {
  display(p("Powered by ", a(href = link, target="_blank", company_name)))
}