#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#-#-#-#   Data cleaning and data standards            #-#-#-#
#-#-#-#   Living Data Project -- Data Management      #-#-#-#
#-#-#-#   Authors: Diane Srivastava, Joey Burant      #-#-#-#
#-#-#-#   Last updated: 20 Novemeber 2020             #-#-#-#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

## Introduction:
## The data cleaning examples below make use of the Palmer penguins 
## dataset (package: palmerpenguins): 
## https://CRAN.R-project.org/package=palmerpenguins
## The dataset includes measurements of several morphological variables
## from three species of penguins observed on islands near 
## Palmer Station, Antarctica. 
## The package creator, Dr. Allson Horst, as made a great vignette
## where you can find more information about the data: 
# https://github.com/allisonhorst/palmerpenguins

## If you're interested, check out this associated paper:
## Gorman, K.B., Williams, T.D., and Fraser, W.R. (2014). Ecological 
## sexual dimorphism and environmental variability within a community
## of Antarctic penguins (genus Pygoscelis). PLoS ONE, 9: e90081.
## https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0090081


# initial set up ----------------------------------------------------------

## check your working directory
getwd()

## install and call required packages
pkgs <- c("taxize", "assertr", "stringdist", 
          "tidyverse", "palmerpenguins", "GGally")
#lapply(pkgs, install.packages, character.only = TRUE)
lapply(pkgs, library, character.only = TRUE)
rm(pkgs)

## set a plotting theme
theme_set(theme_bw())


# explore data ------------------------------------------------------------

## let's explore the penguins dataset from `palmerpenguins` package

## load data
data(penguins)

## some initial exploration steps
dim(penguins) # [1] 344 rows (observations) and 8 columns (variables)
head(penguins, 5) ## view the first 5 rows of data
summary(penguins) ## summarize the dataset
# skimr::skim(penguins) ## summarize the dataset (much more detailed!)

## plot the data
penguins %>%
  select(species, body_mass_g, ends_with("_mm")) %>%
  GGally::ggpairs(aes(color = species))

## add a column with Latin species names
## all 3 are members of the Pygoscelis genus of brush-tailed penguins
penguins <- penguins %>% 
  mutate(speciesL = case_when(species == "Adelie" ~ "adeliae", 
                              species == "Chinstrap" ~ "antarctica", 
                              species == "Gentoo" ~ "papua")) %>% 
  relocate(speciesL, .after = 1)


# enter the evil data gnome -----------------------------------------------

## let's pretend that an evil gnome has tinkered with some of our data

## introduce some other errors into the dataset
penguins$body_mass_g[1] <- 7000 ## too high value for body mass
penguins$speciesL[10] <- "adelae" ## typo in species name
penguins$flipper_length_mm[301] <- ## flip sign (-'ve value)
  penguins$flipper_length_mm[301] * -1
penguins$body_mass_g[50] <- 5522 ## subtly too large body mass 
penguins <- penguins[-c(15, 100, 200, 273), ] ## delete some rows

## convert species to a factor, now that we've added a typo
penguins$speciesL <- as.factor(penguins$speciesL)

# finding errors ----------------------------------------------------------

## now, let's use some reproducible techniques to find some of these errors
## one way to do so:
## calculate something, with some assertions upstream
## if the assertions fail, the calculation will also fail

## calculate the mean flipper_length_mm for each species
penguins %>% 
  group_by(species) %>% 
  summarise(mean_flipper_length = mean(flipper_length_mm, na.rm = TRUE))

## note: if we had grouped by speciesL instead of species, we would
## already be able to notice the typo we introduced.
penguins %>% 
  group_by(speciesL) %>% 
  summarise(mean_flipper_length = mean(flipper_length_mm, na.rm = TRUE))


# (1) a priori constraint: should include 344 observations ----------------

penguins %>% 
  verify(nrow(.) == 344) %>% 
  group_by(species) %>% 
  summarise(mean_flipper_length = mean(flipper_length_mm, na.rm = TRUE))

## stopped execution because there aren't 344 rows 
## (but how many are there??)
## try changing the above verify() argument to 340 instead


# (2) a priori constraint: all measurements should be positive ------------

penguins %>% 
  assert(within_bounds(0, Inf), 
         -c(species, speciesL, island, sex, year)) %>%
  group_by(species) %>%
  summarise(mean_flipper_length = mean(flipper_length_mm, na.rm = TRUE))

## stopped execution because flipper_length_mm includes a negative value.
## note that assert(), unlike verify(), identifies which element fails
## the test.


# (3) post hoc constraint: body mass too heavy (outlier) ------------------

penguins %>% 
  insist(within_n_sds(2), body_mass_g) %>% 
  group_by(species) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

## stopped execution because at least one value (7000) is more than 2 SD
## away from the global mean body_mass_g (i.e, across all species)
## it also identified 6 other potential outliers

## Tony Fischetti writes: "The problem with within_n_sds() is the mean 
## and standard deviation are so heavily influenced by outliers, their 
## very presence will compromise attempts to identify them using these 
## statistics. In contrast with within_n_sds(), within_n_mads() uses 
## the robust statistics, median and median absolute deviation, to 
## identify potentially erroneous data points."

