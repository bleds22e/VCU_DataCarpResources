# -----------------------------------------------------------------------------#
# Assignment 4
# Answer the question with comments OR
# Insert the appropriate code below each question or
# -----------------------------------------------------------------------------#

## REMEMBER! ##
# There are lots of helpful resources to help you answer these questions! You 
# can find them in the "Lectures" and "Lab" submodules in Module 2 on D2L!


# Definitions (1 point each) -----------------------------------------------####

# IN YOUR OWN WORDS, define/describe the following. These don't need to be 
# technical descriptions but rather how you are thinking about them. Feel free
# to Google the answers if you are feeling unsure!

# 1. RProject


# 2. R package


# 3. `tidyverse`


# 4. the pipe (AKA %>%)



# Code (1 point each unless otherwise noted) -------------------------------####

## For this assignment, we will again be using the "portal_data_joined.csv" file

## Before we start, be absolutely sure that you are working in your Module 2
## RProject!

# 6. Load the `tidyverse` package into R/RStudio



# 7. Read in the "portal_data_joined.csv" file using the read_csv() function.
# Assign this to an object called "rat_dat" (short for "rat data").


# 8. There are many different functions we can use to look at our dataset. 
# Choose your favorite to get an idea of all the columns in rat_dat.



# 9. IN YOUR OWN WORDS, explain what the select() function (from tidyverse) does.



# 10. Use the select() function to create a dataframe that has only the following
# columns: year, plot_id, species_id, weight. 


# 11. This time, use the select function to create a dataframe with all of the 
# original columns EXCEPT record_id and taxa. 



# 12. IN YOUR OWN WORDS, explain what the filter() function does.

# the filter function allows us to specify which rows we want to include in the
# dataframe based on specific conditions

# 13. Create a dataframe from rat_dat that only includes observations from 
# the year 2000 and later. 



# 14. Create a dataframe that only includes observations where the genus of the 
# rodent is Dipodomys (these are kangaroo rats!). Assign this dataframe to an
# object called krat_dat.



# 15. Execute the line of code below. 

rat_dat %>% 
  filter(taxa == 'Rodent') %>% 
  select(year, plot_id, species_id, plot_type)

# Describe what this code is doing.



# 16. IN YOUR OWN WORDS, explain what the mutate() function does.



# 17. The hindfoot_length column in currently in mm. Create a new column named 
# hindfoot_length_cm where the hindfood measurement is now in centimeters.
# Hint: divide by 10!



# 18. IN YOUR OWN WORDS, explain what the group_by() function does.



# 19. Use the group_by() and summarize() functions together to calculate the
# mean hindfoot_lenght (mm) for each species_id in rat_dat. Remember to use %>%, 
# and remember to exclude NAs from the mean calculation (2 points)



# 20. That's still a lot of non-numeric values! (NaN means "not a number," which)
# means we tried to do a calculation on NA values. The reason we have so many of
# these values is because a lot of the species_ids at the top of the dataframe
# are not rodents, so we don't measure their hindfeet. Add in a line to code
# from question 19 to choose only observations of rodents. You might still get
# a few NaN values (long story...), but you should have far fewer!
# Hint #1: Check out the code from question 15. That might be helpful!
# Hint #2: Think carefully about the order in which you add the new line.



# 21. Copy and paste the code you wrote for question 20 into the answer space 
# for this question. Add a line of code to the code you wrote for question 20 
# which arranges the results from smallest mean hindfoot length to largest.



# 22. Write some code to calculate the mean, minimum, maximum, median, and
# standard deviation for the weight of EACH kangaroo rat species_id. Do this only
# for observations from the year 2000 and later. Assign the output to an object 
# called krat_summary_stats. Print out the dataframe afterwards (3 points).
# Hint: use the krat_dat dataframe that we created (and saved) earlier.


# ---------------------------------------------------------------------------- #
### When you are finished, save this script as "LastName_RNR321_Assignment4.R"
### Submit this file via D2L--just the script, not the entire project.
# ---------------------------------------------------------------------------- #
