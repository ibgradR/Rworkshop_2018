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
library(ggplot2) # weirdly, diamonds is part of the ggplot2 library; load here if you haven't yet!
data('diamonds')


# Test whether the price of a diamond is affected by cut, color, and clarity.

## ANSWERS ## 

## EXERCISE 1 ##

# library(ggplot2) # if plotting with ggplot
library(dplyr)
data('iris')

# 1. Plot Sepal.Length and Sepal.Width.

plot(iris$Sepal.Length, iris$Sepal.Width, pch = 21, bg = 'dodgerblue', xlab = 'sepal length', ylab = 'sepal width')
# or
ggplot(data = iris, aes(Sepal.Length, Sepal.Width)) + geom_point(alpha = 0.8, size = 3, pch = 21, fill = 'dodgerblue') + theme_bw()

# 2. Calclate the mean, median, min, max, and variance of Sepal.Length and Sepal.Width. Print the output.
stats <- iris %>% summarise_at(vars(starts_with('Sepal')), funs(mean, median, min, max, var))
stats

# or

iris %>% select(starts_with('Sepal')) %>% summarise_each(funs(mean, median, min, max, var))

mean(iris$Sepal.Length)

# 3. Make a boxplot of both Sepal.Length and Sepal.Width to visualize the summary statistics calculated above.
boxplot(iris$Sepal.Length, iris$Sepal.Width, names = c('length', 'width'), main = 'iris sepal data')

# or
boxplot(iris$Sepal.Length)
boxplot(iris$Sepal.Width)

## EXERCISE 2 ##

# Translate the following into a model: "`iris` sepal length is determined by all other petal measurements, as well as the interaction 
# between sepal length and petal length." 
names(iris)
# iris$Sepal.Length ~ iris$Sepal.Width + iris$Petal.Length + iris$Petal.Width + iris$Sepal.Length:iris$Petal.Length

translated.fit <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Sepal.Length:Petal.Length, data = iris)
summary(translated.fit)

# Look at the other variables included in `mtcars`. Which of these do you think most influences the miles per gallon of a given model? 
# Write out a statement in your comments, then model this statement using proper notation.
data('mtcars')
names(mtcars)
head(mtcars)

# The mpg of a given model is most influenced by the cylinder number and weight of the model.
car.fit <- lm(mpg ~ cyl + wt, data = mtcars)
summary(car.fit) ## r2 is 0.8185 (wow!)

## EXERCISE 3 ##
# Run a one-sided, two sample t-test to determine whether 8-cylinder cars get significantly lower mpg than 6-cylinder cars. 
# Make sure to take a look at your data to help you choose an appropriate alternative hypothesis.

six <- mtcars %>% filter(cyl == 6)
eight <- mtcars %>% filter(cyl == 8)

t.test(eight$mpg, six$mpg, alternative = 'less')

## EXERCISE 4 ##
# Let's go back to a familiar question: does the weight of a car affect its mpg? Run this linear model and extract the coefficients.
cars2 <- lm(mpg ~ wt, data = mtcars)
summary(cars2)
cars2$coefficients

## EXERCISE 5 ##
# Run an ANOVA using the R diamonds dataset to test whether the color of a diamond affects its depth.
library(ggplot2) # weirdly, diamonds is part of the ggplot2 library
data('diamonds')
sparkly.fit <- aov(depth ~ color, data = diamonds)
summary(sparkly.fit)

# Test whether the price of a diamond is affected by cut, color, and clarity.
sparkly.fit2 <- aov(price ~ cut + color + clarity, data = diamonds)
summary(sparkly.fit2)

