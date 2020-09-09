library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
source("./Functions/energyGraph.R")

ui <- fluidPage(
  
  setBackgroundImage(src = "xp.jpg"),
  
  sidebarLayout(sidebarPanel(
    numericInput(inputId = "scNum", label = "Enter number of solar cells: ", value = 0, min = 0, step = 1),
    numericInput(inputId = "scPower", label = "Enter solar cell voltage: ", value = 0, min = 0),
    numericInput(inputId = "Temp", label = "Temperature (°C): ", value = 25, step = 1, min = 0, max = 50),
    numericInput(inputId = "filterEnergy", label = "Filter Energy Consumption: ", value = 5, min = 0, max = 100),
    numericInput(inputId = "scTime", label = "Enter simulation length: ", value = 3, min = 0, max = 24, step = 1)
  ),
  
  mainPanel(
    sliderInput(inputId = "timePoint", label = "Select graph time point", value = 4, min = 0, max = 24),
  )
  )
)

server <- function(input, output) {}

shinyApp(ui=ui, server = server)
