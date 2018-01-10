library(ggplot2)
library(dplyr)

#-------------------------------#
### Exploratory data analysis ###
#-------------------------------#

# While summary statistics offer a quick and relatively simple way to assess essential qualities of your data, they can sometimes be misleading. 
# Let's explore a case in which data visualization is an important step in data analysis.

# read in pre-loaded data (included in the 'datasets' package; type ?anscombe for details)
data('anscombe')

# take a peek at the data (alternatively, you can type head(anscombe) to see the first 6 columns of the dataset).
anscombe

# calculate summary statistics (here, mean and variance) using dplyr
init.stats <- summarise_all(anscombe, funs(mean, var))
# look at summary statistics for x variables between datasets
select(init.stats, starts_with('x'))
# look at summary statistics for y variables between datasets
select(init.stats, starts_with('y'))

## summary stats look super similar! What about running a simple model (y ~ x) to see if the regression lines are similar?

# run regressions in a loop (don't worry about this part!)
model <- y ~ x
all.mods <- setNames(as.list(1:4), paste0('lm', 1:4))
for (i in 1:4){
  model[2:3] <- lapply(paste0(c('y', 'x'), i), as.name)
  all.mods[[1]] <- lmi <- lm(model, data = anscombe)
  print(anova(lmi))
}

# compute new columns with dataset names to facilitate plotting; plot datasets by group and wrap into single pretty plot
list(
  transmute(anscombe, x=x1, y=y1, dataset='1'),
  transmute(anscombe, x=x2, y=y2, dataset='2'),
  transmute(anscombe, x=x3, y=y3, dataset='3'),
  transmute(anscombe, x=x4, y=y4, dataset='4')
) %>%
  bind_rows() %>%
  ggplot(aes(x, y)) + geom_point(aes(fill = dataset), size = 3, pch = 21) + facet_wrap(~ dataset)

### Exercise 1: explore a classic dataset

#Using the `iris` dataset:
  
# Plot Sepal.Length and Sepal.Width.
# Calclate the mean, median, min, max, and variance of Sepal.Length and Sepal.Width. Print the output.
# Make a boxplot of both Sepal.Length and Sepal.Width to visualize the summary statistics calculated above.

#---------------------------------------------------#
### Basic questions in statistics, model notation ###
#---------------------------------------------------#

data('mtcars') # load built-in dataset
head(mtcars) # peek at first few rows of data

basic.fit <- lm(mtcars$mpg ~ mtcars$wt)

multi.fit <- lm(mtcars$mpg ~ mtcars$wt + mtcars$hp)

inter.fit1 <- lm(mtcars$mpg ~ mtcars$wt + mtcars$hp + mtcars$wt:mtcars$hp)

inter.fit2 <- lm(mtcars$mpg ~ mtcars$wt*mtcars$hp)

### Exercise 2: build models from questions

# Translate the following into a model: "`iris` sepal length is determined by all petal measurements, as well as the interaction 
# between sepal length and petal length." 

# Look at the other variables included in `mtcars`. Which of these do you think most influences the miles per gallon of a given model? 
# Write out a statement in your comments, then model this statement using proper notation.

#-----------------------------#
### Useful stats 1: t-tests ###
#-----------------------------#

vols <- runif(15, min = 490, max = 500) # randomly generate 15 numbers between 490 and 500

# run a 1-sample t-test with the alternative hypothesis that the true mean is less than 500 mL; set the confidence level to 0.99 (alpha = 0.01)
t.test(vols, mu = 500, alternative = 'less', conf.level = 0.99) 

before <- c(200.1, 190.9, 192.7, 213, 241.4, 196.9, 172.2, 185.5, 205.2, 193.7)
after <- c(392.9, 393.2, 345.1, 393, 434, 427.9, 422, 383.9, 392.3, 352.2)
weights <- as.data.frame(cbind(before, after))

t.test(weights$before, weights$after, paired = TRUE)

data('diamonds')
head(diamonds) # this dataset contains ~54,000 observations of diamonds of varying quality. Let's assess whether the price of 'Very Good' and 'Premium' diamonds differs significantly:
vgood <- diamonds %>% filter(cut == 'Very Good') # create a subset based on cut category
premium <- diamonds %>% filter(cut == 'Premium')

t.test(vgood$price, premium$price, alternative = 'less', conf.level = 0.99) # test whether price is significantly different

t.test(vgood$carat, premium$carat, alternative = 'less', conf.level = 0.99) # test whether carat measurements are significantly different

#---------------------------------------#
### Useful stats 2: linear regression ###
#---------------------------------------#

lm.basic <- lm(mpg ~ wt, data = mtcars)

summary(lm.basic)
names(lm.basic) ## take a peek at the kinds of summary statistics that may be accessed
summary(lm.basic)$coefficients

#---------------------------#
### Useful stats 3: ANOVA ###
#---------------------------#

music <- as.data.frame(cbind(runif(10, min = 50, max = 100), runif(10, min = 70, max = 100), runif(10, min = 80, max = 100)))
names(music) <- c('metal', 'electronic', 'jazz')
music

musicdf <- bind_rows(transmute(music, score = metal, genre = 'metal'), transmute(music, score = electronic, genre='electronic'), transmute(music, score = jazz, genre='jazz'))

simple.anova <- aov(score ~ genre, data = musicdf)
summary(simple.anova)