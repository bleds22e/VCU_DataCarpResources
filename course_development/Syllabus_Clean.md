Syllabus
================
Ellen Bledsoe
2023-03-05

# Data Carpentry for Undergraduate Biology Students

## Course Description

Data are essential to the study of ecology and the environment. Big data
(such as data generated by satellites orbiting Earth, billions of
biological specimens in natural history museums, and thousands of
wildlife camera photographs, to name a few) are disrupting a wide range
of industries from human health and environmental monitoring to
conservation and government policy. The explosion of data is providing
unprecedented opportunities for new discovery and applications. As a
result, data skills are in high demand for entering data without errors,
storing it in a usable and transparent way, extracting key aspects of
the data for analysis, and creating accessible visual representations of
large and complex datasets. This course will provide an introduction to
fundamental data skills with an emphasis on environmental and ecological
datasets. Class will typically consist of short introductions or
question and answer sessions, followed by hands on exercises. The course
will be taught using R (a popular programming language) and other data
tools. No background in programming or data skills is required.

## Course Purpose

In this course you will learn fundamental data skills for research, for
management and policy decisions, and for general data management in a
variety of career settings. By the end of the course you will be able to
develop a well-structured database, import data into R, use logical
thinking to write computer programs to analyze data, and produce well
designed data visualizations.

## Course Learning Outcomes

By the end of this course, you will be able to do the following:

- Apply best practices with **spreadsheets** to reduce potential data
  entry errors
- Execute **R code** to extract information from 1- and 2-dimensional
  data
- Communicate information effectively through **descriptive statistics**
  and **data visualizations**
- Implement skills to produce **tidy data** and combine **relational
  datasets**
- Use **iteration** in code for repetitive tasks
- Create a **computationally reproducible** research project

## Modular Structure

This course is developed as a modular course, designed to be flexible in
terms of scheduling and order. While some basic concepts of coding in R
are required for the final 3 modules, all modules are designed to be
effectively stand-alone modules that can be moved around, shortened or
expanding, and generally adapted as desired.

The modules are as follows:

- **Module 1: Data, Data, Everywhere**
  - What are data, how do we talk about them, and how to we put them
    into spreadsheets?
- **Module 2: Welcome to R World**
  - Introduction to R, RStudio, RProjects, and the `tidyverse`
- **Module 3: Visualizing Your Data**
  - Key concepts in data visualization, when to use what type of
    visualization, and `ggplot2`
- **Module 4: Data W(R)angling and (R)elational Data**
  - Dealing with messy data and bringing datasets together
- **Module 5: Becoming Computationally (L)Iterate**
  - How to repeat the same task many times and make choices

### Module 1: Data, Data, Everywhere

#### Module 1 Learning Outcome

Apply best practices with **spreadsheets** to reduce potential data
entry errors.

#### Week 1: What is Data?

- Types of data (categorical vs. continuous, qualitative
  vs. qualitative, numeric vs. non-numeric)
- What is data science, and why is it important?
- What is open science, and why is it important?
- What is computational reproducibility?

#### Week 2: Structuring Data in Spreadsheets

- Best practices for using spreadsheets
- Making data human- and computer-readable

#### Week 3: Data Entry and QA/QC in Spreadsheets

- Data Validation for Quality Assurance and Control (QA/QC)
- Using “Filter” and “Sort” responsibly for data cleaning
- Double-entry for catching data entry errors

### Module 2: Welcome to R World

#### Module 2 Learning Outcome

Execute **R code** to extract information from 1- and 2-dimensional
data.

#### Week 4: Intro to R/RStudio

- What is R? How is it different from RStudio?
- File paths and good file structure
- Working directories and RProjects

#### Week 5: Intro to Coding in base R

- Object-oriented language
- Data classes in R and why they matter
- Working with 1-dimensional data (vectors)
- Functions, arguments, and how they work
- Working with 2-dimensional data (data frames)

#### Week 6: Intro to the `tidyverse`

