# Data was downloaded from https://www.nlsinfo.org/investigator/. Variables were
# selected manually with the web api. You can recreate this data set by
# selecting the variables with the following reference numbers: A0002500,
# R0000100, R0214700, R0214800, R0618301, R1774100, R1774200, T3212900,
# T3955000, T3955100, T3955200, T3977400, T3979400, T4112900, T4113200 from the
# NLSY79 (1979-2012) study

library(readr)
library(dplyr)

new_data <- read_delim(
  "data-raw/NLSY79-2012-bookvars.dat",
  delim = " ",
  col_names = c(
    "case", "id", "race", "sex", "afqt", "hair", "eyes", "education",
    "weight", "feet", "inches", "income", "earnings", "marital", "age"
  )
)

# Replace missing values
new_data[new_data < 0] <- NA
new_data$education[new_data$education == 95] <- NA

new_data <- new_data %>%
  mutate(
    race = factor(
      race,
      levels = 1:3,
      labels = c("hispanic", "black", "other")
    ),
    sex = factor(sex,
      levels = 1:2,
      labels = c("male", "female")),
    marital = factor(
      marital,
      levels = c(0, 1, 2, 3, 6),
      labels = c("single", "married", "separated", "divorced", "widowed")
    )
  )

# Some heights were recorded only in inches
new_data %>%
  filter(inches > 12)
new_data$feet[new_data$inches > 12 & !is.na(new_data$inches)] <- 0

heights <- new_data %>%
  mutate(height = inches + feet * 12, afqt = afqt / 1000) %>%
  filter(!is.na(income), height < 90, height > 40) %>%
  select(income, height, weight, age, marital, sex, education, afqt)

use_data(heights, overwrite = TRUE)
