library(shiny)
library(shiny.info)

# to show info press Ctrl+Shift+K

VERSION = "1.2.2"

shinyApp(
  ui = tagList(
    shiny.info::info_panel(
      shiny.info::git_info(),
      shiny.info::powered_by("Appsilon", link = "appsilon.com"),
      position = "bottom left"
    ),
    shiny.info::version(position = "top right"),
    shiny.info::info_value("test_info_value", position = "bottom right"),
    shiny.info::toggle_info(),
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
        plotOutput('plot1'), plotOutput('plot2'), plotOutput('plot3')
      )
    )
  ),
  server = function(input, output, session) {
    
    #info value
    output$test_info_value <- render_info_value(input$xcol)
    outputOptions(output, "test_info_value", suspendWhenHidden = FALSE)
    # Combine the selected variables into a new data frame
    selectedData <- reactive({
      iris[, c(input$xcol, input$ycol)]
    })

    clusters <- reactive({
      Sys.sleep(1.5)
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

    output$plot2 <- renderPlot({
      palette(c("#E41A1C", "green", "#4DAF4A", "#984EA3",
                "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

      par(mar = c(5.1, 4.1, 0, 1))
      plot(selectedData(),
           col = clusters()$cluster,
           pch = 20, cex = 3)
      points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })

    output$plot3 <- renderPlot({
      palette(c("red", "#377EB8", "#4DAF4A", "#984EA3",
                "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

      par(mar = c(5.1, 4.1, 0, 1))
      plot(selectedData(),
           col = clusters()$cluster,
           pch = 20, cex = 3)
      points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })

  }
)
