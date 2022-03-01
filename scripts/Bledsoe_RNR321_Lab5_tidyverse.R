#---------------------------------------------------------------------------####
# Self-directed `tidyverse` Tutorial
# Cover some useful functions from the `dplyr` package (part of tidyverse)
# Optional: additional functions from `tidyr`
# Modified from Living Data Project by EKB, Feb 2022
#---------------------------------------------------------------------------####

## !!! IMPORTANT NOTE !!! ##
## This tutorial goes a bit further into the code than I truly expect you to 
## know or understand. That's ok! It's good practice to push your boundaries a
## bit. But don't panic! Things I have not covered in class will not be on the
## quiz or in your assignments.

## Also, the exercises are to help you practice. You do not need to turn them in.


### SET-UP ---------------------------------------------------------------------

## RProject ##

# Make sure you are in your Module 2 RProject! We covered this in class (2/21).
# In short, navigate to your RNR321_Module2 folder on your computer. Open that
# folder and then open (double-click) on the RNR321_Module2.Rproj file.

## Packages ##

### install (and then load) required packages
# install.packages("tidyverse")
library(tidyverse)

## Read in Files ##

# If you haven't downloaded the files already:
# Download the datasets "bromeliads.csv" and "visits.csv" from D2L. They are in 
# the "Lab" submodule in Module 2. Place them in your data_raw folder.

# the bromeliads data has a lot of colu
bromeliads <- read_csv("data_raw/bromeliads.csv")
visits <- read_csv("data_raw/visits.csv")


### Part 1: DATA WRANGLING -------------------------------------------------####

## First, let's get familiar with the two datasets.

# bromeliads contains quite a bit of information about individual bromeliads, 
# when and where they were measured, and the small pool of water created by
# their leaves
colnames(bromeliads)
glimpse(bromeliads)

# visits is a much smaller dataframe. It contains information specific to when
# a bromeliad was collected
colnames(visits)
glimpse(visits)

### The pipe: %>% ###
## keyboard shortcut: Ctrl + Shift + M / Cmd + Shift + M

# The pipe %>% allows for "chaining", which means that you can invoke multiple 
# method calls without needing variables to store the intermediate results.

## Example
# check out the mtcars dataframe that was loaded with tidyverse
head(mtcars)

## Let's calculate the average mpg for each cylinder (cyl)

# Option 1: Store each step in the process sequentially
result_int <- group_by(mtcars, cyl)
result_int

result <- summarise(result_int, meanMPG = mean(mpg))
result

# Option 2: use the pipe %>% to chain the functions together
result <- group_by(mtcars, cyl) %>% 
  summarise(meanMPG = mean(mpg))
result

# using the pipe, we did not have to create an intermediate object (result_int)


### DPLYR::SELECT ###
## select the columns you want to work with

## first, let's take a look at the structure of the bromeliads data frame
str(bromeliads)

## to select columns by name:
bromeliads %>%
  select(bromeliad_id, species)

## to select columns column number:
bromeliads %>%
  select(1:3, 5)

## Create a new dataframe called bromeliads_selected
# include the columns: bromeliad_id, species, num_leaf, extended_diameter, 
# max_water, and total_detritus
bromeliads_selected <- bromeliads %>%
  select(bromeliad_id, species, num_leaf, extended_diameter, max_water, total_detritus)
head(bromeliads_selected)



### DPLYR::RENAME ###

## we can rename a variable within the select command
bromeliads_selected <- bromeliads %>%
  select(visit_id, bromeliad_id, species, num_leaf, 
         diameter = extended_diameter, 
         volume = max_water, 
         total_detritus)
head(bromeliads_selected)

# or by using DPLYR::RENAME
bromeliads_selected <- bromeliads_selected %>%
  dplyr::rename(detritus = total_detritus)
head(bromeliads_selected)



