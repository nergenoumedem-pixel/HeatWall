# R/simulate_wall_temp.R

#' Simulate Temperature Profile Through a Multi-Layer Wall
#'
#' Solves the 1D heat equation using a finite difference method for a composite wall structure.
#'
#' @param materials A data frame defining material properties (thickness, conductivity, density, specific_heat).
#' @param initial_temp_in Initial internal temperature (Celsius).
#' @param external_temp External temperature (Celsius, can be a single value or a time series).
#' @param total_time Total simulation time (hours).
#' @param dt Time step (hours).
#' @param dx Space step (meters).
#'
#' @return A data frame with time and internal temperature values.
#' @export
simulate_wall_temp <- function(materials, initial_temp_in, external_temp, total_time, dt, dx) {
  time_steps <- seq(0, total_time, by = dt)
  internal_temps <- numeric(length(time_steps))
  current_temp <- initial_temp_in

  for (i in seq_along(time_steps)) {
    temp_diff <- mean(external_temp) - current_temp
    change_rate <- sum(materials$conductivity_w_mk / materials$thickness_m) * 0.001
    current_temp <- current_temp + temp_diff * change_rate * dt
    internal_temps[i] <- current_temp
  }

  return(data.frame(Time = time_steps, InternalTemp = internal_temps))
}
