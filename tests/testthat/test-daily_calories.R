# --- Correct output ---
test_that("daily_calories returns correct value with default settings (MSJ, male)", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male"),
               ((10 * 80) + (6.25 * 180) - (5 * 30) + 5) * 1.375, tolerance = 0.01)
})

test_that("daily_calories returns correct value with default settings (MSJ, female)", {
  expect_equal(daily_calories(weight = 60, height = 165, age = 25, gender = "female"),
               ((10 * 60) + (6.25 * 165) - (5 * 25) - 161) * 1.375, tolerance = 0.01)
})

test_that("daily_calories returns correct value with RHB formula (male)", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male", formula = "RHB"),
               ((13.397 * 80) + (4.799 * 180) - (5.677 * 30) + 88.362) * 1.375, tolerance = 0.01)
})

test_that("daily_calories returns correct value with RHB formula (female)", {
  expect_equal(daily_calories(weight = 60, height = 165, age = 25, gender = "female", formula = "RHB"),
               ((9.247 * 60) + (3.098 * 165) - (4.330 * 25) + 447.593) * 1.375, tolerance = 0.01)
})

test_that("daily_calories returns correct value with KMA formula", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              bodyfat = 0.20, formula = "KMA"),
               (370 + 21.6 * (1 - 0.20) * 80) * 1.375, tolerance = 0.01)
})

# --- Activity levels ---
test_that("daily_calories returns correct value with BMR activity", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male", activity = "BMR"),
               ((10 * 80) + (6.25 * 180) - (5 * 30) + 5) * 1, tolerance = 0.01)
})

test_that("daily_calories returns correct value with Sedentary activity", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male", activity = "Sedentary"),
               ((10 * 80) + (6.25 * 180) - (5 * 30) + 5) * 1.2, tolerance = 0.01)
})

test_that("daily_calories returns correct value with Moderate activity", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male", activity = "Moderate"),
               ((10 * 80) + (6.25 * 180) - (5 * 30) + 5) * 1.465, tolerance = 0.01)
})

test_that("daily_calories returns correct value with Active activity", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male", activity = "Active"),
               ((10 * 80) + (6.25 * 180) - (5 * 30) + 5) * 1.55, tolerance = 0.01)
})

test_that("daily_calories returns correct value with Very Active activity", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male", activity = "Very Active"),
               ((10 * 80) + (6.25 * 180) - (5 * 30) + 5) * 1.725, tolerance = 0.01)
})

test_that("daily_calories returns correct value with Extra Active activity", {
  expect_equal(daily_calories(weight = 80, height = 180, age = 30, gender = "male", activity = "Extra Active"),
               ((10 * 80) + (6.25 * 180) - (5 * 30) + 5) * 1.90, tolerance = 0.01)
})

# --- Unit conversions ---
test_that("daily_calories returns correct value with lbs and inches", {
  expect_equal(
    daily_calories(weight = 176, height = 71, age = 30, gender = "male",
                   weight_unit = "lbs", height_unit = "in"),
    daily_calories(weight = 176 * 0.453592, height = 71 * 2.54, age = 30, gender = "male"),
    tolerance = 0.01
  )
})

test_that("daily_calories returns correct value with lbs and feet", {
  expect_equal(
    daily_calories(weight = 176, height = 5.9, age = 30, gender = "male",
                   weight_unit = "lbs", height_unit = "ft"),
    daily_calories(weight = 176 * 0.453592, height = 5.9 * 30.48, age = 30, gender = "male"),
    tolerance = 0.01
  )
})

test_that("daily_calories returns correct value with metres", {
  expect_equal(
    daily_calories(weight = 80, height = 1.80, age = 30, gender = "male", height_unit = "m"),
    daily_calories(weight = 80, height = 180, age = 30, gender = "male"),
    tolerance = 0.01
  )
})

