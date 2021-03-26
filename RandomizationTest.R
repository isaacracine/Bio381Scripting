# Isaac Racine
# Randomization Tests
# 23 Mar 2021
#------------------------------------------------

# statistical p is probability of obtaining the observed results
# (or something more extreme) if the null hypothesis were true
# p(data|H0)

# H0 or Null hpot is of "no effect"
# variation is caused by measured error or other unspecified (and 
# less important) source of variation

# two advantages of the randomization test 
# relaxes assumption of standard parametric tests (normality,
# balanced sample sizes, common variance)
# give a more intuitive understanding of statistical probability

#-------------- Steps in Randomization Test ---------------
# 1. Define a metric (X) as a single number to represent pattern
# 2. Calculate X(obs) the metric for the empirical (obs) data that we start with
# 3. Randomize or reshuffle the data. Randomize in a way that would uncouple the association b/t obs data and their assignment to treatment groups. Ideally, the randomization only affect the pattern of treatment effects in the data. Other aspects of the data (such as sample sizes) are preserved in the randomization. Stimulate the null hypothesis.
# 4. For this single randomization, calculate X(sim). If null hypothesis is true X(obs) is similar to X(sim). If the null hypothesis is false X(obs) is very different from X(sim).
# 5. Repeat steps (3) and (4) many times (typical n=1000), this is called bootstrapping. This will let us visualize as a histrogram the distribution of X(sim); distribution of X values when the null hypothesis is true
# 6. Estimate the tail probability of the obs metric (or something more extreme) given the null distribution (pX(obs)|H0)

#-------------- Preliminaries ---------------
library(ggplot2)
library(TeachingDemos)

#This is used to replicate data by setting seed of random num gen
set.seed(100)

#Teaching demos lets you seed with characters
char2seed("espresso withdrawl")
# OR which will return the number to seed
char2seed("espresso withdrawl", set=FALSE)

# if don't set seed R will make call to Sys.time() when start and set that to the seed 
Sys.time()

#However if we call as.numeric() it will return time in seconds
as.numeric(Sys.time())
my_seed <- as.numeric(Sys.time())
set.seed(my_seed)

#reset seed for purpose of class
char2seed("espresso withdrawl")

#-------------- treatment groups ---------------
trt_group <- c(rep("Control", 4), rep("Treatment", 5))
print(trt_group)

#-------------- Response variable ---------------
z <- c(runif(4) + 1, runif(5) +10)
print(z)

#-------------- combine into dataframe ---------------
df <- data.frame(trt = trt_group, res = z)
print(df)

#-------------- Analysis ---------------

# look at meant in two groups
# tapply: acts as tags
obs <- tapply(df$res, df$trt, mean)
print(obs)

#-------------- Simulated Data ---------------
# create a new df
df_sim <- df

#sample changes the position and ordering of values regardless of treatment
df_sim$res <- sample(df_sim$res)
print(df_sim)

#look at the means in the two groups of randomized data
sim_obs <- tapply(df_sim$res, df_sim$trt, mean)
print(sim_obs)


#-------------- build function ---------------

#---------------------------------------
# FUNCTION read_data
# description: read in (or generate) data set for analysis
# inputs: file anem (or nothing as in this demo)
# outputs: 3 col data frame of obs data (ID, x, y)
########################################
read_data <- function(z = NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 10 * rnorm(20)
    df <- data.frame(ID = seq_along(x_obs),
                     x_obs,
                     y_obs)
  } else {
    df <- read.table(file = z,
                     header = TRUE,
                     stringsAsFactors = FALSE)}

return(df)

} # end of read_data
#---------------------------------------
#read_data()

#---------------------------------------
# FUNCTION get_metric
# description: calculate metric for randomization test
# inputs: 2-col data frame for regression
# outputs: regression slope
########################################
get_metric <- function(z = NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 10 * rnorm(20)
    z <- data.frame(ID = seq_along(x_obs), 
                    x_obs,
                    y_obs)}
  . <- lm(z[,3]~z[,2])  #3 col is y var, 2 is xvar
  . <- summary(.)
  
  . <- .$coefficients[2,1] # grabbing matrix and getting slope
  slope <- .
  
  return(slope)

} # end of get_metric
#---------------------------------------
#get_metric()

#---------------------------------------
# FUNCTION shuffle_data
# description: randomize data for a regression analysis
# inputs: 3 col data frame (ID, xvar, yvar)
# outputs: 3 col data frame (ID, xvar, yvar)
########################################
shuffle_data <- function(z = NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 10 * rnorm(20)
    z <- data.frame(ID = seq_along(x_obs),
                    x_obs,
                    y_obs)}
  z[,3] <- sample(z[,3])
    
return(z)

} # end of shuffle_data
#---------------------------------------
#shuffle_data()

#---------------------------------------
# FUNCTION get_pval
# description: calculate p-val from simulation
# inputs: list of observed metric and vector of simulated metrics
# outputs: lower and upper tail probability
########################################
get_pval <- function(z = NULL) {
  if(is.null(z)){
    z <- list(rnorm(1), rnorm(1000))}
  p_lower <- mean(z[[2]] <= z [[1]])
  #what is the proportion of the simulated values less than the obs values
  
  p_upper <- mean(z[[2]] >= z[[1]])

return(c(pL = p_lower,pU = p_upper))

} # end of get_pval
#---------------------------------------
get_pval()



#---------------------------------------
# FUNCTION plot_ran_test
# description: create a ggplot of histogram of simulated values
# inputs: list of obs metric and vector simulated metrics
# outputs: saved ggplot graph
########################################
plot_ran_test <- function(z = NULL) {
  if(is.null(z)){
    z <- list(rnorm(1), rnorm(1000))}
  df <- data.frame(ID = seq_along(z[[2]]), sim_x = z [[2]])
  p1 <- ggplot(data = df, mapping = aes(x = sim_x))
  p1 + geom_histogram(mapping = aes(fill = I("goldenrod"),
                                    color = I("black"))) +
    geom_vline(aes(xintercept = z [[1]], col = "blue"))
  


} # end of plot_ran_test
#---------------------------------------
#plot_ran_test()

# distribution of 1000 simulated slopes from our model
# the blue line is the actual slope that comes out from this data


#-------------- Analysis ---------------
n_sim <- 1000 # num of simulated data sets to construct
x_sim <- rep(NA, n_sim) #set up empty vector for simulated slopes
df <- read_data() # get (fake) data
x_obs <- get_metric(df) # get slope of obs data

#seq_along uses the length of a vector
#seq_len uses the value of number passed
for (i in seq_len(n_sim)) {
  x_sim[i] <- get_metric(shuffle_data(df))}
  #shuffle data then pull out metric value of sim data and save these values for all 1000 simulations in vector)

slopes <- list(x_obs, x_sim) #x_sim is 1000 simulated slopes
get_pval(slopes) #if pL is greater than the real slope is likely greater than most 
plot_ran_test(slopes) #the blue line is what splits distribution into upper and lower tails calculated above

#BOOSTRAPPING is sampling with replacement for the same amount of sample size as in the original data. THe calculated mean for each simulated sample allows for a differenc in means
