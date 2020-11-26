library(shinythemes)
library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
source("./Functions/energyGraph.R")
source("./Functions/genEnergyVals.R")

ui <- fluidPage(
  # Background color/image
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
    
    tags$hr(),
    #energy related inputs for user customization
    tags$h3(tags$strong("Energy Specifications")),
    wellPanel(
      numericInput(inputId = "scNum", label = "Enter number of solar cells: ", value = 4, min = 0, step = 1),
      numericInput(inputId = "scPower", label = "Enter solar cell voltage (V): ", value = 5, min = 0),
      numericInput(inputId = "temp", label = "Temperature (°C): ", value = 25, step = 1, min = 0, max = 50),
      numericInput(inputId = "time", label = "Enter simulation length (hr): ", value = 5, min = 0, max = 24, step = 1),
    ),
    #water related inputs for user customization
    tags$h3(tags$strong("Water Specifications")),
    wellPanel(
      numericInput(inputId = "volume", label = "Enter input volume (L): ", value = 10, min = 0),
    ),
    # "start" button
    tags$div(
      actionBttn(inputId = "start",
                 label = "Generate Simulation",
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
      #Drop down menu to select graphs
      selectInput(inputId = "graphSelect", label = "Select graph to view: ", 
                  c("Energy Reserves" = "eRes",
                    "Water Production" = "wProd"),
                  width = '17%',
                  selected = "eRes"),
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
  sim_volume <- eventReactive(input$start, input$volume)
  
  edata <- eventReactive(input$start, gen_energy_vals(sim_num(), sim_power(), 
                                                     sim_time(), sim_volume()))
  
  wdata <- eventReactive(input$start, gen_energy_vals(sim_num(), sim_power(), 
                                                      sim_time(), sim_volume()))
  
  
  # Displaying the graph
  graphType = reactive({
    
    if (graphType() == "eRes") {
      graphType <- energyGraph(edata(), sim_temp())
    } else {
      graphType <- waterProdGraph(wdata())
    }
  })
  
  output$dispPlot <- (
    renderPlot(graphType())
                       )
  
}

shinyApp(ui=ui, server = server)
