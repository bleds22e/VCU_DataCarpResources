##### INTRO TO PLOTTING WITH GGPLOT2 #####
# ggplot2 overview: https://ggplot2.tidyverse.org/
# ggplot2 extensions: https://exts.ggplot2.tidyverse.org/gallery/
# Data Carpentry ggplot lesson: 
#     https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html

# PACKAGES AND DATA #
library(tidyverse)

data2017 <- read_csv("https://raw.githubusercontent.com/bleds22e/FAST_lab_training/master/data/dugout2017.csv")
data2019 <- read_csv("https://raw.githubusercontent.com/bleds22e/FAST_lab_training/master/data/dugout2019.csv")

# DATA PREP ####

# Let's make the dataframes more manageable by selecting only the columns we want
# We'll be using Site_ID, Date, pH, CO2, and Landuse
# Check each column for any issues

data2017 <- data2017 %>% 
  select(Site_ID, Date, Surface_pH, pCO2, Landuse) %>% # columns we want
  mutate(Date = lubridate::dmy(Date)) %>% # convert Date to date col type
  mutate(Year = as.factor(lubridate::year(Date))) # make Year column 
  # the factor part means Year will be treated as a categorical variable (rather than numeric value)

data2019<- data2019 %>% 
  select(Site_ID = Site, Date, Surface_pH, pCO2) %>% 
  mutate(Date = lubridate::dmy(Date)) %>% 
  mutate(Year = as.factor(lubridate::year(Date)))

# add landuse column to 2019 data
# note that data2019 still only has 93 rows
#   - didn't add any additional rows because we left-joined into data2019
#   - any sites not sampled in 2017 have an NA in the landuse column
landuse <- select(data2017, Site_ID, Landuse)
data2019 <- left_join(data2019, landuse)

# bind data frames together in long format
data_all <- bind_rows(data2017, data2019) %>% 
  drop_na()

# PLOTTING WITH GGPLOT2 ####

# general structure:
# ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  
# <GEOM_FUNCTION>()

# check axes -- but where are the data?
ggplot(data = data_all, mapping = aes(x = Surface_pH, y = pCO2)) 

# add in geoms
ggplot(data = data_all, mapping = aes(x = Surface_pH, y = pCO2)) + 
  geom_point()

# build plots iteratively
pH_CO2 <- ggplot(data = data_all, 
                 mapping = aes(x = Surface_pH, y = pCO2))
pH_CO2 +
  geom_point()

# can start modifying the plot
ggplot(data = data_all, mapping = aes(x = Surface_pH, y = pCO2)) + 
  geom_point(alpha = 0.5)

# change colors
ggplot(data = data_all, mapping = aes(x = Surface_pH, y = pCO2)) + 
  geom_point(alpha = 0.5, color = "dark green")

# if we want to specify that something (color, point shape, etc.) changes with 
# a certain variable, we specify that within the aes() function
ggplot(data = data_all, mapping = aes(x = Surface_pH, y = pCO2)) + 
  geom_point(alpha = 0.5, aes(color = Landuse))

ggplot(data = data_all, mapping = aes(x = Surface_pH, y = pCO2)) + 
  geom_point(alpha = 0.5, aes(color = Landuse)) +
  scale_y_log10() # can adjust axes within the plot

ggplot(data = data_all, mapping = aes(x = Surface_pH, y = pCO2)) + 
  geom_point(aes(color = Landuse)) +
  geom_hline(yintercept = 400) + # can add lines for annotating plots (but also data)
  scale_y_log10()
  
# OTHER GEOMS #

# boxplot
ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_boxplot()

# add points to give a better idea of distribution
ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_boxplot() +
  geom_point()

# change alphas
ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_boxplot(alpha = 0) +
  geom_point(alpha = 0.5)

# change to jitter (and tomato to show that order matters)
ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_boxplot(alpha = 0) +
  geom_jitter(color = "tomato")

# re-order
ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_jitter(color = "tomato") +
  geom_boxplot(alpha = 0)

# can change axes here, too
ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_jitter(color = "tomato") +
  geom_boxplot(alpha = 0) +
  scale_y_log10()

# violin plots
ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_jitter(color = "tomato") +
  geom_violin(alpha = 0)

### CHALLENGE ###
# Make a box plot (with blue points) of pH by year
ggplot(data_all, aes(x = Year, y = Surface_pH)) +
  geom_jitter(width = 0.25, color = "blue") +
  geom_boxplot(alpha = 0)
###


# FACETING #
# splits one plot into multiple panels based on a variable

ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_wrap(facets = vars(Landuse)) # facet wrap for 1 variable

# split by year within a single plot
ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point(aes(color = Year)) +
  facet_wrap(facets = vars(Landuse)) 

# we can convey the same thing by faceting by both variables
# with 2 variables, we have to use facet_grid
# can also rows or cols argument alone
ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_grid(rows = vars(Year), cols = vars(Landuse)) 
  # old syntax that you might see is facet_grid(Year ~ Landuse)

# if you want to keep the separate colors, you can
ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point(aes(color = Year)) +
  facet_grid(Year ~ Landuse)

# THEMES #
# adjusting other parts of the plots

ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_wrap(facets = vars(Landuse)) + 
  theme_bw()
# many others, like theme_minimal, theme_light, theme_void

# adjust labels
ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_wrap(facets = vars(Landuse)) + 
  labs(title = "Relationship between pH and CO2 by Land Type",
       x = "pH") +
  theme_bw()

