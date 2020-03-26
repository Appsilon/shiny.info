#' CSS/HTML code for a spinner loader
.loader_spinner <-  list()
.loader_spinner$css <- "
#spinner {
display: inline-block;
border: 3px solid #f3f3f3;
border-top: 3px solid #3498db;
border-radius: 50%;
width: 40px;
height: 40px;
animation: spin 1s ease-in-out infinite;
}

@keyframes spin {
0% { transform: rotate(0deg); }
100% { transform: rotate(360deg); }
}"
.loader_spinner$html <- tags$div(id = "spinner")

#' CSS/HTML code for a dots loader
.loader_dots <-  list()
.loader_dots$css <- "
.lds-ellipsis {
display: inline-block;
position: relative;
width: 40px;
height: 40px;
}
.lds-ellipsis div {
position: absolute;
top: 5px;
width: 8px;
height: 8px;
border-radius: 50%;
background: blue;
animation-timing-function: cubic-bezier(0, 1, 1, 0);
}
.lds-ellipsis div:nth-child(1) {
left: 6px;
animation: lds-ellipsis1 0.6s infinite;
}
.lds-ellipsis div:nth-child(2) {
left: 6px;
animation: lds-ellipsis2 0.6s infinite;
}
.lds-ellipsis div:nth-child(3) {
left: 26px;
animation: lds-ellipsis2 0.6s infinite;
}
.lds-ellipsis div:nth-child(4) {
left: 45px;
animation: lds-ellipsis3 0.6s infinite;
}
@keyframes lds-ellipsis1 {
0% {
transform: scale(0);
}
100% {
transform: scale(1);
}
}
@keyframes lds-ellipsis3 {
0% {
transform: scale(1);
}
100% {
transform: scale(0);
}
}
@keyframes lds-ellipsis2 {
0% {
transform: translate(0, 0);
}
100% {
transform: translate(19px, 0);
}
}
"
.loader_dots$html <- tags$div(class = "lds-ellipsis",
                              tags$div(), tags$div(), tags$div(), tags$div()
                              )

#' Busy or not
#'
#' Displays a spinner indicating if there are any calculations running on the server side.
#'
#' Currently available loaders: "dots", "spinner".
#'
#' Solution inspired by: \url{https://colinfay.me/watch-r-shiny/}.
#'
#' @param loader character or list. If character given, then it selects from one of a few
#' available loaders (look Details for more). By using list you can create your custom loder.
#' List needs to have structure \code{loader <- list(css<-"CSS CODE", html <- div("CODE TO DISPLAY"))}.
#' @param position character with position of the parameter. Default "top right".
#'
#' @return shiny tag List with js script, style of spinner and display div
#' @import shiny
#' @export
busy <- function(loader = "dots", position = "top right") {
  if (class(loader) == "character")
    loader <- eval(parse(text = paste0(".loader_", loader)))
  shiny::tagList(
    tags$script(
      'function checkifrunning() {
        var is_running = $("html").attr("class").includes("shiny-busy");
        if (is_running) {
         $("#loading").show()
        } else {
         $("#loading").hide()
        }
      };
      setInterval(checkifrunning, 50)'
    ),
    tags$style(
      loader$css
    ),
    display(
      tags$div(id = "loading",
            tags$span(tags$h4("Busy...")),
            loader$html,
            tags$script('$("#loading").hide()')
      ),
      position,
      type = "busy"
    )
  )
}
