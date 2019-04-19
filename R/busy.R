#' Busy or not
#' 
#' Displays a spinner indicating if there are any calculations running on the server side.
#'
#' @return shiny tag List with js script, style of spinner and display div
#' @export
busy <- function() {
  shiny::tagList(
    tags$script(
      'function checkifrunning() {
      var is_running = $("html").attr("class").includes("shiny-busy");
      if (is_running){
      $("#loading").show()
      } else {
      $("#loading").hide()
      }
}; 
      setInterval(checkifrunning, 50)'
    ), 
    tags$style(
      " body { text-align:center; }
      
      #loading {
      display: inline-block;
      border: 3px solid #f3f3f3; 
      border-top: 3px solid #3498db; 
      border-radius: 50%;
      width: 30px;
      height: 30px;
      animation: spin 1s ease-in-out infinite;
      }
      
      @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
      }"
    ),
    display(
      tags$div(id = "loading",
             tags$script('$("#loading").hide()'))
    )
    )
}