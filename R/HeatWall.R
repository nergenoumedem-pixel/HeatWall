#' HeatWall: Simulation of Temperature in a Multi-Layer Wall
#'
#' **HeatWall** is an R package that simulates the temperature evolution
#' inside a wall composed of multiple materials. It uses the heat equation
#' to compute the indoor temperature based on material properties and
#' external conditions.
#'
#' ## Main Features
#' - `simulate_wall_temp()`: simulates indoor temperature of a multi-layer wall.
#' - Allows defining multiple materials and layers.
#' - Analyze thermal efficiency of materials for wall design.
#' - Returns results as a data.frame with time and temperature.
#'
#' ## Installation
#' To install the development version from GitHub:
#' ```r
#' if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
#' devtools::install_github("nergenoumedem-pixel/HeatWall")
#' ```
#'
#' ## Example
#' ```r
#' library(HeatWall)
#' concrete_data <- data.frame(
#'   material = "Concrete",
#'   thickness_m = 0.20,
#'   conductivity_w_mk = 1.0,
#'   density_kg_m3 = 2400,
#'   specific_heat_j_kgk = 880
#' )
#' results <- simulate_wall_temp(
#'   materials = concrete_data,
#'   initial_temp_in = 25,
#'   external_temp = 35,
#'   total_time = 24,
#'   dt = 0.01,
#'   dx = 0.01
#' )
#' plot(results$Time, results$InternalTemp, type = "l")
#' ```
#'
#' @docType package
#' @name HeatWall
#' @author Noumedem
#' @references <https://github.com/nergenoumedem-pixel/HeatWall>
#' @keywords package
NULL
