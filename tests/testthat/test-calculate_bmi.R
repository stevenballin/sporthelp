test_that("calculate_bmi returns correct value with default units (cm, kg)", {
  expect_equal(calculate_bmi(80, 180), 24.69, tolerance = 0.01)
})

test_that("calculate_bmi returns correct value with metres", {
  expect_equal(calculate_bmi(80, 1.80, height_unit = "m"), 24.69, tolerance = 0.01)
})

test_that("calculate_bmi returns correct value with lbs and inches", {
  expect_equal(calculate_bmi(176, 71, weight_unit = "lbs", height_unit = "in"), 24.55, tolerance = 0.01)
})

test_that("calculate_bmi returns correct value with lbs and feet", {
  expect_equal(calculate_bmi(176, 5.9, weight_unit = "lbs", height_unit = "ft"), 24.55, tolerance = 0.01)
})

test_that("calculate_bmi errors when weight is missing", {
  expect_error(calculate_bmi(height = 180), "Please provide a 'weight'.")
})

test_that("calculate_bmi errors when height is missing", {
  expect_error(calculate_bmi(weight = 80), "Please provide a 'height'.")
})

test_that("calculate_bmi errors on non-numeric weight", {
  expect_error(calculate_bmi("eighty", 180), "'weight' must be numeric.")
})

test_that("calculate_bmi errors on non-numeric height", {
  expect_error(calculate_bmi(80, "tall"), "'height' must be numeric.")
})

test_that("calculate_bmi errors on negative weight", {
  expect_error(calculate_bmi(-80, 180), "'weight' must be a positive number.")
})

test_that("calculate_bmi errors on negative height", {
  expect_error(calculate_bmi(80, -180), "'height' must be a positive number.")
})

test_that("calculate_bmi errors on zero weight", {
  expect_error(calculate_bmi(0, 180), "'weight' must be a positive number.")
})

test_that("calculate_bmi errors on zero height", {
  expect_error(calculate_bmi(80, 0), "'height' must be a positive number.")
})

test_that("calculate_bmi errors on invalid weight_unit", {
  expect_error(calculate_bmi(80, 180, weight_unit = "stone"), "Invalid weight_unit.")
})

test_that("calculate_bmi errors on invalid height_unit", {
  expect_error(calculate_bmi(80, 180, height_unit = "hands"), "Invalid height_unit.")
})
