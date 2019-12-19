.key_condition <- function(key, to_lower = TRUE) {
  switch(
    key,
    Alt = "e.altKey == true",
    Ctrl = "e.ctrlKey == true",
    Shift = "e.shiftKey == true",
    glue("e.key == '{ifelse(to_lower,tolower(key),key)}'")
  )
}

.shortcut_condition <- function(shortcut) {
  shortcut <- unlist(strsplit(shortcut, "+", fixed = TRUE))
  
  if ("Shift" %in% shortcut) {
    to_lower <- FALSE
  } else {
    to_lower <- TRUE
  }
  
  condition <- lapply(shortcut, .key_condition, to_lower = to_lower)
  do.call(paste, c(condition, sep = " && "))
}

toggle_info <- function(shortcut = 'Ctrl+Shift+K') {
  shortcut_condition <- .shortcut_condition(shortcut)
  
  js <- glue::glue("
  $(document).ready(
    function() {{
      $('div.info_box').hide();
    }}
  );

  $(document).on('keydown', function(e) {{
    if({shortcut_condition}) {{
      $('div.info_box').toggle();
    }}
  }});")

  tags$script(HTML(js))
}
