#' Calculates BMI prime
#'
#' @param height Height in meters.
#' @param weight Weight in kilograms.
#' @param bmi Measured bmi as an alternative to supplying weight and height.
#' @param continent Continent that is to be used for normalisation.
#' @param upper_limit Alternative upper limit for specific country or state.
#'
#' @returns A numerical value
#' @export
#'
#' @examples
#' calculate_bmi_prime(height=1.80, weight=80, continent="Africa")
#' calculate_bmi_prime(bmi=22.9, continent="North_America")
#' calculate_bmi_prime(bmi=22.9, upper_limit=24.9)
calculate_bmi_prime <- function(height = NULL, weight = NULL,
                                bmi = NULL, continent = NULL,
                                upper_limit = NULL) {
  # --- Continent lookup table ---
  continents_table <- dplyr::tibble(
    continentlist = c("Asia", "Europe", "North_America", "South_America", "Africa", "Oceania"),
    upper_limit    = c(22.9, 24.9, 24.9, 24.9, 24.9, 25.0)
  )
  # --- Antarctica early exit ---
  if (!is.null(continent) && continent == "Antarctica") {
    stop("No BMI data available for Antarctica. Please provide a different continent or supply an upper_limit instead.")
  }
  # --- Resolve upper_limit ---
  if (!is.null(upper_limit)) {
    if (!is.numeric(upper_limit)) stop("'upper_limit' must be numeric.")
    if (upper_limit <= 0)         stop("'upper_limit' must be a positive number.")
    limit <- upper_limit
  } else if (!is.null(continent)) {
    if (!is.character(continent)) stop("'continent' must be a string.")
    matched <- continents_table[continents_table$continentlist == continent, "upper_limit"]
    if (nrow(matched) == 0) stop("Continent not found. Valid options: Asia, Europe, North_America, South_America, Africa, Oceania.")
    limit <- matched$upper_limit
  } else {
    stop("Please provide either a 'continent' or an 'upper_limit'.")
  }
  # --- Resolve BMI ---
  if (!is.null(bmi)) {
    if (!is.numeric(bmi)) stop("'bmi' must be numeric.")
    if (bmi <= 0)         stop("'bmi' must be a positive number.")
    bmi_value <- bmi
  } else if (!is.null(height) && !is.null(weight)) {
    bmi_value <- calculate_bmi(weight = weight, height = height)
  } else {
    stop("Please provide either 'bmi' or both 'height' (cm) and 'weight' (kg).")
  }
  # --- Calculate BMI Prime ---
  bmi_prime <- bmi_value / limit
  return(bmi_prime)
}