# --- Missing inputs ---
test_that("daily_calories errors when weight is missing", {
  expect_error(daily_calories(height = 180, age = 30, gender = "male"), "Please provide a 'weight'.")
})

test_that("daily_calories errors when height is missing", {
  expect_error(daily_calories(weight = 80, age = 30, gender = "male"), "Please provide a 'height'.")
})

test_that("daily_calories errors when age is missing", {
  expect_error(daily_calories(weight = 80, height = 180, gender = "male"), "Please provide an 'age'.")
})

test_that("daily_calories errors when gender is missing", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30), "Please provide a 'gender'.")
})

# --- Wrong types ---
test_that("daily_calories errors on non-numeric weight", {
  expect_error(daily_calories(weight = "eighty", height = 180, age = 30, gender = "male"),
               "'weight' must be numeric.")
})

test_that("daily_calories errors on non-numeric height", {
  expect_error(daily_calories(weight = 80, height = "tall", age = 30, gender = "male"),
               "'height' must be numeric.")
})

test_that("daily_calories errors on non-numeric age", {
  expect_error(daily_calories(weight = 80, height = 180, age = "thirty", gender = "male"),
               "'age' must be numeric.")
})

test_that("daily_calories errors on non-numeric bodyfat", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              bodyfat = "twenty", formula = "KMA"),
               "'bodyfat' must be numeric.")
})

# --- Invalid values ---
test_that("daily_calories errors on negative weight", {
  expect_error(daily_calories(weight = -80, height = 180, age = 30, gender = "male"),
               "'weight' must be a positive number.")
})

test_that("daily_calories errors on negative height", {
  expect_error(daily_calories(weight = 80, height = -180, age = 30, gender = "male"),
               "'height' must be a positive number.")
})

test_that("daily_calories errors on negative age", {
  expect_error(daily_calories(weight = 80, height = 180, age = -30, gender = "male"),
               "'age' must be a positive number.")
})

test_that("daily_calories errors on zero weight", {
  expect_error(daily_calories(weight = 0, height = 180, age = 30, gender = "male"),
               "'weight' must be a positive number.")
})

test_that("daily_calories errors on zero height", {
  expect_error(daily_calories(weight = 80, height = 0, age = 30, gender = "male"),
               "'height' must be a positive number.")
})

test_that("daily_calories errors on zero age", {
  expect_error(daily_calories(weight = 80, height = 180, age = 0, gender = "male"),
               "'age' must be a positive number.")
})

test_that("daily_calories errors on bodyfat of 0", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              bodyfat = 0, formula = "KMA"),
               "'bodyfat' must be a decimal between 0 and 1")
})

test_that("daily_calories errors on bodyfat of 1 or above", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              bodyfat = 1, formula = "KMA"),
               "'bodyfat' must be a decimal between 0 and 1")
})

test_that("daily_calories errors on bodyfat supplied as percentage rather than decimal", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              bodyfat = 20, formula = "KMA"),
               "'bodyfat' must be a decimal between 0 and 1")
})

# --- Invalid categories ---
test_that("daily_calories errors on invalid gender", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "other"),
               "Invalid gender. Use 'male' or 'female'.")
})

test_that("daily_calories errors on invalid activity", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              activity = "Marathon Runner"),
               "Invalid activity.")
})

test_that("daily_calories errors on invalid formula", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              formula = "ABC"),
               "Invalid formula.")
})

test_that("daily_calories errors on invalid weight_unit", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              weight_unit = "stone"),
               "Invalid weight_unit.")
})

test_that("daily_calories errors on invalid height_unit", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              height_unit = "hands"),
               "Invalid height_unit.")
})

# --- KMA requires bodyfat ---
test_that("daily_calories errors when KMA formula used without bodyfat", {
  expect_error(daily_calories(weight = 80, height = 180, age = 30, gender = "male",
                              formula = "KMA"),
               "Please provide 'bodyfat' when using formula = 'KMA'.")
})
