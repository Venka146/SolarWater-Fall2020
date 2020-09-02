library(shiny)

ui <- fluidPage(sliderInput(inputId = "num", label = "Choose a number", value = 25, min = 0, max = 50),
                plotOutput(outputId = "hist"))

server <- function(input, output) {
  output$hist <- renderPlot({
    title <- "100 random norms"
    hist(rnorm(input$num), main = title)
  })
}

shinyApp(ui = ui, server = server)