### DPLYR::ARRANGE ###
## We can sort this dataframe by the values for bromeliad volume
bromeliads_selected %>%
  arrange(volume)


## ARRANGE: descending
## We can also reverse the order, sorting from largest to smallest
bromeliads_selected %>%
  arrange(desc(volume))


### DPLYR::FILTER ###

## let's subset our data to include only Guzmania_sp
bromeliads_selected %>%
  arrange(volume) %>%
  filter(species == "Guzmania_sp")

## we can also filter for multiple species
bromeliads_selected %>%
  arrange(volume) %>%
  filter(species %in% c("Guzmania_sp", "Vriesea_sp"))

## we may also want all bromeliads in the Vriesea genus
# for that we can use stringr::str_detect 
bromeliads_selected %>%
  arrange(volume) %>%
  filter(str_detect(species, "Vriesea"))

## some species are only found in bromeliads with a maximum volume > 100 ml
# (let's use filter to subset for Guzmania bromeliads > 100 ml only
bromeliads_selected %>%
  arrange(volume) %>%
  filter(species == "Guzmania_sp",
         volume > 100)



### DPLYR::COUNT ###
## Count the number of bromeliads for each species in our dataset
bromeliads_selected %>%
  count(species)

## sort from most to least common
bromeliads_selected %>%
  count(species) %>%
  arrange(desc(n))

## you can also use
bromeliads_selected %>%
  count(species, sort = TRUE)



### DPLYR::MUTATE ###

## Bromeliads contain little wells that are formed in the axils of their leaves.
## Let's create a new column (av_well_volume) that represents the average volume 
## of a bromeliad leaf well
bromeliads_selected %>%
  mutate(av_well_volume = volume / num_leaf)


### MUTATE in combination with ifelse
## (Don't worry, I know we haven't covered ifelse. See if you can figure out
## how this bit of code is working.)

## let's categorize bromeliads based on their water holding capacity
## small: < 50 mL
## medium: 50 - 100 mL
## large: > 100 mL
bromeliads_selected %>%
  mutate(bromeliad_size = ifelse(volume < 50, "small",
                                 ifelse(volume <= 100, "medium",
                                        ifelse(volume > 100, "large", NA))))



#### EXERCISE 1: #### (All exercise answers are at the bottom of the script)
## Combine what you have learned so far.
## Create a new dataframe (Guzmania_selected) from the bromeliads_selected table
## only include bromeliads > 100 ml. Add a column for the average well volume 
## (av_well_volume), and sort by this column from largest to smallest.

#Guzmania_selected <- bromeliads_selected %>%
#  ---

#####



### DPLYR::SUMMARIZE ###

## what is the mean volume across all bromeliads (use bromeliads_selected)
bromeliads_selected %>%
  summarize(mean_volume = mean(volume))

## oh no! This gives us NA
bromeliads_selected$volume
# that is because there are NAs in our data

## let's try again
bromeliads_selected %>%
  summarize(mean_volume = mean(volume, na.rm = TRUE))

## alternatively, we can use the filter function to remove NAs
bromeliads_selected %>% 
  filter(!is.na(volume)) %>% 
  summarize(mean_volume = mean(volume))

## we can also summarize several columns at once
bromeliads_selected %>%
  summarize(mean_volume = mean(volume, na.rm = TRUE),
            max_volume = max(volume, na.rm = TRUE),
            med_leaves = median(num_leaf, na.rm = TRUE),
            n = n()) # run ?n to learn more about the function n()



### DPLYR::GROUP_BY - AGGREGATE WITHIN GROUPS ###

# we can also summarize for each species
bromeliads_selected %>%
  group_by(species) %>%
  summarize(mean_volume = mean(volume, na.rm = TRUE),
            max_volume = max(volume, na.rm = TRUE),
            med_leaves = median(num_leaf, na.rm = TRUE),
            n = n()) %>%
  arrange(desc(n))


