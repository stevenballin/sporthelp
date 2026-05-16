# --- Correct output: bmi + continent ---
test_that("calculate_bmi_prime returns correct value with bmi and continent (Europe)", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Europe"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with bmi and continent (Asia)", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Asia"), 25/22.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with bmi and continent (North_America)", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "North_America"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with bmi and continent (South_America)", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "South_America"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with bmi and continent (Africa)", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Africa"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with bmi and continent (Oceania)", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Oceania"), 25/25.0, tolerance = 0.01)
})

# --- Correct output: bmi + upper_limit ---
test_that("calculate_bmi_prime returns correct value with bmi and upper_limit", {
  expect_equal(calculate_bmi_prime(bmi = 25, upper_limit = 25), 1, tolerance = 0.01)
})

# --- Correct output: height + weight + continent ---
test_that("calculate_bmi_prime returns correct value with height, weight and continent (default units)", {
  expect_equal(calculate_bmi_prime(weight = 80, height = 180, continent = "Europe"),
               (80/1.80^2)/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with height, weight and continent (lbs, inches)", {
  expect_equal(
    calculate_bmi_prime(weight = 176, height = 71, continent = "Europe",
                        weight_unit = "lbs", height_unit = "in"),
    calculate_bmi(weight = 176, height = 71, weight_unit = "lbs", height_unit = "in") / 24.9,
    tolerance = 0.01
  )
})

test_that("calculate_bmi_prime returns correct value with height, weight and continent (lbs, feet)", {
  expect_equal(
    calculate_bmi_prime(weight = 176, height = 5.9, continent = "Europe",
                        weight_unit = "lbs", height_unit = "ft"),
    calculate_bmi(weight = 176, height = 5.9, weight_unit = "lbs", height_unit = "ft") / 24.9,
    tolerance = 0.01
  )
})

test_that("calculate_bmi_prime returns correct value with height, weight and continent (metres)", {
  expect_equal(
    calculate_bmi_prime(weight = 80, height = 1.80, continent = "Europe", height_unit = "m"),
    calculate_bmi(weight = 80, height = 1.80, height_unit = "m") / 24.9,
    tolerance = 0.01
  )
})

# --- Correct output: height + weight + upper_limit ---
test_that("calculate_bmi_prime returns correct value with height, weight and upper_limit", {
  expect_equal(calculate_bmi_prime(weight = 80, height = 180, upper_limit = 24.9),
               (80/1.80^2)/24.9, tolerance = 0.01)
})

# --- upper_limit takes precedence over continent ---
test_that("calculate_bmi_prime upper_limit takes precedence over continent", {
  expect_equal(
    calculate_bmi_prime(bmi = 25, upper_limit = 30),
    calculate_bmi_prime(bmi = 25, upper_limit = 30, continent = "Asia")
  )
})

# --- Antarctica ---
test_that("calculate_bmi_prime errors on Antarctica", {
  expect_error(calculate_bmi_prime(bmi = 25, continent = "Antarctica"),
               "No BMI data available for Antarctica.")
})

# --- Missing inputs ---
test_that("calculate_bmi_prime errors when no limit or continent provided", {
  expect_error(calculate_bmi_prime(bmi = 25),
               "Please provide either a 'continent' or an 'upper_limit'.")
})

test_that("calculate_bmi_prime errors when no bmi, height or weight provided", {
  expect_error(calculate_bmi_prime(continent = "Europe"),
               "Please provide either 'bmi' or both 'height' \\(cm\\) and 'weight' \\(kg\\).")
})

test_that("calculate_bmi_prime errors when only height provided without weight", {
  expect_error(calculate_bmi_prime(height = 180, continent = "Europe"),
               "Please provide either 'bmi' or both 'height' \\(cm\\) and 'weight' \\(kg\\).")
})

test_that("calculate_bmi_prime errors when only weight provided without height", {
  expect_error(calculate_bmi_prime(weight = 80, continent = "Europe"),
               "Please provide either 'bmi' or both 'height' \\(cm\\) and 'weight' \\(kg\\).")
})

# --- Wrong types ---
test_that("calculate_bmi_prime errors on non-numeric bmi", {
  expect_error(calculate_bmi_prime(bmi = "twenty five", continent = "Europe"),
               "'bmi' must be numeric.")
})

test_that("calculate_bmi_prime errors on non-numeric upper_limit", {
  expect_error(calculate_bmi_prime(bmi = 25, upper_limit = "twenty five"),
               "'upper_limit' must be numeric.")
})

test_that("calculate_bmi_prime errors on non-character continent", {
  expect_error(calculate_bmi_prime(bmi = 25, continent = 123),
               "'continent' must be a string.")
})

test_that("calculate_bmi_prime errors on non-numeric weight", {
  expect_error(calculate_bmi_prime(weight = "eighty", height = 180, continent = "Europe"),
               "'weight' must be numeric.")
})

test_that("calculate_bmi_prime errors on non-numeric height", {
  expect_error(calculate_bmi_prime(weight = 80, height = "tall", continent = "Europe"),
               "'height' must be numeric.")
})

# --- Invalid values ---
test_that("calculate_bmi_prime errors on negative bmi", {
  expect_error(calculate_bmi_prime(bmi = -25, continent = "Europe"),
               "'bmi' must be a positive number.")
})

test_that("calculate_bmi_prime errors on zero bmi", {
  expect_error(calculate_bmi_prime(bmi = 0, continent = "Europe"),
               "'bmi' must be a positive number.")
})

test_that("calculate_bmi_prime errors on negative upper_limit", {
  expect_error(calculate_bmi_prime(bmi = 25, upper_limit = -25),
               "'upper_limit' must be a positive number.")
})

test_that("calculate_bmi_prime errors on zero upper_limit", {
  expect_error(calculate_bmi_prime(bmi = 25, upper_limit = 0),
               "'upper_limit' must be a positive number.")
})

test_that("calculate_bmi_prime errors on negative weight", {
  expect_error(calculate_bmi_prime(weight = -80, height = 180, continent = "Europe"),
               "'weight' must be a positive number.")
})

test_that("calculate_bmi_prime errors on negative height", {
  expect_error(calculate_bmi_prime(weight = 80, height = -180, continent = "Europe"),
               "'height' must be a positive number.")
})

test_that("calculate_bmi_prime errors on zero weight", {
  expect_error(calculate_bmi_prime(weight = 0, height = 180, continent = "Europe"),
               "'weight' must be a positive number.")
})

test_that("calculate_bmi_prime errors on zero height", {
  expect_error(calculate_bmi_prime(weight = 80, height = 0, continent = "Europe"),
               "'height' must be a positive number.")
})

# --- Invalid continent ---
test_that("calculate_bmi_prime errors on unrecognised continent", {
  expect_error(calculate_bmi_prime(bmi = 25, continent = "Atlantis"),
               "Continent not found.")
})

# --- Invalid units (delegated to calculate_bmi) ---
test_that("calculate_bmi_prime errors on invalid weight_unit", {
  expect_error(calculate_bmi_prime(weight = 80, height = 180, continent = "Europe",
                                   weight_unit = "stone"),
               "Invalid weight_unit.")
})

test_that("calculate_bmi_prime errors on invalid height_unit", {
  expect_error(calculate_bmi_prime(weight = 80, height = 180, continent = "Europe",
                                   height_unit = "hands"),
               "Invalid height_unit.")
})
