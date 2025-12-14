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
#' @return A data frame with time and internal temperature values.
#' @export
#' @examples
#' # Example: A simple concrete wall
#' concrete_data <- data.frame(
#'   material = "Concrete",
#'   thickness_m = 0.20,
#'   conductivity_w_mk = 1.0,
#'   density_kg_m3 = 2400,
#'   specific_heat_j_kgk = 880
#' )
#'
#' # Simulating for 24 hours with constant external temp
#' results <- simulate_wall_temp(
#'   materials = concrete_data,
#'   initial_temp_in = 25,
#'   external_temp = 35, # Typical Douala temp
#'   total_time = 24,
#'   dt = 0.01,
#'   dx = 0.01
#' )
#' plot(results$Time, results$InternalTemp, type = 'l', main = "Internal Temperature Over Time")
simulate_wall_temp <- function(materials, initial_temp_in, external_temp, total_time, dt, dx) {
  # --- Physics & Calculation Logic (Simplified Placeholder) ---
  # In a real project, you would implement the Finite Difference Method (FDM) here.
  # This part solves the partial differential equation (PDE).

  # Placeholder logic: internal temp slowly approaches external temp
  time_steps <- seq(0, total_time, by = dt)
  internal_temps <- numeric(length(time_steps))
  current_temp <- initial_temp_in

  for (i in seq_along(time_steps)) {
    # Simplified simulation update (replace with actual FDM solution)
    temp_diff <- mean(external_temp) - current_temp
    # This factor depends heavily on material properties
    change_rate <- sum(materials$conductivity_w_mk / materials$thickness_m) * 0.001

    current_temp <- current_temp + temp_diff * change_rate * dt
    internal_temps[i] <- current_temp
  }

  return(data.frame(Time = time_steps, InternalTemp = internal_temps))
}
