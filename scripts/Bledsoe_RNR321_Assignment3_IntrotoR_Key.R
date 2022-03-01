# -----------------------------------------------------------------------------#
# Assignment 3
# Answer the question with comments OR
# Insert the appropriate code below each question or
# -----------------------------------------------------------------------------#

# Definitions (1 point each) -----------------------------------------------####

# IN YOUR OWN WORDS, define/describe the following. These don't need to be 
# technical descriptions but rather how you are thinking about them.

# Grading note:
# I've copied these definitions from my slides. If their definitions are the same,
# they have copied directly from the slides and not used their own words, so
# take 0.5 points off.

# 1. Reproducibility: ability to repeat the original study using the same data, 
# materials, and methods


# 2. Open science: Scientific research conducted and communicated in an honest, 
# accessible, and transparent way, such that--at a minimum--a study can be 
# reproduced and/or replicated.


# 3. R: R refers to both the programming language and the software that 
# interprets scripts written in the language.


# 4. RStudio: RStudio is an integrated development environment (IDE) that helps 
# us interact with R more easily. 


# Short-Answer Question (2 points)------------------------------------------####

# 5. In 2-3 sentences, explain why data management is important for 
# reproducibility.

# Key points they should touch on (at least some):
#     * best practices help with organization 
#     * also important for effective communication (to future you, your colleagues,
#     and others who might want to reproduce your work)
#     * makes transparency higher


# Vectors (1 point each) ---------------------------------------------------####

# If you haven't already, run the following lines of code:
# install.packages("swirl")
# library(swirl)
# swirl()
# Select the "R Programming" option by typing 1 in the console and hitting enter
# Work your way through lessons 3, 6, and 7.
# When it asks if you want credit on Coursera, select no.

# 6. Multiply 8 x 5 and send the result to the console
8 * 5


# 7. Create the object x and have it contain the result of 8 x 5
x <- 8 * 5


# 8. Create the object y and have it contain the result of the square root of 9
# HINT: use the square root function.
y <- sqrt(9)


# 9. Create the object num_vec that contains the values 1, 3, 5, 7
num_vec <- c(1, 3, 5, 7)


# 10. Run the line below to create the object heights. Then add the value 80 to 
# the end of the vector. Keep the same name for the vector (heights).
# Note: NA is the value used by R to identify missing data. 

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 
             69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

heights <- c(heights, 80)
# if they do not rename the vector (AKA only have c(heights, 80), half a point off)

# 11. Use the mean() function to calculate the mean value of height and send the 
# result to the console
mean(heights)


# 12. This should yield an odd result caused by the NAs. 
# To resolve this, use the help function to learn about the 
# argument na.rm = TRUE that applies to many R functions

help(mean) # same as ?mean

# Issue a revised command to calculate the mean value in num_vec and 
# send the result to the console.
mean(heights, na.rm = TRUE) # na.rm = T is also valid


# 13. Write and execute a line of code that selects the 6-10th height values
heights[6:10]


# 14. Execute the line below

heights_above_67 <- heights[heights > 67]

# What does this line do?
# Answer: selects values from the heights vector that are greater than 67 and
# saves them in a new object


# 15. Execute the two lines below

length(heights)
length(heights_above_67)

# What do these lines tell us?
# Answer: The heights vector has 22 values but only 9 of them are greater than 67



# 16. Create the object char_vec that contains the values A, C, D, C
char_vec <- c("A", "B", "C", "D")


# 17. Issue the lines below

char_vec == 'C'
char_vec != 'C'

# What do these lines do?
# Answer: First line creates a logical vector with "TRUE" equaling "C"
# The second line also creates a logical vector for all values except "C"



# Data Frames -------------------------------------------------------------####

# Run the following line of code. This will download a csv file with some rodent
# data from the Portal Project into your RProject. 
# Learn more about the Portal Project here: https://portal.weecology.org/

# As written this code with download the data into a folder called "data_raw"
# If you named your folder something different, you will need to change the
# "destfile" argument to direct it to the correct folder.

download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

# Now read in the csv file using the following line of code.
surveys <- read.csv("data_raw/portal_data_joined.csv")

# 18. Look at the first 6 rows of data. You can either do this by using a 
# function or by using index subsetting (with the square brackets: [])
head(surveys) 
surveys[1:6,] # either one is fine


# 19. How many rows does this data frame have? How many columns?
# Rows: 34786
# Columns: 13


# 20. Use a function to print the column names of surveys.
colnames(surveys)


# 21. Create a histogram with the hindfoot lengths column
hist(surveys$hindfoot_length)


# 22. What does the following line of code do?
surveys[surveys$species_id == "DM", ]

# Answer: selects rows from surveys in which the value in the species_id column
# is "DM"


# 23. Explain what the following lines of code do (2 points).
weights_noNA <- surveys[!is.na(surveys$weight), ]
weights_over200g <- weights_noNA[weights_noNA$weight > 200, ]

# Answer
# First line: Selects rows from surveys in which the weight column is not 
# NA values (so only numeric values) and creates an object called weights_noNA
# Second line: Selects rows from the weights_noNA object in which the values
# in the weight column are greater than 200, saving them in an 
# object called weights_over200g


# ---------------------------------------------------------------------------- #
### When you are finished, save this script as "LastName_RNR321_Assignment3.R" 
### Submit this version of this file via D2L. 
# ---------------------------------------------------------------------------- #
