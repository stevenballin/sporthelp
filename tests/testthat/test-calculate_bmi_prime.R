test_that("calculate_bmi_prime returns correct value with bmi and continent", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Europe"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with height, weight and continent", {
  expect_equal(calculate_bmi_prime(height = 180, weight = 80, continent = "Europe"),
               (80/1.80^2)/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with bmi and upper_limit", {
  expect_equal(calculate_bmi_prime(bmi = 25, upper_limit = 25), 1, tolerance = 0.01)
})

test_that("calculate_bmi_prime returns correct value with height, weight and upper_limit", {
  expect_equal(calculate_bmi_prime(height = 180, weight = 80, upper_limit = 24.9),
               (80/1.80^2)/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime upper_limit takes precedence over continent", {
  expect_equal(calculate_bmi_prime(bmi = 25, upper_limit = 30),
               calculate_bmi_prime(bmi = 25, upper_limit = 30, continent = "Asia"))
})

# --- Continent upper limits ---
test_that("calculate_bmi_prime uses correct upper limit for Asia", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Asia"), 25/22.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime uses correct upper limit for Europe", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Europe"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime uses correct upper limit for North_America", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "North_America"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime uses correct upper limit for South_America", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "South_America"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime uses correct upper limit for Africa", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Africa"), 25/24.9, tolerance = 0.01)
})

test_that("calculate_bmi_prime uses correct upper limit for Oceania", {
  expect_equal(calculate_bmi_prime(bmi = 25, continent = "Oceania"), 25/25.0, tolerance = 0.01)
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

# --- Invalid continent ---
test_that("calculate_bmi_prime errors on unrecognised continent", {
  expect_error(calculate_bmi_prime(bmi = 25, continent = "Atlantis"),
               "Continent not found.")
})

# --- Invalid values ---
test_that("calculate_bmi_prime errors on negative bmi", {
  expect_error(calculate_bmi_prime(bmi = -25, continent = "Europe"))
})

test_that("calculate_bmi_prime errors on zero upper_limit", {
  expect_error(calculate_bmi_prime(bmi = 25, upper_limit = 0))
})
