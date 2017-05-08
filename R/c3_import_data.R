# http://r4ds.had.co.nz/data-import.html

library(tidyverse) #loads readr
library(readxl)

# import flat file
mood1 <- readr::read_csv('data/moods.csv')
View(mood1)

# skip lines
mood2 <- readr::read_csv('data/moods.csv', skip = 2)

# name columns
mood3 <- readr::read_csv('data/moods.csv', skip = 2, col_names = c('tomato', 'frog', 'dice'))

# define missing values format
moods <- readr::read_csv('data/moods.csv', skip = 2, na = 'n/a')

# read.csv() vs read_csv()
# 
# They are typically much faster (~10x) than their base equivalents. Long
# running jobs have a progress bar, so you can see what’s happening. If you’re
# looking for raw speed, try data.table::fread(). It doesn’t fit quite so well
# into the tidyverse, but it can be quite a bit faster.
# 
# They produce tibbles, they don’t convert character vectors to factors, use row
# names, or munge the column names. These are common sources of frustration with
# the base R functions.
# 
# They are more reproducible. Base R functions inherit some behaviour from your
# operating system and environment variables, so import code that works on your
# computer might not work on someone else’s.

# parsing funky numbers
parse_double("1.23")
parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")

rando1 <- readr::read_csv('data/rando.csv')

# specify column parsing
rando <- readr::read_csv('data/rando.csv', 
                col_types = cols(
                  money = col_number(), 
                  dog = col_character(), 
                  date = col_date(format = '%m/%d/%y')))

# write_csv(rando, 'rando.csv')

readxl::excel_sheets()
readxl::read_excel()
