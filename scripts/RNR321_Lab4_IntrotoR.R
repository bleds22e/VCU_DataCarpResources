# Lab 4: Introduction to R
# Introduce RProjects, practice coding with `swirl`, and Assignment 4
# EKB; February 2022

# Global settings-----------------------------------------------------------####

# We want to make our work as reproducible as possible. In order to do this, we
# want to make sure R/RStudio doesn't save the objects and data and such when
# we close it. Everything we will need next time we open RStudio should be in
# a script!

# Go to Tools > Global Options > General
# Under "Workspace," uncheck "Restore .RData into workspace at startup"
# Set "Save workspace to .RData on exit" to "Never"

# For fun:
# You can change the colors in RStudio!
# In Global Options, if you go to Appearance, you can select the "Editor Theme"
# I personally use "Idle Fingers"

# RProjects-----------------------------------------------------------------####

# RProjects are a fabulous way to interact with R/RStudio. They keep everything
# neatly in one place and help you (and your collaborators...or graders) easily
# run your code without having to deal with cumbersome file path issues!

# RProjects automatically set the "working directory" for you to the folder with
# the RProject, so everything is referenced from that point. And you always know
# what the working directory is! 

# I recommend making a project for each module. 

# To make an RProject, go to the File Menu and select New Project.
# Choose "New Directory" and then "New Project."
# Give the project a name, such as "Module2"
# Make sure you put your RProject somewhere where you can find it again. If you 
# have a folder for this class already, that would be an ideal place!

# Once you've set up your RProject, add some folders. I recommend the following:
#   * data_raw
#   * data_clean
#   * scripts
#   * output
#   * documents
# Remember that R is case sensitive, so it matters whether your folders start
# with capitals or lowercase!

# Sometimes, you will just need to submit a script or other file for your 
# assignments. Many times, though, you will need to submit your whole RProject
# so we can run your code with the data and correct file paths.

# To submit a entire RProject, you will need to save the folder containing the
# RProject (and associated folders within) as a Zip file. You can do this by going
# to that folder through your file viewer, right-clicking on the folder, and
# selecting "Send to" then "Compressed (zipped) folder" (Windows) or 
# "Compress 'folder_name'" (Mac).

## If you are using RStudio Cloud: ##
# RStudio Cloud automatically works in RProjects, which is helpful.
# Create folders by clicking the "New Folder" button in the "Files tab in the 
# lower right-hand corner.
# To upload scripts/data to your project, click "Upload," next to "New Folder".

# From the RStudio Cloud site:
# https://rstudio.cloud/learn/guide#project-export
# "Export Project
# The contents of a project can be downloaded without opening the project.
# 
# HOW TO
# Press the Export action for the project that you wish to download. 
# A dialog box will appear showing the progress of your export. The process can 
# take anywhere from a few seconds to a couple of minutes, depending on the size
# of the project, and how recently it was opened.
# Once the export is complete, press the Download button in the dialog box to 
# download your project."

# Swirl---------------------------------------------------------------------####

# Install, load, and run Swirl
install.packages("swirl")
library(swirl)
swirl()

# Select the "R Programming" option by typing 1 in the console and hitting enter
# Work your way through lessons 3, 6, and 7.
# When it asks if you want credit on Coursera, select no. 

# To leave Swirl, type 0 into the console and hit Enter

# REMINDER! #
# In the console, you hit Enter to run the line of code
# In your script (like this), hitting Enter takes you to a new line but does
# not run the line of code. 
# In order to run the line of code (AKA send it to the console), you need to
# do Ctrl + Enter (Windows) or Cmd + Enter (Mac)

# Assignment 3--------------------------------------------------------------####

# Assignment 3 combines what we've learned in class and in the `Swirl` lessons 
# you worked through in lab today. 

# Remember, you can refer to useful references in the "Lectures" section of 
# Module 2 on D2L, such as the Intro_to_R powerpoint and IntrotoR.R script