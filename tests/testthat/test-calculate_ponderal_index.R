# --- Correct output ---
test_that("calculate_ponderal_index returns correct value with default units (cm, kg)", {
  expect_equal(calculate_ponderal_index(weight = 80, height = 180), 80/1.80^3, tolerance = 0.01)
})

test_that("calculate_ponderal_index returns correct value with metres", {
  expect_equal(calculate_ponderal_index(weight = 80, height = 1.80, height_unit = "m"), 80/1.80^3, tolerance = 0.01)
})

test_that("calculate_ponderal_index returns correct value with inches and lbs", {
  expect_equal(calculate_ponderal_index(weight = 160, height = 70, weight_unit = "lbs", height_unit = "in"), 12.9, tolerance = 0.01)
})

test_that("calculate_ponderal_index returns correct value with feet and lbs", {
  expect_equal(calculate_ponderal_index(weight = 160, height = 5.9, weight_unit = "lbs", height_unit = "ft"),
               (160 * 0.453592) / (5.9 * 0.3048)^3, tolerance = 0.01)
})

test_that("calculate_ponderal_index returns correct value with lbs and cm", {
  expect_equal(calculate_ponderal_index(weight = 160, height = 180, weight_unit = "lbs"),
               (160 * 0.453592) / 1.80^3, tolerance = 0.01)
})

# --- Missing inputs ---
test_that("calculate_ponderal_index errors when weight is missing", {
  expect_error(calculate_ponderal_index(height = 180), "Please provide a 'weight'.")
})

test_that("calculate_ponderal_index errors when height is missing", {
  expect_error(calculate_ponderal_index(weight = 80), "Please provide a 'height'.")
})

# --- Wrong types ---
test_that("calculate_ponderal_index errors on non-numeric weight", {
  expect_error(calculate_ponderal_index(weight = "eighty", height = 180), "'weight' must be numeric.")
})

test_that("calculate_ponderal_index errors on non-numeric height", {
  expect_error(calculate_ponderal_index(weight = 80, height = "tall"), "'height' must be numeric.")
})

# --- Invalid values ---
test_that("calculate_ponderal_index errors on negative weight", {
  expect_error(calculate_ponderal_index(weight = -80, height = 180), "'weight' must be a positive number.")
})

test_that("calculate_ponderal_index errors on negative height", {
  expect_error(calculate_ponderal_index(weight = 80, height = -180), "'height' must be a positive number.")
})

test_that("calculate_ponderal_index errors on zero weight", {
  expect_error(calculate_ponderal_index(weight = 0, height = 180), "'weight' must be a positive number.")
})

test_that("calculate_ponderal_index errors on zero height", {
  expect_error(calculate_ponderal_index(weight = 80, height = 0), "'height' must be a positive number.")
})

# --- Invalid units ---
test_that("calculate_ponderal_index errors on invalid weight_unit", {
  expect_error(calculate_ponderal_index(weight = 80, height = 180, weight_unit = "stone"), "Invalid weight_unit.")
})

test_that("calculate_ponderal_index errors on invalid height_unit", {
  expect_error(calculate_ponderal_index(weight = 80, height = 180, height_unit = "hands"), "Invalid height_unit.")
})

# --- Consistency with calculate_bmi ---
test_that("calculate_ponderal_index and calculate_bmi give different results for same input", {
  expect_false(
    isTRUE(all.equal(
      calculate_ponderal_index(weight = 80, height = 180),
      calculate_bmi(weight = 80, height = 180)
    ))
  )
})
