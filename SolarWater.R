library(shinythemes)
library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
source("./Functions/energyGraph.R")
source("./Functions/genEnergyVals.R")

ui <- fluidPage(
  # Background color/image
  #theme = shinytheme("yeti"),
  setBackgroundImage(src = "xp.jpg"),
  #setBackgroundColor(
   # color = c("orange", "red"),
   #  gradient = "linear",
    #direction = "top",
    #shinydashboard = FALSE),
  # Title of webpage
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
    numericInput(inputId = "scNum", label = "Enter number of solar cells: ", value = 4, min = 0, step = 1),
    numericInput(inputId = "scPower", label = "Enter solar cell voltage (V): ", value = 5, min = 0),
    
    tags$p(""),
    numericInput(inputId = "temp", label = "Temperature (°C): ", value = 25, step = 1, min = 0, max = 50),
    numericInput(inputId = "filterEnergy", label = "Filter Energy Consumption: ", value = 5, min = 0, max = 100),
    numericInput(inputId = "time", label = "Enter simulation length (hr): ", value = 5, min = 0, max = 24, step = 1),
  
    # "start" button
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
        tags$h2(strong("Simulation Graph"), align = 'center'
                ),
      wellPanel(
          # addition of concentration or other plot
          plotOutput("dispPlot") %>% withSpinner(color = "#000000")
        ),
      # Slider to interact with graphs
    sliderInput(inputId = "timePoint", label = "Select graph time point", value = 4, min = 0, max = 24)
      )
   
    )
  )
  )
)

server <- function(input, output, session) {
  #graph prep work 
  sim_temp <- eventReactive(input$start, input$temp)
  sim_num <- eventReactive(input$start, input$scNum)
  sim_power <- eventReactive(input$start, input$scPower)
  sim_time <- eventReactive(input$start, input$time)
  
  data <- eventReactive(input$start, gen_energy_vals(sim_num(), sim_power(), sim_time()))
  
  # Displaying the graph
  output$dispPlot <- renderPlot(
    energyGraph(data(), sim_temp())
  )
}

shinyApp(ui=ui, server = server)
