# http://r4ds.had.co.nz/data-import.html

library(tidyverse) #loads readr
library(readxl)

# import flat file
mood1 <- readr::read_csv('data/moods.csv')
View(mood1)

# skip lines
mood2 <- readr::read_csv('data/moods.csv', skip = 2)

# name columns
mood3 <- readr::read_csv('data/moods.csv', skip = 3, col_names = c('tomato', 'frog', 'dice'))

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

# Grand Tab Subset Cleanup -----------------------------------------------------

# 1 Read in raw data -----------------------------------------------------------

# 2. Inspect the data, what needs work? Formulate a plan to move forward ------- 
# use functions like View(), glimpse() and head() 

# 3. Rename the year column to facilitate work on it, use colnames() function 


# 4. The Plan: -----------------------------------------------------------------

#a. Collect headers into two vectors


#b. Combine the two headers, with a trick, and assign as new header (at the same time 
#   removing old headers)


#c. Gather headers into a column 


#d. seperate column to appropriate columns 


#e. resolve col type issues issues











#### Answers -------------------------------------------------------------------

# 1 ------------------------------------
grand_tab <- read_excel("raw-data/Grand_Tab.xlsx")

# 2 -----------------------------------
View(grand_tab) # view the data in spreadsheet form 
glimpse(grand_tab) # view details of each column 
summary(grand_tab) # get even more detailed view for each col 

# 3 ----------------------------------
colnames(grand_tab)[1] <- "year"

# 4 ----------------------------------
# a. 
river_reach <- colnames(grand_tab)
species <- grand_tab[1, ] %>% as.character()

# b.
rr_species <- paste(river_reach, species, sep="-")
rr_species <- str_replace_all(rr_species, "__1", "")
colnames(grand_tab) <- rr_species
grand_tab <- grand_tab[-1, ]

# c. 
grand_tab <- grand_tab %>% 
  gather("reach_and_species", value = "total_count", 
         `Sac_Mainstem-Fall_Run`:`Merced_River-Target_Fall_Run`) 

# d. 
grand_tab <- grand_tab %>% 
  separate(reach_and_species, into = c("reach", "species"), sep="-")


#e. 
colnames(grand_tab)[1] <- "year"

grand_tab$year <- as.character(grand_tab$year)
grand_tab$total_count <- as.numeric(grand_tab$total_count)











