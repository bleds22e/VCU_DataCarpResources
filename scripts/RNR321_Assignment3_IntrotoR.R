# -----------------------------------------------------------------------------#
# Assignment 3
# Answer the question with comments OR
# Insert the appropriate code below each question or
# -----------------------------------------------------------------------------#

# Definitions (1 point each) -----------------------------------------------####

# IN YOUR OWN WORDS, define/describe the following. These don't need to be 
# technical descriptions but rather how you are thinking about them.

# 1. Reproducibility


# 2. Open science


# 3. R


# 4. RStudio


# Short-Answer Question (2 points)------------------------------------------####

# 5. In 2-3 sentences, explain why data management is important for 
# reproducibility.



# Vectors (1 point each) ---------------------------------------------------####

# If you haven't already, run the following lines of code:
# install.packages("swirl")
# library(swirl)
# swirl()
# Select the "R Programming" option by typing 1 in the console and hitting enter
# Work your way through lessons 3, 6, and 7.
# When it asks if you want credit on Coursera, select no.

# 6. Multiply 8 x 5 and send the result to the console



# 7. Create the object x and have it contain the result of 8 x 5



# 8. Create the object y and have it contain the result of the square root of 9
# HINT: use the square root function.



# 9. Create the object num_vec that contains the values 1, 3, 5, 7



# 10. Run the line below to create the object heights. Then add the value 80 to 
# the end of the vector. Keep the same name for the vector (heights).
# Note: NA is the value used by R to identify missing data. 

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 
             69, 63, 63, NA, 72, 65, 64, 70, 63, 65)


# 11. Use the mean() function to calculate the mean value of height and send the 
# result to the console



# 12. This should yield an odd result caused by the NAs. 
# To resolve this, use the help function to learn about the 
# argument na.rm = TRUE that applies to many R functions

help(mean) # same as ?mean

# Issue a revised command to calculate the mean value in num_vec and 
# send the result to the console.



# 13. Write and execute a line of code that selects the 6-10th height values



# 14. Execute the line below

heights_above_67 <- heights[heights > 67]

# What does this line do?
# Answer: 


# 15. Execute the two lines below

length(heights)
length(heights_above_67)

# What do these lines tell us?
# Answer:



# 16. Create the object char_vec that contains the values A, C, D, C



# 17. Issue the lines below

char_vec == 'C'
char_vec != 'C'

# What do these lines do?
# Answer: 



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



# 19. How many rows does this data frame have? How many columns?
# Rows:
# Columns:



# 20. Use a function to print the column names of surveys.



# 21. Create a histogram with the hindfoot lengths column



# 22. What does the following line of code do?
surveys[surveys$species_id == "DM", ]

# Answer: 



# 23. Explain what the following lines of code do (2 points).
weights_noNA <- surveys[!is.na(surveys$weight),]
weights_over200g <- weights_noNA[weights_noNA$weight >= 200, ]

# Answer #
# First line:
# Second line:


# ---------------------------------------------------------------------------- #
### When you are finished, save this script as "LastName_RNR321_Assignment3.R" 
### Submit this version of this file via D2L. 
# ---------------------------------------------------------------------------- #