penguins %>% 
  insist(within_n_mads(2), body_mass_g) %>% 
  group_by(species) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

## note that insist() + within_n_mads() found many more potential 
## outliers for body_mass_g (13 total) than the one extreme value we 
## introduced. Also note that insist() found the way too large value
## (7000) but not the value that was subtly too large for given species
## (5522) because only 7000 is large relative to median and SD of the
## entire dataset

hist(penguins$body_mass_g, nclass = 30)

## we would need to look at just the Adelie data to see the other 
## subtle outlier

hist(penguins$body_mass_g[penguins$species == "Adelie"], 
     nclass = 30)

## we can also see body_mass_g = 5522 is an outlier because it is too
## heavy given the flipper_length_mm of the individual

ggplot(data = penguins, 
       mapping = aes(x = flipper_length_mm, y = body_mass_g, 
                     colour = species)) + 
  geom_point(size = 2, position = position_jitter(w = 0.2, h = 0.2)) + 
  facet_wrap(~ species, nrow = 2, scales = "free") + 
  theme(legend.position = "none")

## these bivariate outliers can be identified with the Mahalanobis
## distance for each row

penguins %>% 
  insist_rows(maha_dist, within_n_mads(4), everything())

## rows 1 and 49 are the one's our gnome altered
## insist_rows() did not identify the typo, but did catch the -'ve value
## the other 3 (unaltered) rows may also be potential outliers


# (4) combining the preceding error checks --------------------------------

penguins %>%
  chain_start %>%
  verify(nrow(.) == 344) %>% 
  assert(within_bounds(0, Inf), 
         -c(species, speciesL, island, sex, year)) %>% 
  insist(within_n_mads(2), body_mass_g)  %>% 
  insist_rows(maha_dist, within_n_mads(4), everything()) %>% 
  chain_end %>% 
  group_by(Species) %>%
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

## the trick here is to wrap these checks between chain_start() and 
## chain_end(), otherwise `assertr` will stop at the first error


# (5) alternative ways to detect typos ------------------------------------

## (5.1) use the in_set() predicate of assert

penguins %>% 
  assert(in_set("adeliae", "antarctica", "papua"), speciesL) %>% 
  group_by(species) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

## stopped execution because it found 1 row for which the species value
## does not match with the defined list possible values


## (5.2) use grep() or grep1() to find cells with a specified string

grep("adeliae", penguins$speciesL)


## (5.3) Use stringdist::amatch() to find the closest match to a cell

species.list <- c("adeliae", "antarctica", "papua")

i <- adist(penguins$speciesL, species.list) %>% 
  apply(1, which.min)

(species.fixed <- data.frame(speciesL_original = penguins$speciesL, 
                             speciesL_repaired = species.list[i]))

## the above identifies the typo and proposes a correction
## we can then bind the corrected column onto our dataset
penguins <- cbind(penguins, species.fixed[2])


## (5.4) use a cluster diagram to visualize typos

dist.matrix <- stringdistmatrix(penguins$speciesL, penguins$speciesL, 
                                method = 'jw', p = 0.1)
row.names(dist.matrix) <- penguins$speciesL
names(dist.matrix) <- penguins$speciesL
dist.matrix <- as.dist(dist.matrix)
clusters <- hclust(dist.matrix, method = "ward.D2")
plot(clusters)


## (5.5) Use stringr::str_trim() to remove extra white spaces 

## we don't have an example of this sort of error in the dataset, but
## let's pretend one speciesL cell contains " antarctica " (with white 
## spaces both before and after the word)

## you could use the following to strip/trim the white space out:
# penguins <- penguins %>% 
#   mutate(speciesL = str_trim(speciesL, side = "both"))


# (6) correcting taxonomic names with the `taxize` package ----------------

## as Pygoscelis adeliae is a Latin species name, we could use 
## taxize::gnr_resolve() to correct the typo in this name:

## for example:
gnr_resolve(sci = 'Pygoscelis adelae') %>% View()

#We can also use taxize::classification() to resolve the higher 
## level taxonomy if it's not available

## for example: (this takes ~30 seconds)
classification("Pygoscelis adeliae", db = 'itis')

## this is the output from running the above:
# $`Pygoscelis adeliae`
#                  name         rank     id
# 1            Animalia      kingdom 202423
# 2           Bilateria   subkingdom 914154
# 3       Deuterostomia infrakingdom 914156
# 4            Chordata       phylum 158852
# 5          Vertebrata    subphylum 331030
# 6       Gnathostomata  infraphylum 914179
# 7           Tetrapoda   superclass 914181
# 8                Aves        class 174371
# 9     Sphenisciformes        order 174442
# 10       Spheniscidae       family 174443
# 11         Pygoscelis        genus 174444
# 12 Pygoscelis adeliae      species 174445

## check out the other database (db) options in the documentation
?classification()

## now, let's apply some of these data cleaning techniques to resolve
## issues in the BWG bromeliad database
## Go to the assignment on OSF: 

## -- ## -- ## -- ## -- ## END OF SCRIPT ## -- ## -- ## -- ## -- ##