# 0-clean.R
# setwd() to this folder

# Data was downloaded from https://www.nlsinfo.org/investigator/. Variables were
# selected manually with the web api. You can recreate this data set by 
# selecting the variables with the following reference numbers: A0002500,
# R0000100, R0214700, R0214800, R0618301, R1774100, R1774200, T3212900,
# T3955000, T3955100, T3955200, T3977400, T3979400, T4112900, T4113200 from the 
# NLSY79 (1979-2012) study

# The clean script below is adapted from the clean script provided by NLS
# investigator, NLSY79-2012-bookvars.R

new_data <- read.table('NLSY79-2012-bookvars.dat', sep=' ')
varlabels <- c("case", "id", "race", "sex", "afqt", "hair", "eyes", "education", 
               "weight", "feet", "inches", "income", "earnings", "marital", "age")
names(new_data) <- varlabels

# Handle missing values
  new_data[new_data == -1] = NA  # Refused 
  new_data[new_data == -2] = NA  # Dont know 
  new_data[new_data == -3] = NA  # Invalid missing 
  new_data[new_data == -4] = NA  # Valid missing 
  new_data[new_data == -5] = NA  # Non-interview 

# If there are values not categorized they will be represented as NA
vallabels = function(data) {
  data$race <- factor(data$race, levels=c(1.0,2.0,3.0), labels=c("hispanic","black","other"))
  data$sex <- factor(data$sex, levels=c(1.0,2.0), labels=c("male","female"))
  data$hair <- factor(data$hair, levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0), labels=c("light_blond","blond","light_brown","brown","black","red","grey"))
  data$eyes <- factor(data$eyes, levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0), labels=c("light_blue","blue","light_brown","brown","black","green","hazel","grey","other"))
  data$education[data$education == 95] <- NA
  data$marital <- factor(new_data$marital, levels=c(0.0,1.0,2.0,3.0,6.0), labels=c("single","married","separated","divorced","widowed"))
  return(data)
}

categories <- vallabels(new_data)

# standardize heights
categories$feet[categories$inches > 12 & !is.na(categories$inches)] <- 0

library(dplyr)

heights <- 
  categories %>% 
  mutate(height = inches + feet * 12, afqt = afqt / 1000) %>% 
  filter(!is.na(income), height < 90, height > 40) %>% 
  select(id, income, height, weight, age, hair, eyes, marital, sex, education, afqt)
  
saveRDS(heights, file = "heights.RDS")

  