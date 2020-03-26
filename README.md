
<link href="http://fonts.googleapis.com/css?family=Maven+Pro:400,700|Inconsolata" rel="stylesheet" type="text/css">
<link href='docs/style.css' rel='stylesheet' type='text/css'>

# shiny.info <a href='https://github.com/Appsilon/shiny.info'><img src='inst/assets/README_files/logo.png' align="right" height="139" /></a>

<div class="subheader">

Display simple information of the ‘shiny’ project in the user interface
of the app.

</div>

</br>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/shiny.info)](https://cran.r-project.org/package=shiny.info)
[![R build
status](https://github.com/Appsilon/shiny.info/workflows/R-CMD-check/badge.svg)](https://github.com/Appsilon/shiny.info/actions?workflow=R-CMD-check)
[![Codecov test
coverage](https://codecov.io/gh/Appsilon/shiny.info/branch/master/graph/badge.svg)](https://codecov.io/gh/Appsilon/shiny.info?branch=master)
<!-- badges: end -->

<div class="section level2">

What can be displayed there?

  - App version
  - Code commit
  - Last data import date
  - … anything else you find useful for your development

## How to install?

You can install shiny.info from CRAN repository:

    install.packages("shiny.info")

The most recent version you can get from this repo using
[devtools](https://github.com/hadley/devtools).

    devtools::install_github("Appsilon/shiny.info")

### Example

Diagnostic info like app version can be displayed with function
`display()`: `shiny.info::display("My App Version")`. See top right
corner here:

![](inst/assets/README_files/example.png)

1.  Install `shiny.info`:
    `devtools::install_github("Appsilon/shiny.info")`
2.  Just run the code below:

<!-- end list -->

    library(shiny)
    shinyApp(
      ui = tagList(
        shiny.info::display("2.0.5"),
        pageWithSidebar(
          headerPanel('Iris k-means clustering'),
          sidebarPanel(
            selectInput('xcol', 'X Variable', names(iris)),
            selectInput('ycol', 'Y Variable', names(iris),
                        selected=names(iris)[[2]]),
            numericInput('clusters', 'Cluster count', 3,
                         min = 1, max = 9)
          ),
          mainPanel(
            plotOutput('plot1')
          )
        )
      ),
      server = function(input, output, session) {

        # Combine the selected variables into a new data frame
        selectedData <- reactive({
          iris[, c(input$xcol, input$ycol)]
        })

        clusters <- reactive({
          kmeans(selectedData(), input$clusters)
        })

        output$plot1 <- renderPlot({
          palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                    "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

          par(mar = c(5.1, 4.1, 0, 1))
          plot(selectedData(),
               col = clusters()$cluster,
               pch = 20, cex = 3)
          points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
        })

      }
    )

### Future work

  - Different UI styles, e.g. adjusted to Shiny Server Pro with
    authentication box.
  - Info box hidden by default, displayed on key press.
  - Diagnostic info about app idle/busy status.

</div>
