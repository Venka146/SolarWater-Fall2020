library(shinythemes)
library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
source("./Functions/energyGraph.R")

ui <- fluidPage(
  #theme = shinytheme("yeti"),
  setBackgroundImage(src = "xp.jpg"),
  setBackgroundColor(
    color = c("orange", "red"),
     gradient = "linear",
    direction = "top",
    shinydashboard = FALSE),
  wellPanel(h1(
    strong("Solar Energy Simulation Module"),
    align = 'center'
  )),
  
  sidebarLayout(sidebarPanel(
    #title of sidebar
    tags$h2(tags$strong("Enter Initial Conditions"), align = 'center'),
    #horizontal line 
    tags$hr(),
    
    numericInput(inputId = "scNum", label = "Enter number of solar cells: ", value = 1, min = 0, step = 1),
    numericInput(inputId = "scPower", label = "Enter solar cell voltage (V): ", value = 1, min = 0),
    
    tags$p(""),
    numericInput(inputId = "temp", label = "Temperature (°C): ", value = 25, step = 1, min = 0, max = 50),
    numericInput(inputId = "filterEnergy", label = "Filter Energy Consumption: ", value = 5, min = 0, max = 100),
    numericInput(inputId = "time", label = "Enter simulation length (hr): ", value = 3, min = 0, max = 24, step = 1),
  
    # "go" button
    tags$div(
      actionBttn(inputId = "start",
                 label = "Generate Energy Simulation",
                 style = "jelly",
                 color = "primary",
                 size = "md"
      ),
      align = 'center'
    )
  ),
  
  mainPanel(
    conditionalPanel(
      # only shows results stuff once go button has been clicked
      condition = "input.start != 0",
      #Title of main panel
      wellPanel(
        tags$h2(strong("Infographic Display"), align = 'center'
                ),
    sliderInput(inputId = "timePoint", label = "Select graph time point", value = 4, min = 0, max = 24)
      ),
    wellPanel(
      # addition of concentration or other plot
      plotOutput("dispPlot") %>% withSpinner(color = "#000000")
    )
    )
  )
  )
)

server <- function(input, output, session) {
  #### Initial Reactants Calculation ####
  sim_temp <- eventReactive(input$start,input$temp)
  sim_length <- eventReactive(input$start, input$time)
  hours <- c(1, 2, 3, 4, 5)
  energy <- c(4, 5, 3, 2, 1)
  data <-as.data.frame(cbind(hours, energy))
  
  output$dispPlot <- renderPlot(
    energyGraph(data, sim_temp, sim_length)
  )
}

shinyApp(ui=ui, server = server)
