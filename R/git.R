#' Git information
#' 
#' Displays git information from the repository
#' 
#' @import git2r
#' @import shiny
#' @export
git_info <- function() {
  print(getwd())
  repo <- init(path = ".", bare = FALSE)
  branch <- repository_head(repo)[[1]]
  if (is.null(branch)) {
    git_message <- "Empty repo."
  } else {
    last_commit <- as.character(commits(repo)[[1]])[[4]]
    git_message <- span(paste("Branch:", branch),
                        br(),
                        paste("Last commit: ", last_commit)
                       )
  }
  display(git_message)
}
