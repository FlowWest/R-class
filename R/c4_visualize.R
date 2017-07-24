# http://r4ds.had.co.nz/data-visualisation.html
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

library(tidyverse)

glimpse(ggplot2::mpg)

?ggplot
?geom_point

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point()

# Mappings ----------------------------------------------
# aes (aesthetics) include things like the size, shape, or color 
# Once you map an aesthetic, ggplot2 takes care of the rest. It selects a
# reasonable scale to use with the aesthetic, and it constructs a legend that
# explains the mapping between levels and values.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = class)) +
  geom_point()

mpg %>% 
  ggplot(aes(x = displ, y = hwy, size = class)) +
  geom_point()

mpg %>% 
  ggplot() +
  geom_point(aes(x = displ, y = hwy, alpha = class))

mpg %>% 
  ggplot() +
  geom_point(aes(x = displ, y = hwy, shape = class))

# set aesthetic manually
mpg %>% 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(color = 'blue')

# facets - subplots that each display one subset of the data
# the first argument of facet_wrap() should be a formula, which you create with ~ followed by a variable name
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# To facet your plot on the combination of two variables, add facet_grid() 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# Geometries -----------------------------

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy,color = drv))

# you can set the group aesthetic to a categorical variable to draw multiple objects
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# To display multiple geoms in the same plot, add multiple geom functions to ggplot()
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# If you place mappings in a geom function, ggplot2 will treat them as local
# mappings for the layer. It will use these mappings to extend or overwrite the
# global mappings for that layer only. This makes it possible to display
# different aesthetics in different layers.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

# You can use the same idea to specify different data for each layer
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# common geoms ---------
# histogram
ggplot2::diamonds %>% 
  ggplot(aes(x = cut, color = clarity)) +
  geom_bar()

#position adjustment
ggplot2::diamonds %>% 
  ggplot(aes(x = cut, fill = clarity)) +
  geom_bar(position = 'dodge')

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# deal with over plotting
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter") # or geom_jitter

# coordinate systems ------------------------------------
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()








