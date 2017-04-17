# http://r4ds.had.co.nz/transform.html

# attach dplyr
library(dplyr)

# dataset
install.packages('nycflights13')
library(nycflights13) 
?flights
glimpse(flights)

# dplyr basics-------------------------------------------------
# Pick observations by their values (filter()).
# Reorder the rows (arrange()).
# Pick variables by their names (select()).
# Create new variables with functions of existing variables (mutate()).
# Collapse many values down to a single summary (summarise())

# filter--------------------------
# select rows based on condition
filter(flights, month == 1, day == 1) #prints result
jan1 <- filter(flights, month == 1, day == 1) #assigns result
(dec25 <- filter(flights, month == 12, day == 25)) #prints and assigns result

# Comparisons and Logical Operators--------------------------------
# >, >=, <, <=, != (not equal), and == (equal).
# & is “and”, | is “or”, and ! is “not”

# %in%-----------------------------------------
filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))

# missing values NA (not availables)------------------------
# NA is contagious
NA > 5
NA + 10
NA == NA

# use is.na() to find missing values
x <- NA
y <- 3
is.na(c(x,y))

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# arrange------------------------------------------------------
# sorts rows
# each additional column will be used to break ties in the values of preceding columns
arrange(flights, year, month, day)
# re-order by a column in descending order
arrange(flights, desc(arr_delay))

# select-------------------------------------------------------
# select columns by name
select(flights, year, month, day)

select(flights, year:day)

select(flights, -(year:day))

# mutate------------------------------------------
# add new columns that are functions of existing columns
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

# you can refer to columns that you’ve just created
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

#  only want to keep the new variables
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)

# summarise-----------------------------------
summarise(flights, delay = mean(dep_delay, na.rm = TRUE)) # single record

# grouped summaries
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# use %>% to combine multiple operations ------------------------------
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")
