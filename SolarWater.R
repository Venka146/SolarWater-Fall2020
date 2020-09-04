library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
# hello
#hi bro
ui <- fluidPage(
  
  setBackgroundImage(src = "poop.jpeg"),
  
  sidebarLayout(sidebarPanel(
    numericInput(inputId = "scNum", label = "Enter number of solar cells: ", value = 0, min = 0, step = 1),
    numericInput(inputId = "scPower", label = "Enter solar cell voltage: ", value = 0, min = 0),
    numericInput(inputId = "Temp", label = "Temperature (°C): ", value = 25, step = 1, min = 0, max = 50)
  ),
  
  mainPanel(
    
  )
  )
)

server <- function(input, output) {}

shinyApp(ui=ui, server = server)
