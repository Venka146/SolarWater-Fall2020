source("./Functions/genEnergyVals.R")

max_water_prod <- function(scNum, scPower, sim_length, sim_volume) {
  data <- gen_energy_vals(scNum, scPower, sim_length, sim_volume)
  return (data)
}