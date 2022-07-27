# DATA WRANGLING #==============================================================
# using lubridate, tidyr, dplyr and the pipe
# cheatsheets for these packages can be found here: https://www.rstudio.com/resources/cheatsheets/
# another review to run through can be found here: https://datacarpentry.org/R-ecology-lesson/03-dplyr.html
#    - you'll need to download the Portal data in the "Starting w/ Data" section

# Packages #
library(tidyverse)

# Data #

# if we use the "na" argument, the default column changes to double
data2017 <- readr::read_csv("data_raw/dugout2017.csv", 
                            na = c("", "NA", "#N/A", "#VALUE!")) 

# make some quick fixes to the dataframe (from dugouts_2017_complete.R)
data2017 <- data2017[-(103:104),]
data2017[5, 4] <- "24-Jul-17" # reassign date value that includes year

################################################################################

# PIPES #
# the pipe operator (%>%) allows you to chain together functions
# data "flows" from one pipe to the next until the process is complete

# DPLYR #
# data-ply-R = dplyr
# functions including select, filter, mutate, summarize, and group_by #

# TIDYR #
# tidy data in r = tidyr
# functions including joins, pivot_wider, and pivot_longer

# LUBRIDATE and STRINGR also make an appearance #
# lubridate is for working with dates and times
# stringr is for working with character strings in R

################################################################################

# SELECT #======================================================================
# subsetting columns

# use the select function to choose specific columns you want (or remove columns)
select(data2017, Site_ID, Date, Surface_pH, Chla)
select(data2017, -Chla)

# use the select function to make a smaller dataframe for use to work with
subset2017 <- select(data2017, Site_ID, Date, Surface_Cond, SO4.mg.L)

# FILTER #======================================================================
# subsetting rows based on conditions

# get only rows with surface conductivity > 1000 from the subset2017 df
filter(subset2017, Surface_Cond > 1000)

# what? this is super complicated and hard to read!
select(filter(data2017, Surface_Cond > 1000), Site_ID, Date, Surface_Cond)
# we can use pipes instead, making this easier to read and understand
select(data2017, Site_ID, Date, Surface_Cond, SO4.mg.L) %>% 
  filter(Surface_Cond > 1000)

# this code is the exact same as lines 42-43; we're just specifying the data before
data2017 %>% 
  select(Site_ID, Date, Surface_Cond, SO4.mg.L) %>% 
  filter(Surface_Cond > 1000)

# MUTATE #====================================================================== 
# modify existing columns or create new columns using information from other columns 

# SO4 column should be numeric but is getting read in as characters
str(subset2017)
subset2017$SO4.mg.L

# we can use mutate with one column to apply a function to that column
# all three lines of code below do the same thing (convert SO4.mg.L to numeric)
as.numeric(subset2017$SO4.mg.L)
mutate(subset2017, SO4.mg.L = as.numeric(SO4.mg.L))
subset2017 %>% 
  mutate(subset2017, SO4.mg.L = as.numeric(SO4.mg.L))

# LUBRIDATE: easily working with dates and times #
# lubridate is part of the tidyverse and gets installed when you install the tidyverse
# however, it isn't one of the "core" packages that gets loaded into R when you
# use the library function to load tidyverse. Therefore, we need to use the 
# library function to load in lubridate on its own here
library(lubridate)

?dmy
# we can use lubridate functions with the mutate function
subset2017$Date
subset2017 %>% 
  mutate(Date = lubridate::dmy(Date))

# we can do calculations with mutate and create a new column
subset2017 %>% 
  mutate(log_CH4_ebullition = 8.417 + (-3.201*log10(Surface_Cond)))

# if we look at the structure of subset2017, we see that nothing has changed. Why?
# we haven't been assigning any of the code above to subset2017
str(subset2017)

# we can string multiple statements together using pipes
# to make the changes we want to make, we reassign subset2017 with all the 
# mutate changes in one mutate function
subset2017 <- subset2017 %>% 
  mutate(SO4.mg.L = as.numeric(SO4.mg.L),
         Date = dmy(Date),
         log_CH4_ebullition = 8.417 + (-3.201*log10(Surface_Cond)))

# you can string together multiple different functions with pipes, too
pH_DOC_2017 <- data2017 %>%                         # take the data2017 df
  select(Site_ID, Date, Surface_pH, DOC.mg.L) %>%   # select these columns
  mutate(Date = lubridate::dmy(Date)) %>%           # make the Date column read as a date rather than character data type
  mutate(Year = lubridate::year(Date))              # make a new column called Year

# SUMMARIZE #===================================================================
# create summary statistics (often used with group_by, which I cover below)

# summarize average pH and DOC
pH_DOC_2017 %>% 
  summarise(pH_avg = mean(Surface_pH), DOC_avg = mean(DOC.mg.L))
# whoops! we have some NAs to deal with
pH_DOC_2017 %>% 
  summarise(pH_avg = mean(Surface_pH), DOC_avg = mean(!is.na(DOC.mg.L)))

# Let's practice putting some concepts together! #==============================

