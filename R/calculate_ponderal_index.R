#' Calculates Ponderal Index
#'
#' @param weight Weight of person
#' @param height Height of person
#' @param weight_unit The unit of weight parameter. Must be either 'kg' or 'lbs'.
#' @param height_unit The unit of the height parameter. Must be any of: 'cm', 'm', 'in' or 'ft'.
#'
#' @returns A numerical value
#' @export
#'
#' @examples
#' calculate_ponderal_index(weight=80, height=180)
#' calculate_ponderal_index(weight=160, height=6.4, weight_unit="lbs", height_unit="ft")
calculate_ponderal_index <- function(weight = NULL, height = NULL,
                                     weight_unit = "kg", height_unit = "cm") {
  # --- Validate inputs exist ---
  if (is.null(weight)) stop("Please provide a 'weight'.")
  if (is.null(height)) stop("Please provide a 'height'.")
  # --- Validate inputs are numeric ---
  if (!is.numeric(weight)) stop("'weight' must be numeric.")
  if (!is.numeric(height)) stop("'height' must be numeric.")
  # --- Validate inputs are positive ---
  if (weight <= 0) stop("'weight' must be a positive number.")
  if (height <= 0) stop("'height' must be a positive number.")
  # --- Convert weight to kg ---
  weight_kg <- switch(weight_unit,
                      "kg"  = weight,
                      "lbs" = weight * 0.453592,
                      stop("Invalid weight_unit. Use 'kg' or 'lbs'.")
  )
  # --- Convert height to metres ---
  height_m <- switch(height_unit,
                     "cm" = height / 100,
                     "m"  = height,
                     "in" = height * 0.0254,
                     "ft" = height * 0.3048,
                     stop("Invalid height_unit. Use 'cm', 'm', 'in', or 'ft'.")
  )
  # --- Calculate Ponderal Index (SI: kg/m^3) ---
  pi_value <- weight_kg / height_m^3
  return(pi_value)
}
