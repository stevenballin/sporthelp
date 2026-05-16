#' Calculates Daily Calorie Intake
#'
#' @param weight Weight of person
#' @param height Height of person
#' @param weight_unit The unit of weight parameter. Must be either 'kg' or 'lbs'.
#' @param height_unit The unit of the height parameter. Must be any of: 'cm', 'm', 'in' or 'ft'.
#' @param bodyfat Body fat percentage as a decimal (e.g. 0.20 for 20%). Required when formula = "KMA".
#' @param age Age of person in years.
#' @param gender Gender of person. Must be either 'male' or 'female'.
#' @param activity Activity level. Must be one of: 'BMR', 'Sedentary', 'Light', 'Moderate', 'Active', 'Very Active', 'Extra Active'.
#' @param formula Formula to use for BMR calculation. Must be one of: 'MSJ', 'RHB', 'KMA'.
#'
#' @returns A numerical value
#' @export
#'
#' @examples
#' daily_calories(weight = 80, height = 180, age = 30, gender = "male")
#' daily_calories(weight = 160, height = 70, weight_unit = "lbs", height_unit = "in", age = 25, gender = "female", activity = "Active")
#' daily_calories(weight = 80, height = 180, age = 30, gender = "male", bodyfat = 0.20, formula = "KMA")
daily_calories <- function(weight = NULL, height = NULL,
                           weight_unit = "kg", height_unit = "cm",
                           bodyfat = NULL, age = NULL,
                           gender = NULL, activity = "Light",
                           formula = "MSJ") {
  # --- Activity lookup table ---
  activity_table <- dplyr::tibble(
    activitylist     = c("BMR", "Sedentary", "Light", "Moderate", "Active", "Very Active", "Extra Active"),
    activity_factors = c(1, 1.2, 1.375, 1.465, 1.55, 1.725, 1.90)
  )
  # --- Validate inputs exist ---
  if (is.null(weight))   stop("Please provide a 'weight'.")
  if (is.null(height))   stop("Please provide a 'height'.")
  if (is.null(age))      stop("Please provide an 'age'.")
  if (is.null(gender))   stop("Please provide a 'gender'.")
  # --- Validate inputs are numeric ---
  if (!is.numeric(weight)) stop("'weight' must be numeric.")
  if (!is.numeric(height)) stop("'height' must be numeric.")
  if (!is.numeric(age))    stop("'age' must be numeric.")
  # --- Validate inputs are positive ---
  if (weight <= 0) stop("'weight' must be a positive number.")
  if (height <= 0) stop("'height' must be a positive number.")
  if (age <= 0)    stop("'age' must be a positive number.")
  # --- Validate gender ---
  if (!is.character(gender))              stop("'gender' must be a string.")
  if (!gender %in% c("male", "female"))   stop("Invalid gender. Use 'male' or 'female'.")
  # --- Validate activity ---
  if (!activity %in% activity_table$activitylist) {
    stop("Invalid activity. Use one of: 'BMR', 'Sedentary', 'Light', 'Moderate', 'Active', 'Very Active', 'Extra Active'.")
  }
  # --- Validate formula ---
  if (!formula %in% c("MSJ", "RHB", "KMA")) {
    stop("Invalid formula. Use 'MSJ', 'RHB', or 'KMA'. When using 'KMA' also provide 'bodyfat'.")
  }
  # --- Validate bodyfat if KMA ---
  if (formula == "KMA") {
    if (is.null(bodyfat))    stop("Please provide 'bodyfat' when using formula = 'KMA'.")
    if (!is.numeric(bodyfat)) stop("'bodyfat' must be numeric.")
    if (bodyfat <= 0 || bodyfat >= 1) stop("'bodyfat' must be a decimal between 0 and 1 (e.g. 0.20 for 20%).")
  }
  # --- Convert weight to kg ---
  weight_kg <- switch(weight_unit,
                      "kg"  = weight,
                      "lbs" = weight * 0.453592,
                      stop("Invalid weight_unit. Use 'kg' or 'lbs'.")
  )
  # --- Convert height to cm ---
  height_cm <- switch(height_unit,
                      "cm" = height,
                      "m"  = height * 100,
                      "in" = height * 2.54,
                      "ft" = height * 30.48,
                      stop("Invalid height_unit. Use 'cm', 'm', 'in', or 'ft'.")
  )
  # --- Calculate BMR ---
  bmr <- if (formula == "MSJ") {
    if (gender == "male") {
      (10 * weight_kg) + (6.25 * height_cm) - (5 * age) + 5
    } else {
      (10 * weight_kg) + (6.25 * height_cm) - (5 * age) - 161
    }
  } else if (formula == "RHB") {
    if (gender == "male") {
      (13.397 * weight_kg) + (4.799 * height_cm) - (5.677 * age) + 88.362
    } else {
      (9.247 * weight_kg) + (3.098 * height_cm) - (4.330 * age) + 447.593
    }
  } else if (formula == "KMA") {
    370 + 21.6 * (1 - bodyfat) * weight_kg
  }
  # --- Look up activity factor ---
  activity_factor <- activity_table$activity_factors[activity_table$activitylist == activity]
  # --- Calculate caloric intake ---
  caloric_intake <- bmr * activity_factor
  message("Recommended daily calorie intake based on '", activity, "' lifestyle: ", round(caloric_intake))
  return(caloric_intake)
}