- `tidyverse` syntax
- `filter()` and `select()`
- the pipe
- `group_by()`, `summarize()`, and `mutate()`

### Module 3: Data Visualization

#### Module 3 Learning Outcome

Communicate information effectively through **descriptive statistics**
and **data visualizations.**

#### Week 7: Descriptive Statistics & Data Visualization

- measures of central tendency, measures of dispersion
- principles of effective data visualization
- types of data visualization and when to use them

#### Week 8: Plotting with `ggplot2`

- making the types of plots we talked about the week before
- structure of a ggplot (geoms, themes)

#### Week 9: Customizing Plots with `ggplot2`

- How does `aes()` really work (e.g., color, fill, etc.)?
- Faceting
- Adding multiple layers
- Writing better axes labels

### Module 4: Data W(R)angling and (R)elational Data

#### Module 4 Learning Outcome

Implement skills to produce **tidy data** and combine **relational
datasets.**

#### Week 10: Making Un-tidy Data Tidy with `tidyr`

- Often we are working with data from other people that is messy
- Long vs. wide data (`pivot_wider` and `pivot_longer`)
- Dealing with missing data
- `separate()` and `unite()`

#### Week 11: Working with the Nitty-Gritty

- Working with tricky data, such as strings (`stringr`) and dates and
  times (`lubridate`)

#### Week 12: Joining Related Data

- relational databases (primary keys)
- `dplyr` joins

### Module 5: Becoming Computationally (L)Iterate

#### Module 5 Learning Outcome

Use **iteration** in code for repetitive tasks.

#### Week 13: Iteration

- For Loops
- If/else statements (and `case_when()` for multiple options)

#### Week 14: Building Functions

- The power of writing your own functions

#### Week 15: Iterating with `purrr`

- Alternatively, an open week to wrap up projects

## Assessments

There are four assessment types in this course: homework, assignments,
reflections, and a final project.

### Grading Breakdown

| Assessment         | Number | Points | Total Points | Grade Percentage |
|--------------------|:------:|:------:|:------------:|:----------------:|
| Homework           |   14   |   10   |     140      |       28%        |
| Assignments        |   12   |   20   |     240      |       48%        |
| Reflection         |   5    |   5    |      25      |        5%        |
| Final Project:     |        |        |              |                  |
| Proposal           |   1    |   10   |      10      |        2%        |
| Data Visualization |   1    |   10   |      10      |        2%        |
| Draft              |   1    |   25   |      25      |        5%        |
| Final Version      |   1    |   50   |      50      |       10%        |
| **TOTAL**          |        |        |     500      |       100%       |

### Homework

Each week (except the final week), there will be homework assignments.
These will be assigned after class on Wednesdays, and we will go over
the answers together on Fridays during class. Homework is due Thursday
at midnight.

Homework assignments are worth 10 points each. The first 5 points are
based on full attempts/completion only. The remaining 5 points are based
on corrections and are due at the end of each module.

### Assignments

Assignments are where you put into practice the skills that you have
learned during each week. Assignments are each worth 20 points.
\[Assignments can either be due a week after they are assigned or all at
the end of a module\].

### Reflections

Spending time to reflect on how each module went—what worked well, what
you can do to help yourself learn, what was tricky to understand—is
helpful for both you as a student and me as the professor. Reflections
are worth 5 points and are due at the end of each module.

### Final Project

In lieu of a final exam in the course, there is a final project. In the
final project, you will choose from a list of datasets and come up with
a hypothesis-driven question to tackle with your newly acquired data
science skills! In total, your final project is worth 95 points.

Throughout the semester, you will submit a final project proposal (10
points, graded for completion), a final project data visualization draft
(10 points, graded for completion) and a final project draft (25 points,
graded for completion) to get feedback along the way.

The final version of your final project should incorporate the feedback
you’ve received throughout the semester on your proposal, data
visualization, and draft. It will be worth 50 points.