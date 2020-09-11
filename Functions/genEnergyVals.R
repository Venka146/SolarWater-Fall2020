gen_energy_vals <- function(scNum, scPower, sim_length) {
  #energy_gen = as.double(scNum) * as.double(scPower)
  energy_gen <- scNum * scPower 
  time = sim_length
  timeVals <- c(0:time) 
  energyVals <- c()
  energy_cons = 10
  for(i in (timeVals + 1)) {
  
    output_energy = energy_gen * (rnorm(1, 0, 1)/5+.9) - energy_cons
    energyVals[i] <- output_energy
  
  }
  
  data = data.frame(timeVals, energyVals)
  return(data)
}
