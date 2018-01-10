## EXERCISE 1 ##

# library(ggplot2) # if plotting with ggplot
library(dplyr)
data('iris')

# 1. Plot Sepal.Length and Sepal.Width.


# 2. Calclate the mean, median, min, max, and variance of Sepal.Length and Sepal.Width. Show the output.


# 3. Make a boxplot of both Sepal.Length and Sepal.Width to visualize the summary statistics calculated above.


## EXERCISE 2 ##

# Translate the following into a model: "`iris` sepal length is determined by all other petal measurements, as well as the interaction 
# between sepal length and petal length." 
names(iris)


# Look at the other variables included in `mtcars`. Which of these do you think most influences the miles per gallon of a given model? 
# Write out a statement in your comments, then model this statement using proper notation.
data('mtcars')
names(mtcars)
head(mtcars)

## EXERCISE 3 ##
# Run a one-sided, two sample t-test to determine whether 8-cylinder cars get significantly lower mpg than 6-cylinder cars. 
# Make sure to take a look at your data to help you choose an appropriate alternative hypothesis.

six <- mtcars %>% filter(cyl == 6) # select only rows where cyl = 6
eight <- mtcars %>% filter(cyl == 8) # select only rows where cyl = 8

## EXERCISE 4 ##
# Let's go back to a familiar question: does the weight of a car affect its mpg? Run this linear model and extract the coefficients.


## EXERCISE 5 ##
# Run an ANOVA using the R diamonds dataset to test whether the color of a diamond affects its depth.
library(ggplot2) # weirdly, diamonds is part of the ggplot2 library
data('diamonds')


# Test whether the price of a diamond is affected by cut, color, and clarity.

