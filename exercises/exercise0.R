# This is an R script! It is a very simple one, just to make sure R is running fine in your computer.

# Lets install packages that will be used later in the course.

# Since this may be the first time you are downloading a package, you may have to choose a mirror. The mirror USA (CA 1) is a server in Berkeley, so it will be the fastest connection (not that it will make any real difference to use other mirrors)

install.packages("tidyverse")

# Now lets load one of those libraries:
library(ggplot2)

# You shouldn't get any errors so far. You may have received a warning message after running the last line in case your R version is not the most up-to date, but this is not a problem in most of the cases.

# Lets test if the graphs are working fine. This will produce a simple plot of gas consuption in a city versus in the highway from the dataset `mpg`.
ggplot(mpg, aes(x = cty, y = hwy)) +
 geom_point() 
 
# If you got any errors feel free to contact any of the instructors. 