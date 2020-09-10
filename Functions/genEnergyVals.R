gen_energy_vals <- function(scNum, scPower, sim_length) {
  energy_gen <- scNum * scPower
  timeVals <- c(0:sim_length)
  energyVals <- c()
  energy_cons = 10
  for(i in (timeVals + 1)) {
  
    output_energy = energy_gen * (rnorm(1, 0, 1)/5+.9) - energy_cons
    energyVals[i] <- c(output_energy)
  
  }
  
  data = data.frame(timeVals, energyVals)
  return(data)
}
