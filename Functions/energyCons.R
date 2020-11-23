energy_cons <- function(volume) {
  # Vol (L) multiplied by specific heat for water temp change from 25 to 65 C
  # cons [=] W*h  
  cons = volume*45.64
  return (cons)
}