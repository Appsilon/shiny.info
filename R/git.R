#' Git information
#' 
#' Displays git information from the repository of the current working space.
#' 
#' @import git2r
#' @import shiny
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
      changes <- ""
      if (length(stat$unstaged$modified) + length(stat$staged$modified) > 0)
        changes <- "(!) Repo has some not commited changes"
      git_message <- span(paste("Branch:", branch),
                          br(),
                          paste("Last commit: ", last_commit),
                          br(), changes
                      )
    }
  }
  display(git_message)
}
