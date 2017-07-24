# http://r4ds.had.co.nz/functions.html
# Regex cheat sheed https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf

# When to use a function? 
# See http://r4ds.had.co.nz/functions.html#when-should-you-write-a-function

# Creating a Function ----------------------------------------------------------
# 1. Pick a name for the function, generally a verb
# 2. A list of inputs (arguments) to the function inside "function()"
# 3. Place the code you have developed in the body of the function between "{}"

# Ex 1 -----
# Here I "Create" a function, running the code makes it available for me to use
add_two <- function(x){
  return(x)
}

# Check the environment list, you will see the function listed
# Here I invoke the function with a specific parameter for x
add_two(10) # 12 
add_two(-2) # 0

# the order of creating -> running -> and invoking is important
# changing the function even slightly requires running it again

# Ex 2 ---- 
# A function with two arguments
add <- function(x, y) {
  return(x+y)
}

add(2, 3)
add(3, 4)

# Function Conventions ---------------------------------------------------------
# Function should be easy for humans to read (at least yourself 2 months from now)
# Names should be descriptive

# Too short, no desciption
f <- function(x) {
  return(sample(1:100, x, replace = TRUE))
} 

# much better 
sample_from_100 <- function(x) {
  return(sample(1:100, x, replace = TRUE)) 
}

# Argument Names ---
# Argument Names are also very important here are suggestions for names:
# x, y, z for vectors
# df for a data frame
# i, j for numeric indices
# n for length or number of rows
# p for number of columns

# Conditional Excecution ------------------------------------------------------- 
# We can control what is executed within a function using if/else statements

# Return TRUE when a given number is odd
is_odd <- function(x) {
  if (x %% 2 == 0) {
    return(FALSE)
  } else {
    TRUE
  }
}

is_odd(1)
is_odd(12)
is_odd(1.1)
is_odd(12.1)

# looks like its taking the whole number part first then running the code
# it is a good idea to defend against this type of exectution

# First confirm an integer was supplied, then execute is_odd logic
is_odd2 <- function(x) {
  if ((x%%1) != 0) stop("Supplied argument must be an integer")
  if (x %% 2 == 0) {
    return(FALSE)
  } else {
    TRUE
  }
}

is_odd2(1)
is_odd2(12)
is_odd2(1.1)
is_odd2(12.1)

# Ex 3 -----
# We have some file names in the folder raw-data/function_examples
# we need to process through and extract station id's, starting and ending date.
# Lastly we want to make a tidy frame out of this information
# we could go in do so by hand, but assume there are 100's of these

# Plan is to extract one name for which we can perform operations on. 
# Once we have accomplished our goal in this single instance, we will 
# write the logic for doing so in a function, and apply it to the rest 
# of the items.


#1. Bring in the filenames as vectors into R
# here we use a function list.files() 
#?list.files for more information
file_names <- list.files("raw-data/function_examples/", 
                         pattern = ".xlsx")
  
#2. Grab a single instance of a filename and extract data
test <- file_names[1]
library(stringr) # library helps us manipulate strings 
# Get station name
stringr::str_sub(test, 1, 4)
stringr::str_extract(test, "Ar[0-9][0-9]")
# Get starting date and end date
stringr::str_sub(test, 6, 15) #start
stringr::str_sub(test, 17, 26) #end
stringr::str_extract_all(test, "[0-9]{4}-[0-9]{2}-[0-9]{2}") #both

# we have what we need, so we place all this code in a function 

#3 Function creation 
parse_gage_filename <- function(f) {
  station_id <- stringr::str_sub(f, 1, 4)
  starting_date <- stringr::str_sub(f, 6, 15)
  ending_date <- stringr::str_sub(f, 17, 26)
  
  #TODO Its a good idea to make these into the correct type
  #in here, for example as_date(starting_date)
  
  data.frame(station_id=station_id, 
             starting_date=starting_date, 
             ending_date=ending_date)
}

out_df <- data.frame()
for (file in file_names) {
  out_df <- dplyr::bind_rows(out_df, parse_gage_filename(file))
}






















