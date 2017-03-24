# Class 1 - Tidy Data
# http://r4ds.had.co.nz/tidy-data.html

#-------------------------------------------------------------------------------
# install a series of packages that make analysis easier
# more info here: https://blog.rstudio.org/2016/09/15/tidyverse-1-0-0/
install.packages('tidyverse')

# attach libraries
library(readr)
library(dplyr)
library(tidyr)

# about our dataset
?iris

# take a look-------------------------------------------------------------------
# column names, data type and first fews values printed to console
dplyr::glimpse(iris)

# table opened in new tab
View(iris)

# There are three interrelated rules which make a dataset tidy:
# 1. Each variable must have its own column.
# 2. Each observation must have its own row.
# 3. Each value must have its own cell.

# Exercise 1
# identify: variables, obseravitons, values
# how should this data be rearranged to make it tidy?
# what will the new column names be?

#-------------------------------------------------------------------------------
# before we start using functions, let's learn about the pipe, %>%. %>% enables us
# to chain together mutiple function calls, passing the result of one function 
# as the input to the next function. this increases code legibility and helps
# focus your thinking during data wrangling and analysis. 
# shortcut key : Ctrl + Shift + m

# Gathering is used to fix the problem of column names that are values of a variable
# example: city | 1999 | 2000 | 2001
# 1999 - 2001 are year values and there should be a column (variable) named year

# tidyr::gather()
?gather

clean_iris <- gather(data = iris, 
                     key = flower_att, 
                     value = measure_cm, 
                     Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)

glimpse(clean_iris)

# with pipes 
iris %>%
  gather(key = flower_att, 
         value = measure_cm, 
         Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) %>% 
  View()

# Spreading is used when observations are scattered across multiple rows,
# opposite of gather

# tidyr::spread()
?spread

df <- data.frame(row = rep(c(1, 51), each = 3),
                 var = c("Sepal.Length", "Species", "Species_num"),
                 value = c(5.1, "setosa", 1, 7.0, "versicolor", 2))
View(df)

df %>% spread(var, value) %>% str()

df %>% spread(var, value, convert = TRUE) %>% str()

df %>% spread(var, value, convert = TRUE) %>% View()

# write clean data out into a csv-----------------------------------------------
write_csv(clean_iris, 'data/clean_iris.csv')

# or write clean data out to a rds----------------------------------------------
# conserve r data types
write_rds(clean_data, 'data/clean_iris.rds')

# learn about separate and unite on your own