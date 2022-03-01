#------------------------------------------------------------------------------#
# Introduction to the `tidyverse`
# Data wrangling and cleaning with `dplyr`, `tidyr`, etc.
# EKB; Feb 2022
#------------------------------------------------------------------------------#

# What is the `tidyverse`? -------------------------------------------------####

# The `tidyverse` is an umbrella package, or a collection of packages!
# All packages included in the tidyverse share the same underlying structure,
# grammar, and data structures. They are designed to work seemlessly together.

# Everything we have worked with until now has been part of base R, or functions
# and language that come already installed with R. The tidyverse works a bit 
# differently but is actually more intuitive!

# To learn more about the packages in the tidyverse, check out these links.
# List of packages and what they do: https://www.tidyverse.org/packages/
# RStudio Cheatsheets: https://www.rstudio.com/resources/cheatsheets/
#   - specifically the `dplyr` and `tidyr` cheatsheets, but there are many more!
# Data Carpentry lesson: https://datacarpentry.org/R-ecology-lesson/03-dplyr.html
# Effectively using the tidyverse: https://r4ds.had.co.nz/index.html


#---------------------------------------------------------------------------####
# LOAD TIDYVERSE AND THE DATASET #

# LOAD PACKAGES #

# First we need to install the tidyverse if we haven't yet.
# Then we use the library() function to load it into R so we can use it.

# install.packages("tidyverse")
library(tidyverse)

# When you load the library, you'll see some "conflict." Don't panic! That's
# normal. Those conflicts are telling you that certain functions in `dplyr` are
# now overriding some functions in base R with the same name.

# DATA #

# We will be using the teaching version of some data from my dissertation.
# Learn more about the Portal Project here: https://portal.weecology.org/
# PS - this is the same dataset at the end of Assignment 3.

# If you have already worked through most of Assignment 3, you likely already 
# have this file downloaded into your data_raw folder.

# If not, that's ok! It is in the Lectures submodule in Module 2 on D2L. 
# Download the file to your computer, navigate to your Module 2 RProject, and
# copy the file into the data_raw folder.

surveys <- read_csv("data_raw/portal_data_joined.csv")
# If you named your data_raw folder something different (or with capitals), 
# you'll need to change the file path below to match your folder name.

# --------------------------------------------------------------------------####
# EXPLORE THE DATASET #

head(surveys)
colnames(surveys)
str(surveys)
view(surveys)

# glimpse() is from the dplyr package
glimpse(surveys)

#---------------------------------------------------------------------------####
# SELECT and FILTER #

# use select() to subset columns
# use filter() to subset rows based on conditions

# the first argument is the dataset; all following arguments are the column names
select(surveys, plot_id, species_id, weight)

# to select columns *except* certain ones, use the minus sign 
select(surveys, -record_id, -species_id)

# to choose rows based on specific criteria, use filter()
# first argument is the data; all subsequent arguments are selection criteria
filter(surveys, year == 1995)
filter(surveys, year >= 1995)
filter(surveys, species_id == 'DM')
filter(surveys, year >= 1995, species_id == 'DM')

#---------------------------------------------------------------------------####
# COMBINING FUNCTIONS WITH PIPES #

# the pipe operator is %>% 
# it's originally from the `magrittr` package but tidyverse packages load it, too
# it helps us string together multiple functions without a bunch of intermediate
# steps in between that can become confusing!

# Shortcut: Ctrl + Shift + M (Windows) or Cmd + Shift + M (Mac)

# Say we want to filter the data and only select certain columns. We can do that
# by creating a temporary dataframe. That gets cumbersome quickly, though! 
surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)

rm(surveys_sml)

# Alternatively, we can use the pipe.
surveys_sml <- surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)

# Challenge #
# Using pipes, subset the surveys data to include animals collected before 1995
# and retain only the columns year, sex, and weight.

surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)

# why didn't this show up in the environment?
# because we didn't assign the output to an object!

#---------------------------------------------------------------------------####
# MUTATE #

# the mutate() function helps us create new columns from existing columns and
# applying a mathematical function or other functions 

surveys %>% 
  mutate(weight_kg = weight / 1000)

# we can add head() or glimpse() or other viewing functions to confirm!
surveys %>% 
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  glimpse()

# there are lots of NAs here! let's remove them with the filter function
surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight / 1000) %>% 
  glimpse()


#---------------------------------------------------------------------------####
# GRIOUP BY and SUMMARIZE #

# often, we need to follow the "split-apply-combine" paradigm in data analysis:
#   - split data into groups
#   - apply some type of calculation or analysis to each group
#   - combine the results
# we can use group_by() and summarize() functions from `dplyr` to do this 

# the group_by() function splits the df up into sections by categorical data
# the summarize() function creates a new column with the new calculations
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# let's filter out the NAs at the beginning
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight))

# we can run multiple calculations in the summarize function, as we did with mutate
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight))

# let's arrange the resulting dataframe from smallest mean weight to greatest
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>% 
  arrange(mean_weight)

# we can add the descending argument to go from greatest to smallest
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight)) %>% 
  arrange(desc(mean_weight))

# COUNT #

# Another way to summarize data is through the count() function, which tells us
# how many observations are in each group

surveys %>% 
  count(species_id)

# let's combine with arrange
surveys %>%
  count(sex, species_id) %>%
  arrange(species_id, desc(n))
