#' Git information
#' 
#' Displays git information from the repository of the current working space.
#' 
#' @import git2r
#' @import shiny
#' @import glue
#' @export
git_info <- function() {
  repo <- tryCatch({
            repository(".")
          }, error = function(e) {
             NULL
          })
  if (is.null(repo)) {
    git_message <- "It looks like you're not in a valid git repo."
  } else {
    branch <- repository_head(repo)[[1]]
    if (is.null(branch)) {
      git_message <- "Empty repo."
    } else {
      last_commit <- as.character(commits(repo)[[1]]$message)
      stat <- status(repo)
      changes <- ""
      if (length(stat$unstaged$modified) + length(stat$staged$modified) > 0)
        changes <- HTML("<font color='red'>(!) Not commited changes</b></font>")
      git_message <- span(HTML(glue("Branch: <b>{branch}</b> </br>")),
                          HTML(glue("Last commit: <b>{last_commit}</b></br>")),
                          changes
                      )
    }
  }
  display(git_message)
}