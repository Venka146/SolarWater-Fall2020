library(shinythemes)
library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
source("./Functions/energyGraph.R")
source("./Functions/genEnergyVals.R")

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
    #inputs for user customization
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
  #graph set up 
  sim_temp <- observeEvent(input$start, {as.numeric(input$temp)})
  sim_num <- observeEvent(input$start, {as.numeric(input$scNum)})
  sim_power <- observeEvent(input$start, {as.numeric(input$scPower)})
  sim_time <- observeEvent(input$start, {as.numeric(input$time)})
  
  data <- observeEvent(input$start, gen_energy_vals(sim_num, sim_power, sim_time))
  
  output$dispPlot <- renderPlot(
    energyGraph(data, sim_temp)
  )
}

shinyApp(ui=ui, server = server)
