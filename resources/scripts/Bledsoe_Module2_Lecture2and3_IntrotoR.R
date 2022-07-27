# Introduction to R and RStudio
# Learn about assigning objects, using functions, vectors, and dataframes
# EKB; Feb 2022

# Assigning Objects---------------------------------------------------------####
mass <- 47.5 # this is the mass in kg
age <- 122
mass <- mass * 2 # multiply
age <- age - 20 # subtract
mass_index <- mass/age # divide
mass_sq <- mass^2 # raise to an exponent

## Functions ---------------------------------------------------------------####

# functions are always followed by parentheses
# anything you type into the parentheses are called arguments
weight_kg <- sqrt(10) # square root
round(weight_kg) # rounding
round(weight_kg, digits = 2) # round to 2 digits past 0

# to get more information about a function, use the help function
help(mean) # or type ?help

## Vectors -----------------------------------------------------------------####

# Vectors are the most common and basic data type in R.
# They are composed of series of values, which can either be numbers or characters
# We use the `c()` function (stands for concatenate) to create a vector.

# Let's create a vector of animal weights (numeric)
weight_g <- c(50, 60, 65, 82)
weight_g

# A vector can also contain character strings (character)
animals <- c("mouse", "rat", "dog")
animals

# There are many functions we can use to look at vectors #

# how many elements
length(weight_g)
length(animals)

# type of data we are working with
class(weight_g)
class(animals)

# structure of an object
str(weight_g)
str(animals)

# can use the c() function to add values
weight_g <- c(weight_g, 30) # add to the end
weight_g <- c(90, weight_g) # add to the beginning
weight_g

# vectors can only be one data type
test_vec <- c(weight_g, animals)
test_vec # coerced everything into character (don't know how to many words numeric)

# subsetting vectors
weight_g[2]
weight_g[c(2,4)]
weight_g[c(1:4)]

# conditional subsetting
weight_g[weight_g > 55]
animals[animals == 'rat']

## Working with Data Frames ------------------------------------------------####

# this is a data package, meaning it is a package that contains datasets
# learn more here: https://allisonhorst.github.io/palmerpenguins/
install.packages("palmerpenguins")
library(palmerpenguins)
penguins

# Functions
head(penguins)      # first 6 lines
head(penguins, 10)  # can specific how many lines
tail(penguins)      # last 6 lines
str(penguins)       # structure
dim(penguins)       # dimensions
names(penguins)     # same as colnames(penguins) in a df

# Subsetting using Indexing #
# row then column (opposite of spreadsheets)
# in vectors, only 1 dimension, so we only need to specify one location
# data frames are 2-dimensional, so he have to specify 2 different locations 
penguins[1:10, c(2,3)]
penguins[1:10, ]
penguins[ , c(1:4)]

# Select individual columns #
# use the $ to select specific columns
penguins$species
flipper_lenght_mm <- penguins$flipper_length_mm

# Plot a histogram #
hist(penguins$flipper_length_mm) # same as hist(flipper_length_mm)

# Use conditional formatting to select specific observations
# in this case, only penguins with flippers greater than or equal to 200 mm
flippers_200mm_min <- penguins[penguins$flipper_length_mm >= 200, ]
hist(flippers_200mm_min) # why doesn't this work? We haven't specified a column
hist(flippers_200mm_min$flipper_length_mm)

# Use conditional formatting to select one species
adelie <- penguins[penguins$species == 'Adelie', ]
hist(adelie$flipper_length_mm)

