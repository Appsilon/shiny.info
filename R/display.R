#' Display message on the top-right corner
#'
#' @param message character with any message you want
#' @param position character with position of the parameter. Default "top right".
#' @param type character with display type to specify the id. Default to "message"
#'
#' @return div which wraps your message to display it in the {position} corner of your shiny app.
#' @export
#' @import glue
display <- function(message, position = "top right", type = "message") {
  allowed_positions <- c("top right", "top left", "bottom right", "bottom left")
  if (!position %in% allowed_positions)
    stop("Position argument not allowed.")
  fixed_layout <- "fixed"
  # when called from inside infoPanel function position arguments are supposed to be overwritten
  # and css position should be empty
  plausible_info_panel_call <- tryCatch(sys.call(-8), error = function(e) "")
  is_called_in_info_panel <- isTRUE(any(grepl("infoPanel|info_panel", plausible_info_panel_call)))
  if (is_called_in_info_panel) {
    fixed_layout <- ""
  }
  splitted_position <- unlist(strsplit(position, " "))
  position_vertical <- splitted_position[1] #nolint
  position_horizontal <- splitted_position[2] #nolint
  type_id <- paste0("shinyinfo_", type)
  tagList( #nolint
    tags$head(
      tags$style(
        HTML(
          "
          .info_box {
            width: auto;
            height: auto;
            color: #000000;
            background-color: #f5f5f5;
            padding: 3px 8px;
            font-size: 12px;
            z-index : 9999;
          }
          ",
          glue::glue(
            "
            #{type_id} {{
              position: {fixed_layout};
              {position_vertical}: 0;
              {position_horizontal}: 0;
            }}
            ")
          )
      )
    ),
    div(id = type_id, class = "info_box", message)
  )
}


#' Powered by
#'
#' Displays information about authors of the shiny app.
#'
#' @param company_name character with the creator of the app
#' @param link link to the creator's website
#' @param position character with position of the parameter. Default "top right".
#'
#' @return div with "powered by".
#' @export
#' @importFrom shiny a p
powered_by <- function(company_name, link = "#", position = "top right") {
  display(p(style = "margin: 0;", "Powered by ",
            a(href = link, target = "_blank", company_name)),
          position,
          type = "powered_by")
}


#' Auxiliary function that returns list of arguments for parent calling function
#'
#' @param fun string; for what function to look for
#' @param depth negative numeric; how layers above to check the arguments
#'
#' @return list of function arguments
get_args <- function(fun, depth = -9) {
  cl <- sys.call(depth)
  cl <- match.call(definition = eval(parse(text = fun)), call = cl)
  as.list(cl)[-1]
}
