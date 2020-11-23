
waterGraph <- function(data) {
  wGraph <- ggplot(data = data) +
    geom_line(mapping = aes(x = timeVals, y = energyVals), color = "blue", size = 1.25) +
    labs(title = "Maximum Water Production", 
         x = "Time (hours)",
         y = "Volume (L)")
  return (wGraph)
}