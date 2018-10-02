library(stringdist)
library(stringr)
library(rlang)
library(tidyverse)
library(magrittr)

# Set the working directory - NOTE the use of backslash
setwd("C:/Users/Rob/Documents/git/Titanic/Titanic")


# Read CSV into R
t_df <- read_csv(file="Titanic3.csv", col_names=TRUE)


##
# Replace blanks in embarked with "S"
t_df %<>% mutate(embarked = if_else(is.na(embarked), 'S', embarked))

#check the output
t_df %>% select(embarked) %>% unique()

##
# Calculate the mean of the Age column and use that value to populate the missing values
# I grouped this by pclass to vary the age
t_df <-  t_df %>% 
         group_by(pclass) %>% 
         mutate(age = if_else(is.na(age), mean(age, na.rm = TRUE), age))

t_df <- t_df %>% ungroup()
##
# Lifeboat (boat) - Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'

t_df %<>% mutate(boat= if_else(is.na(boat), 'NA', boat))
t_df %>% select(boat) %>% unique()

##
# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
t_df %<>% mutate(has_cabin_number = if_else(is.na(cabin), 0, 1))


##
# Save to GitHub

write_csv(t_df, "tianic_clean.csv")

