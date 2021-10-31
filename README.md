<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/shiny.info)](https://cran.r-project.org/package=shiny.info)
[![R build
status](https://github.com/Appsilon/shiny.info/workflows/R-CMD-check/badge.svg)](https://github.com/Appsilon/shiny.info/actions?workflow=R-CMD-check)
[![Codecov test
coverage](https://codecov.io/gh/Appsilon/shiny.info/branch/master/graph/badge.svg)](https://codecov.io/gh/Appsilon/shiny.info?branch=master)
<!-- badges: end -->

<a href = "https://appsilon.com/careers/" target="_blank"><img src="http://d2v95fjda94ghc.cloudfront.net/hiring.png" alt="We are hiring!"/></a>

# shiny.info

Display simple information of the [shiny](https://shiny.rstudio.com/)
project in the user interface of the app.

<a href='https://github.com/Appsilon/shiny.info'><img src='inst/assets/README_files/logo.png' align="right" height="150" /></a>

## How to install shiny.info?

You can install shiny.info from CRAN repository:

    install.packages("shiny.info")

You can get the most recent version from this repo using
[devtools](https://github.com/hadley/devtools).

    devtools::install_github("Appsilon/shiny.info")

## How to use shiny.info?

Just add one of the `shiny.info` functions to the UI of your app (some
features require also adding a little bit of code to the server
function). Check [features section](#basic-features) and
[documentation](https://cran.r-project.org/web/packages/shiny.info/shiny.info.pdf)
for more details.

<h3><a href="https://demo.appsilon.ai/apps/shiny_info_demo/">See live demo.</a></h3>

An example of a shiny app that uses `shiny.info` can be found in
`./examples` directory.

![](inst/assets/README_files/example.gif)

## Basic features

  - display a simple text message:
    
        shiny.info::display("Hello user!", position = "top right")
    
    ![](inst/assets/README_files/display.png)

  - show information about git branch, commit and changes:
    
        shiny.info::git_info()
    
    ![](inst/assets/README_files/git.png)

  - add “powered by” information with link:
    
        shiny.info::powered_by("Appsilon", link = "appsilon.com")
    
    ![](inst/assets/README_files/powered.png)

  - show app version:
    
        # global variable:
        VERSION <- "1.2.2"
        
        # in app ui
        shiny.info::version()
    
    ![](inst/assets/README_files/version.png)

  - show a busy spinner when app is calculating:
    
        shiny.info::busy()
    
    ![](inst/assets/README_files/busy.gif)

  - group multiple messages in one panel:
    
        shiny.info::info_panel(
            shiny.info::git_info(),
            shiny.info::powered_by("Appsilon", link = "appsilon.com"),
            position = "bottom left"
          )
    
    ![](inst/assets/README_files/panel.png)

## Advanced features

  - render value (eg. input, reactive value) from the server:
    
        # in app ui
        shiny.info::info_value("test_info_value")
        
        # in app server
        some_value <- reactiveVal("a test value to display")
        output$test_info_value <- shiny.info::render_info_value(some_value())
    
    ![](inst/assets/README_files/info_value.png)

  - render information about the session:
    
        # in app ui
        shiny.info::info_value("session_info_value")
        
        # in app server
        output$session_info_value <- shiny.info::render_session_info()
    
    ![](inst/assets/README_files/session.png)

  - debug app using `browser()` function just by clicking a button:
    
        # in app ui
        shiny.info::inspect_btn_ui()
        
        # in app server
        shiny.info::inspect_btn_server(input)
    
    ![](inst/assets/README_files/inspect_button.png)

  - toggle display with a key shortcut:
    
        shiny.info::toggle_info("Ctrl+Shift+K")
    
    ![](inst/assets/README_files/shortcut.gif)
    
  - show custom message using global variables:
    
        # in app global
        VERSION = "1.2.2"
        REPO = git2r::repository_head(repository("."))[[1]]
        GIT_COMMIT_MESSAGE = git2r::commits(repository("."))[[1]]$message
        GIT_COMMIT_HASH = git2r::commits(repository("."))[[1]]$sha
        
        # in app ui
        shiny.info::display(
            message = glue("I am running on repository {REPO} 
            from [{GIT_COMMIT_HASH}]: {GIT_COMMIT_MESSAGE}, 
            and this is version: {VERSION}"), 
            position = "top right", 
            type = "custom_message"
            )
    
    ![](inst/assets/README_files/global_variables_custom_message.png)
    
  - show custom message using reactive variables:
    
    <!-- end list -->
    
        # in app ui
        shiny.info::info_value("test_info_value", position = "top right")
        
        # in app server
          a <- reactive({
            input$xcol
            rnorm(1,1)
          })
        
          output$test_info_value <- shiny.info::render_info_value(glue("a: {a()}, 
          X Variable: {input$xcol}"), add_name = FALSE)
    
    ![](inst/assets/README_files/reactive_variables_custom_message.png)

## How can I contribute?

If you want to contribute to this project please submit a regular PR
once you’re done with your new feature or bug fix.

**Changes in documentation**

Documentation is rendered with `pkgdown`. Just run `pkgdown::build_site()` after editing documentation or `README.md`.


is enough.

Appsilon
========

<img src="https://avatars0.githubusercontent.com/u/6096772" align="right" alt="" width="6%" />

Appsilon is the **Full Service Certified RStudio Partner**. Learn more
at [appsilon.com](https://appsilon.com). Get in touch `support+opensource@appsilon.com`.
