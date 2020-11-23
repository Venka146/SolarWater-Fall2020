source("./Functions/energyCons.R")

gen_energy_vals <- function(scNum, scPower, sim_length, sim_volume) {
  #energy_gen = as.double(scNum) * as.double(scPower)
  # Calculate how much energy is produced
  energy_gen <- scNum * scPower 
  #Create a vector with times from 0:time
  time = sim_length
  timeVals <- c(0:time) 
  energyVals <- c()
  # Amount of energy consumed per hour
  energy_drain <- energy_cons(sim_volume)
  
  energy_drain = energy_drain/time

  # creating a vector to store energy reserves per hour
  for(i in (timeVals + 1)) {
    output_energy = energy_gen * (rnorm(1, 0, 1)/5+.9) - energy_drain
    if(i < 1) {
      energyVals[0] <- 0
    }
    else if (i < 2) {
      energyVals[i] <- output_energy
    }
    else {
      energyVals[i] <- (energyVals[i-1] + output_energy)
    }
  }
  # Combining the two vectors to form a dataframe
  data = data.frame(timeVals, energyVals)
  return (data)
}
