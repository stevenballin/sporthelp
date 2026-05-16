
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sporthelp

The sporthelp package aims to help users in doing calculations based
around fitness. It provides functions to do common calculations without
having to write them out in scripts.

## Installation

You can install the development version of sporthelp from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stevenballin/sporthelp")
```

## Functions

| Function | Description |
|:---|:---|
| `calculate_bmi()` | Calculate Body Mass Index (BMI) |
| `calculate_bmi_prime()` | Calculate BMI Prime relative to a continental or custom upper limit |
| `calculate_ponderal_index()` | Calculate Ponderal Index (PI) |
| `daily_calories()` | Calculate recommended daily calorie intake |

## Usage

``` r
library(sporthelp)
```

### BMI

Body Mass Index is calculated from weight and height. Rather than
writing the formula manually (error prone), use `calculate_bmi()`:

``` r
# Manual approach
weight_kg <- 80
height_cm <- 180
weight_kg / (height_cm / 100)^2
#> [1] 24.69136

# Using sporthelp
calculate_bmi(weight = 80, height = 180)
#> [1] 24.69136
```

Height and weight units can be specified explicitly:

``` r
calculate_bmi(weight = 176, height = 71, weight_unit = "lbs", height_unit = "in")
#> [1] 24.54675
```

------------------------------------------------------------------------

### BMI Prime

BMI Prime expresses BMI as a ratio relative to the upper limit for a
given region, where a value of 1.0 means BMI is exactly at the upper
limit. It can be calculated from a known BMI or directly from height and
weight:

``` r
# From a known BMI
calculate_bmi_prime(bmi = 25, continent = "Europe")
#> [1] 1.004016

# From height and weight
calculate_bmi_prime(weight = 80, height = 180, continent = "Asia")
#> [1] 1.078225

# With a custom upper limit
calculate_bmi_prime(bmi = 25, upper_limit = 25)
#> [1] 1
```

Supported continents:

| Continent     | Upper Limit |
|:--------------|------------:|
| Asia          |        22.9 |
| Europe        |        24.9 |
| North_America |        24.9 |
| South_America |        24.9 |
| Africa        |        24.9 |
| Oceania       |        25.0 |

------------------------------------------------------------------------

### Ponderal Index

The Ponderal Index is similar to BMI but cubes height instead of
squaring it, making it more reliable for very tall or short individuals:

``` r
# Default units (kg, cm)
calculate_ponderal_index(weight = 80, height = 180)
#> [1] 13.71742

# Imperial units
calculate_ponderal_index(weight = 160, height = 70, weight_unit = "lbs", height_unit = "in")
#> [1] 12.9119
```

------------------------------------------------------------------------

### Daily Calories

Calculates recommended daily calorie intake based on weight, height,
age, gender and activity level. Three BMR formulas are supported:

- `"MSJ"` — Mifflin-St Jeor (default)
- `"RHB"` — Revised Harris-Benedict
- `"KMA"` — Katch-McArdle (requires body fat percentage as a decimal
  e.g. `0.20` for 20%)

``` r
# Default formula (MSJ) with Light activity
daily_calories(weight = 80, height = 180, age = 30, gender = "male")
#> Recommended daily calorie intake based on 'Light' lifestyle: 2448
#> [1] 2447.5

# Specifying activity level
daily_calories(weight = 60, height = 165, age = 25, gender = "female", activity = "Active")
#> Recommended daily calorie intake based on 'Active' lifestyle: 2085
#> [1] 2085.138

# Using the Katch-McArdle formula
daily_calories(weight = 80, height = 180, age = 30, gender = "male",
               bodyfat = 0.20, formula = "KMA")
#> Recommended daily calorie intake based on 'Light' lifestyle: 2410
#> [1] 2409.55

# Imperial units
daily_calories(weight = 176, height = 71, age = 30, gender = "male",
               weight_unit = "lbs", height_unit = "in")
#> Recommended daily calorie intake based on 'Light' lifestyle: 2448
#> [1] 2448.115
```

Supported activity levels:

| Level        | Factor |
|:-------------|-------:|
| BMR          |  1.000 |
| Sedentary    |  1.200 |
| Light        |  1.375 |
| Moderate     |  1.465 |
| Active       |  1.550 |
| Very Active  |  1.725 |
| Extra Active |  1.900 |