# changing size, etc. using theme()
ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_wrap(facets = vars(Landuse)) + 
  labs(title = "Relationship between pH and CO2 by Land Type",
       x = "pH") +
  theme_bw() +
  theme(text = element_text(size = 16))

# or can be more specific with theme(axis...)
ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_wrap(facets = vars(Landuse)) + 
  labs(x = "pH") +
  theme_bw() +
  theme(axis.title = element_text(size = 16))

# can save theme as its own thing and add to plots
my_theme <- theme(axis.title = element_text(size = 16),
                  text = element_text(face = "bold"))

ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_wrap(facets = vars(Landuse)) + 
  labs(x = "pH") +
  theme_bw() +
  my_theme

# PATCHWORK #
# stitching multiple plots together 
# one of MANY ways (see cowplot, ggpubr, etc.)

# install.packages("patchwork")
library(patchwork)

plot1 <- ggplot(data = data_all, mapping = aes(x = Landuse, y = pCO2)) + 
  geom_jitter(color = "tomato") +
  geom_violin(alpha = 0)

plot2 <- ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  facet_wrap(facets = vars(Landuse)) + 
  theme_bw()

plot1 + plot2
plot1 + plot2 + plot_layout(widths = c(3, 1))
plot1 / plot2

# GGSAVE #

ggsave("figures/plot1.png", plot1, width = 7, height = 7)
ggsave("figures/plot3.png") # will save the latest plot if you don't specify

# ~OTHER STUFF~ #

# geom_line() for line plots (often with time-series data) #
# very quick demonstration of geom_line
# not an ideal example but at least you can see what a plot looks like
site10 <- data_all %>% 
  # filter the Site_ID column to only pull out these 4 site IDs
  filter(Site_ID %in% c("10A", "10B", "10C", "10D"))

ggplot(data = site10, aes(x = Date, y = Surface_pH)) + 
  geom_line(aes(color = Site_ID))

# Legends #
# adjusting legends can be tricky...
# here are a few examples (I honestly had to google 2 of them...)

# if we want the legend title to say "Site ID" instead of "Site_ID", we can
# add the following line of code. Basically, we created the need for a legend by
# saying that color should vary by Site_ID, so in the labels function, we are 
# saying that the label for the thing determined by color should be called "Site ID"
# I often forget this and sometimes just end up renaming the column to what I 
# want the legend title to be!
ggplot(data = site10, aes(x = Date, y = Surface_pH)) + 
  geom_line(aes(color = Site_ID)) +
  labs(color = "Site ID")

# if you want to change the position of the legend, you do so in theme()
ggplot(data = site10, aes(x = Date, y = Surface_pH)) + 
  geom_line(aes(color = Site_ID)) + 
  theme(legend.position = "bottom")

# if you want to be rid of the legend entirely, set position to "none"
ggplot(data = site10, aes(x = Date, y = Surface_pH)) + 
  geom_line(aes(color = Site_ID)) +
  theme(legend.position = "none")

# to get rid of the legend title only, use element_blank()
ggplot(data = site10, aes(x = Date, y = Surface_pH)) + 
  geom_line(aes(color = Site_ID)) +
  theme(legend.title = element_blank())

# Reordering Data or Panels #

# summarize data to make a bar plot
(data_summary <- data_all %>% 
  group_by(Landuse, Year) %>% 
  summarise(mean_pH = mean(Surface_pH),
            st.dev_pH = sd(Surface_pH)))

# plot
ggplot(data_summary, aes(x = Landuse, y = mean_pH, fill = Year)) + # fill means the column colors are determined by year
  # geom_col (aka column) gives vertical bars; geom_bar gives horizontal
  geom_col(position = "dodge") + # dodge means the years are next to each other rather than stacked
  geom_errorbar(aes(ymin = mean_pH - st.dev_pH, ymax = mean_pH + st.dev_pH),
                width = 0.25,
                position = position_dodge(0.9))
  
# to reorder the columns based on value, you have to reorder the data frame
# the best way to do with is by changing the levels of your factors
# I highly recommend reviewing factors here: https://datacarpentry.org/R-ecology-lesson/02-starting-with-data.html
# You can do this for each level individually or, if you have a bunch, you might
# want to use arrange/reorder and then reassign the factors
data_summary$Landuse <- factor(data_summary$Landuse, 
                               levels = c("Pasture-livestock", "Grassland",
                                          "Crop", "Domestic"))

ggplot(data_summary, aes(x = Landuse, y = mean_pH, fill = Year)) + 
  geom_col(position = "dodge") +
  geom_errorbar(aes(ymin = mean_pH - st.dev_pH, ymax = mean_pH + st.dev_pH),
                width = 0.25,
                position = position_dodge(0.9))

# Changing Font Face #

ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  theme_bw()

# if you want the whole label to be a specific font type, you can change that
# in the theme function
ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  theme_bw() +
  theme(axis.title.y = element_text(face = "bold"),
        axis.title.x = element_text(face = "italic"))

# if you want to change only part of an axis title, you can use expression()
x_axis_title <- expression(paste("Surface ", bold("pH")))
y_axis_title <- expression(pCO[2])
  # use [] for subscript and ^ for superscript
  # you can put the expression() code directly into the xlab() or ylab() function,
  # but I like to keep them separate if they are particularly complicated

ggplot(data_all, aes(x = Surface_pH, y = pCO2)) +
  geom_point() +
  xlab(x_axis_title) +
  ylab(y_axis_title) +
  theme_bw()
