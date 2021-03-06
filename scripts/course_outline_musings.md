Course Outline Musings
================

This is a word-vomit-style document to contain information and thoughts
about course development.

## Topics to Cover

### Intro to Data Science

-   “Let them eat cake” style demo at the beginning of class (see
    Ethan’s script)?
-   Reproducibility and open science
-   Data management best practices
-   Spreadsheet best practices (flows well into tidy data)
-   Long vs. wide data styles
-   Interacting with files on the computer (turns out my undergrads DO
    NOT know how to download files from the internet and save them to a
    specific location on their computer, which is mind-blowing to me)
-   File paths (imperative)
-   Metadata

### Intro to R/RStudio

-   RProjects
-   Differences between R and RStudio; intro to RStudio
-   R Basics: object-oriented, assignment, vectors, subsetting
-   Working with data in R: intro to data frames/tibbles
-   functions and how to use them
-   help files and how to read them
-   how to de-bug code

### Intro to `tidyverse`

-   What is the `tidyverse` and why use it?
-   Intro to pipes
-   `dplyr`
    -   Filter, select
    -   Mutate, group_by, summarize
-   `tidyr`
    -   Separate/unite
    -   Pivot wider/pivot longer
-   `stringr`
-   `lubridate`

### Data Visualization

-   data viz best practices
-   which viz go with which data types
-   colors, effectively and efficiently conveying information
-   intro to ggplot

### Iteration

-   writing your own functions
-   for loops
-   `purrr`? I don’t understand `purrr` very well, tbh

## Misc. Topics

-   RMarkdown
-   other types of data, like spatial or genetic?

## Course Style, etc.

Lots of discussion about “modular” course development, especially with
shift online.

It would make the course far more versatile: \* Timing: able to be
taught over a semester, a condensed 7.5 or 10 week course, summer class,
etc. \* Mode: able to be taught asynchronously online, synchronously
online, synchronously in-person… \* Easy to cut a module here or there
to fit teachers’ needs

Possible downside with modular style is that it might be harder to make
the course have a final “overall project”? Actually, maybe not. Each
module could include a major part of the assignment that would be part
of the final project. Should we even be thinking about assignments or is
that too far?

If we go with modular development, do we suggest RProject per module or
one for overall course with module folders?

RStudio Cloud? Definitely don’t want to assume that people will be using
it (I won’t), but maybe we should include instructions for doing so?
Reference the possibility of it, at a minimum.