### VERY IMPORTANT NOTE!!! ### -------------------------------------------------
# Everything from here down, you WILL NOT be expected to know for either the 
# assignment or the quiz. However, this information might be super useful for 
# you down the road, so I am still including it as a reference. It is completely
# optional as to whether you want to run through this material or not.
### ----------------------------------------------------------------------------


### TIDYR::SEPARATE ###

## we may also want to group by genus
## for that, we need to create a new column (Genus)
head(bromeliads_selected)
head(separate(data = bromeliads_selected, col = species,
                    into = c("Genus", "Species"),
                    sep = "_", remove = FALSE))

## pipe into group_by and summarize to get summary statistics for the genera
separate(data = bromeliads_selected, col = species,
         into = c("Genus", "Species"),
         sep = "_", remove = FALSE) %>%
  group_by(Genus) %>%
  summarize(mean_volume = mean(volume, na.rm = TRUE),
            max_volume = max(volume, na.rm = TRUE),
            med_leaves = median(num_leaf, na.rm = TRUE),
            n = n()) %>%
  arrange(desc(n))



#### EXERCISE 2: #### 
## Which bromeliad genus has a higher fraction of large bromeliads (> 100 ml)?
## use what you have learned to create a table that lists the number of small 
## and large bromeliads for each genus. Use this table to calculate the fraction
## of large (>100 mL) bromeliads by hand. 

# Genus_sizes <- bromeliads_selected %>%
# ---


#####



#### PART 2: Joining Tables #### -----------------------------------------------

## We may want to find out when these bromeliads were sampled.
## However, this information is not in the bromeliad table.
names(bromeliads)

# Having a look at our BWG database diagram, we can see that sampling dates are 
# stored in the "visits" table, which is connected to the "bromeliads" table via 
# the key "visit_id"

# lets check out visits (click on visits in your global environment)
str(visits)

## let's convert the dates to the right format so we can work with them
visits$date
visits$date <- as_date(visits$date) # convert to date-times format


### DPLYR::LEFT_JOIN ###
# lets join visits to bromeliads to extract the sampling dates

head(bromeliads_selected %>%
  left_join(visits, by = "visit_id") )

# but we don't really want all these columns, as this get's way to busy
# let's use join in combination with select
names(visits)
select(visits, visit_id, dataset_id, date, latitude, longitude)

bromeliad_visits <- bromeliads_selected %>%
  left_join(select(visits, visit_id, dataset_id, date, latitude, longitude), 
            by = "visit_id")
head(bromeliad_visits)

## NOTE: using left_join (as opposed to inner_join) ensures that all rows in the 
## bromeliad table are preserved. However, in this case this does not make a 
## difference, as all visit_id keys are represented in both tables.



###### EXERCISE SOLUTIONS ###### -----------------------------------------------

### EX 1 SOLUTION ####
Guzmania_selected <- bromeliads_selected %>%
  filter(species == "Guzmania_sp",
         volume > 100) %>%
  mutate(av_well_volume = volume / num_leaf) %>%
  arrange(desc(av_well_volume))
head(Guzmania_selected)

## if we want to remove this last column from our table again, we can do this with
Guzmania_selected <- Guzmania_selected %>%
  select(-av_well_volume)
head(Guzmania_selected)
#####


#### EX 2 SOLUTION ####
Genus_sizes <- bromeliads_selected %>%
  # create new column for small (<= 100mL) and large (> 100ml) bromeliads
  mutate(bromeliad_size = ifelse(volume <= 100, "small",
                                 ifelse(volume > 100, "large", NA))) %>%
  # create new column for Genus using tidyr::seperate
  separate(col = species,
           into = c("Genus", "Species"),
           sep = "_", remove = FALSE) %>%
  # group by Genus, then count by bromeliad_size
  group_by(Genus) %>%
  count(bromeliad_size) 
Genus_sizes

# Vriesea has almost twice the amount of large bromeliads than Guzmania
#####
