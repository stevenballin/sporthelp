#' Calculates BMI Prime
#'
#' @param weight Weight of person
#' @param height Height of person
#' @param weight_unit The unit of weight parameter. Must be either 'kg' or 'lbs'.
#' @param height_unit The unit of the height parameter. Must be any of: 'cm', 'm', 'in' or 'ft'.
#' @param bmi BMI value. If provided, height and weight are not required.
#' @param continent Continent of person. Must be one of: 'Asia', 'Europe', 'North_America', 'South_America', 'Africa', 'Oceania'.
#' @param upper_limit Upper limit of BMI for the person's region. If provided, continent is not required.
#'
#' @returns A numerical value
#' @export
#'
#' @examples
#' calculate_bmi_prime(bmi = 25, continent = "Europe")
#' calculate_bmi_prime(weight = 80, height = 180, continent = "Asia")
#' calculate_bmi_prime(bmi = 25, upper_limit = 25)
calculate_bmi_prime <- function(weight = NULL, height = NULL,
                                weight_unit = "kg", height_unit = "cm",
                                bmi = NULL, continent = NULL,
                                upper_limit = NULL) {
  # --- Continent lookup table ---
  continents_table <- dplyr::tibble(
    continentlist = c("Asia", "Europe", "North_America", "South_America", "Africa", "Oceania"),
    upper_limit   = c(22.9, 24.9, 24.9, 24.9, 24.9, 25.0)
  )
  # --- Antarctica early exit ---
  if (!is.null(continent) && continent == "Antarctica") {
    stop("No BMI data available for Antarctica. Please provide a different continent or supply an upper_limit instead.")
  }
  # --- Resolve upper_limit ---
  if (!is.null(upper_limit)) {
    if (!is.numeric(upper_limit))  stop("'upper_limit' must be numeric.")
    if (upper_limit <= 0)          stop("'upper_limit' must be a positive number.")
    limit <- upper_limit
  } else if (!is.null(continent)) {
    if (!is.character(continent))  stop("'continent' must be a string.")
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
    bmi_value <- calculate_bmi(weight = weight, height = height,
                               weight_unit = weight_unit, height_unit = height_unit)
  } else {
    stop("Please provide either 'bmi' or both 'height' (cm) and 'weight' (kg).")
  }
  # --- Calculate BMI Prime ---
  bmi_prime <- bmi_value / limit
  return(bmi_prime)
}
