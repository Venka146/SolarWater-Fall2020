library(tidyverse)

energyGraph <- function(data, temp){
  eGraph <- ggplot(data = data) +
    geom_line(mapping = aes(x = timeVals, y = energyVals), color = "blue", size = 1.25) +
    labs(title = "Energy Reserves", subtitle = paste("Temperature: ", temp, "(°C)"),
      x = "Time (hours)",
      y = "Energy (W)")
  return (eGraph)
}