# use read_csv from readr to load the 2019 dugout data
# use the "na" argument to tell R which values to read as NAs
data2019 <- readr::read_csv("https://raw.githubusercontent.com/bleds22e/FAST_lab_training/master/data/Dugout_master2019.csv",
                            na = c("", "NA", "#N/A", "#VALUE!"))

# some columns are still getting read in as character when they should be numeric
# check out Cloud (%) column to see what is going on there
data2019$`Cloud (%)`  # when column names have a space in them, you have to use 
                      # these backward tick marks to select the column

# The next lines of code require some explanation but cover some useful things!
#
# We can use stringr to deal with the % signs that shouldn't be there.
# The str_replace function says in this data (Cloud (%) column), 
# replace this character string ("%") with nothing ("").
#
# Certain functions will require that you specify the dataframe and column, even
# when you are using pipes. str_replace is one of those functions. It's a little
# complicated as to why that is the case, but str_replace is expecting just one
# string, but in the mutate function, we want it to iterate over the entire 
# column, so we need to explicitly tell str_replace which column.
#
# When you use pipes, you can use the . to indicate that the function should
# use the data that is coming through the pipes.
#
# We also need to convert the data column to a "Date" data type, so we can use
# pipes and a mutate function to do that
data2019 <- data2019 %>% 
  mutate(Cloud_perc = stringr::str_replace(.$`Cloud (%)`, "%", ""),
         Date = lubridate::dmy(Date))

# JOINS #=======================================================================
# merge two related dataframes together

# let's create some dataframes to use for practicing joining
pH_2019 <- select(data2019, Site, Date, Surface_pH) %>% 
  arrange(Surface_pH) %>% # the arrange function orders the column in ascending order
  mutate(Year = lubridate::year(Date))
DOC_2019 <- select(data2019, Site, Date, DOC.mg.L) %>% 
  arrange(DOC.mg.L)

# pretend we read in the pH_2019 df and DOC_2019 df from separate csv files, 
# and now we want to combine these two dataframes together into one.
left_join(pH_2019, DOC_2019) # left_join will match all the rows from the second 
                             # df (DOC_2019) with rows from the first (pH_2019)

# full join will keep all rows from both dataframes, even if they don't have a match
pH_DOC_2019 <- full_join(pH_2019, DOC_2019) 

# Let's get a little more complicated now...
# Use the "by" argument to match data based on columns that have different names.
# x and y will show up when you have columns with the same name in both dataframes
# but can't be matched up (e.g., the 2017 dates and 2019 dates won't have any matches).
# Note the total number of rows is greater than either 2017 or 2019 alone. This
# is because some sites were sampled in 2017 but not 2019 and vice versa.
all_pH_DOC <- full_join(pH_DOC_2017, pH_DOC_2019, by = c("Site_ID" = "Site"))

# Code above was just for a demonstration--not tidy!
#   - the same variable is split into 2 columns!
#   - each row has more than one sample per row!
# A better idea would be to bind rows.
# This produces much tidier data
pH_DOC_2017 <- pH_DOC_2017 %>% 
  select(Site = Site_ID, Year, Surface_pH, DOC.mg.L)
pH_DOC_2019 <- pH_DOC_2019 %>% 
  select(Site, Year, Surface_pH, DOC.mg.L)
all_pH_DOC <- bind_rows(pH_DOC_2017, pH_DOC_2019)

# GROUP BY #====================================================================

# without group by, we get the avg pH and avg DOC across both years
all_pH_DOC %>% 
  summarise(pH_avg = mean(Surface_pH),
            DOC_avg = mean(!is.na(DOC.mg.L)))

# when we group by year, now we get an average per year
all_pH_DOC %>% 
  group_by(Year) %>% 
  summarise(pH_avg = mean(Surface_pH),
            DOC_avg = mean(!is.na(DOC.mg.L)))

# PIVOTING #====================================================================
# pivot_wider and pivot_longer make data...wider or longer!
# These functions used to be called spread and gather, which is what the Data
# Carpentry workshop still uses. Those functions are still around but are
# "depreciated." pivot_wider and pivot_longer offer a lot more flexibility!

# let's look at what all_pH_DOC looks like right now
head(all_pH_DOC)

# what if, for some reason, we want each row to be one measurement only!
# we would want a column that tells us the measurement type and another column
# that has the value for that measurement
longer <- all_pH_DOC %>% 
  pivot_longer(Surface_pH:DOC.mg.L,      # tell pivot_longer which columns to "pivot"
               names_to = "Measurement", # we are taking the column names and putting them into a new column called "Measurement"
               values_to = "Value")      # take the values in the pH and DOC columns and put them in a new column called "Values"  
head(longer)

# what if we are starting from this "long" form data and want to have one
# column for all the pH measurements and one colum for all the DOC measurements?
wider <- longer %>% 
  pivot_wider(names_from = Measurement, # take the values from the Measurement column and make them the names of the new columns
              values_from = Value)     # take the values from the Value column to fill in the new columns
head(wider)

# what if you wanted to make columns for each year instead of each measurement?
wider2 <- longer %>% 
  pivot_wider(names_from = Year,
              values_from = Value)
head(wider2)