library(tidyverse)

energyGraph <- function(data, temp, time){
  eGraph <- ggplot(data = data, aes(x = time, y = energy, color = "blue") +
    geom_line(size = 1.25) +
      labs(title = "Energy Reserves") +
      xlab("Time (hours)") +
      ylab("Energy (V)"))
  return (eGraph)
}

