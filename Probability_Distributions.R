#Probability distributions!!!
#2.23.21

#--------------Notes on Distributions-----------
#first distrinciton is kind of data
#paramters determine the shape of the curve

#dicrete: only takes on integer values
  #Poisson: [0, infinity]
    #parameters: size = # of events, rate = lambda
    #interpretation: distribution of event that occur        during a fixed time interval or sample w a constant     rate of independent events (lambda)
  #Binomial: [0, # of trials]
    #parameters: size = numbers of trial, p =              probability of a positive outcome
  #Negative binomial: [0, infinity]
    #parameter: size =number of success; p =               probability of success

#continuous: variable measured along continuous scale
  #Uniform: [min, max]
    #parameter: min = min, max = max
  #Normal [-infinity, infinity]
    #parameters: mean = central tendency, SD
  #Gamma: [0, infinity]
    #parameters; shape, scale
    #interpretation: mean = shape * scale, var = shape *     scale^2
  #Beta; [0,1]
    #parameters: shape1 and shape 2 are integers,          interpret as shape 1 = # of success + 1, and 2 =       number of failures +1, prob of getting those           outcomes

#-------- R Grammar of Prob Distributions------
# d  -> given probability density function
    #probability of particular values
# p  -> cumulative distribution
    #curve rises to 1, used for tail value
# q  -> quantile function (inverse of p)

# r  -> random number generation


#-----------Practice w Discrete-------------------
library(ggplot2)
library(MASS)

###Poisson
## x >= 0 (int)
# Random events occur at constant rate
# events occur within a fixed time period
# lambda = average rate of event

## "d" function for prob density
events <- 0:10
my_vec <- dpois(x = events, lambda = 1)
qplot(x = events, y = my_vec, geom = "col",
      color = I("black"), fill = I("goldenrod"))

#change lambda to compare
my_vec <- dpois(x = events, lambda = 2)
qplot(x = events, y = my_vec, geom = "col",
      color = I("black"), fill = I("goldenrod"))

#change lambda again
events <- 0:15
my_vec <- dpois(x = events, lambda = 6)
qplot(x = events, y = my_vec, geom = "col",
      color = I("black"), fill = I("goldenrod"))

#change lambda again
my_vec <- dpois(x = events, lambda = 0.2)
qplot(x = events, y = my_vec, geom = "col",
      color = I("black"), fill = I("goldenrod"))
sum(my_vec) 
#should always be 1 or close to 1
#area under the curve!

#using "d" function on any single value
dpois(x = 0, lambda = 2.2)
#returns chances of getting 0 occurrences
#given that 2.2 is average


##Using the "p" function
# generates the cumulative prob density
#curve always goes up

events <- 0:10
my_vec = ppois(q = events, lambda = 2)
qplot(x = events, y = my_vec, geom = "col",
      color = I("black"), fill = I("blue"))
#each col is prob of getting that many events of fewer

#What is the prob that a single trial will yield a 
#value of <= 1?
ppois(q=1, 2)

#could also answer using dpois
p_0 <- dpois(x=0, lambda =2)
p_0
p_1 <- dpois(x=1, lambda = 2)
p_1
p_0 + p_1  #here's the answer


## "q" function is the inverse of the p function
# what is the number of occurrences corresponding to 50% of the portability mass in a poisson distrib, with lambda =2.5?
qpois(p=0.5, lambda = 2.5)
# 2 hits would make half of prob

#distribution of porbabilites as a function of the values
qplot(x = 0:10, y = dpois(x = 0:10, lambda = 2.5),
      geom = "col", color = I("black"), 
      fill=I("goldenrod"))

#exact answer comes from ppois bc discrete
ppois(q=2, lambda =2.5)


## "R" function generates random variates for the parameters of a distribution

rand_pois <- rpois(n = 1000, lambda = 2.5)
qplot(x = rand_pois, color = I("black"),
      fill = I("red"))

#for real or simulated data, we can use quantile function.
quantile(x = rand_pois, probs = c(0.025, 0.975))
# returns 95% CI for that boundary 

#------------------------------------
### binomial 
## p = probability of a dichotomous outcome
## size = number of trials
# x is the var generated, possible outcomes
# outcome x is bounded b/t 0 and size

# use "d" binom for density function
events <- 0:10
my_vec <- dbinom(x = events, size = 10, prob = 0.8)
qplot(x = 0:10, y = my_vec, geom = "col",
      color = I("black"), fill = I("goldenrod"))

#change prob
events <- 0:10
my_vec <- dbinom(x = events, size = 10, prob = 0.2)
qplot(x = 0:10, y = my_vec, geom = "col",
      color = I("black"), fill = I("goldenrod"))


my_coins = rbinom(n = 50, size = 100, prob =0.6)
#filpping 50 coins 100 times
qplot(x = my_coins,
      color = I("black"), fill = I("red"))
#returns counts of coins with heads


#-------------------------------------------
### negative binomial
# number of vailures expecred before reaching a number of success in a set of binomial trials 
#measure of "waiting times"

##alternatively, can specify mu = mean
##and size == dispersion parameter (smaller = more dispersed)
# is similar to poisson but more heterogenous in vals
neg_bin <- rnbinom(n = 1000, size = 10, mu = 5)
qplot( x = neg_bin, color = I("black"),
       fill = I("red"))

#change size
neg_bin <- rnbinom(n = 1000, size = 0.1, mu = 5)
qplot( x = neg_bin, color = I("black"),
       fill = I("red"))

#change size again
neg_bin <- rnbinom(n = 1000, size = 100, mu = 5)
qplot( x = neg_bin, color = I("black"),
       fill = I("red"))

# a smaller size seems to cause a greater skew
# with a larger size seeming to create more unimodal

#------------------Continuous----------------------
#more applicable for US

###UNIFORM
## min and max

qplot(x = runif(n = 10000, min = 0, max = 5),
      color = I("black"), fill = I("green"))
#central limit theorem, the more sample the closer we diverge on the true mean

### NORMAL / GAUSSIAN
# greater probability mass in center of distribution
my_norm <- rnorm(n = 100, mean = 100, sd = 2)

qplot(x = my_norm,
      color = I("black"), fill = I("red"))
summary(my_norm)

# problem if mean is small, but must be greater
# than 0 !
my_norm <- rnorm(n = 100, mean = 1, sd = 2)
qplot(x = my_norm,
      color = I("black"), fill = I("red"))
summary(my_norm)

# can try this!
no_zeros <- my_norm[my_norm > 0]
qplot(x = no_zeros,
      color = I("black"), fill = I("red"))
summary(no_zeros)
#OBviously shifts mean !!!

###Gamma
# continuous, but only positive, great for small means
## shape, scale
my_gamma <- rgamma(n = 100, shape = 1, scale = 10)
qplot(x = my_gamma, color = I("black"),
      fill = I("red"))
#looks like exponential decay for small means

#increase shape
my_gamma <- rgamma(n = 100, shape = 100, scale = 10)
qplot(x = my_gamma, color = I("black"),
      fill = I("red"))

# mean = shape * scale
# var = shape * scale^2



### BETA
# continuous but bounded b/t 0 and 1
## shape 1 and shape 2
# beta can be treated as the distribution of probability values for estimating a binomial process of #success / (#success + #failures)
# is a maximum likelihood estimator
## shape1 = num of sucess + 1
## shape2 = num of fails + 1

# no data position
my_beta = rbeta(n = 1000, shape1 = 1,
                shape2 = 1)
qplot(x = my_beta, color = I("black"),
      fill = I("red"))
    # basically uniform fomr 0 to 1

# more typical
# suppose we have 7 head and 3 tails
my_beta = rbeta(n = 1000, shape1 = 8,
                shape2 = 4)
qplot(x = my_beta, color = I("black"),
      fill = I("red"))

# suppose we have 70 head and 30 tails
my_beta = rbeta(n = 1000, shape1 = 71,
                shape2 = 31)
qplot(x = my_beta, color = I("black"),
      fill = I("red"))

#SMALLER DATA SETS ARE NOISER

#suppose we toss a coin once and get heads
# suppose we have 7 head and 3 tails
my_beta = rbeta(n = 1000, shape1 = 2,
                shape2 = 1)
qplot(x = my_beta, color = I("black"),
      fill = I("red"))

#BETA gives use any shape we want b/t boundaries
# can even pass non integers values -> gives U shape

#parameters less than 1 give a bimodal distribution with the beta
# suppose we have 7 head and 3 tails
my_beta = rbeta(n = 1000, shape1 = 0.21,
                shape2 = 0.1)
qplot(x = my_beta, color = I("black"),
      fill = I("red"))
#increasing shape 1 increase right end and vice versa



#-----------Maximum likelihood estimates-----------
# p(data|hypothesis)
# how probable are the data if the null hypo is true

# p(data|parameters)
# how well do the data fit given the parameters
# can also think as a goodness of fit test
# better! : p(parameters|data)
  # for a given set of data, what is the probability    that a certain set of parameters will be there
  # maximize this probability
#maximum likelihood estimators of the parameters

library(MASS)
data <- c(0,0,0,0,0,0,1,1,1,2)
z <- fitdistr(data, "poisson")
print(z)
# returns MLH estimate of lambda based on data
# number below returns the SD of the parameter

sim_data <- rpois(n = 10, lambda = z$estimate["lambda"])
head(sim_data) #returns best estimate of data

#--------Steps--------
# 1. select a statistical distribution that is appropriate for the data
# 2. use fitdistr() function to find MLH estimates of the the distribution parameters
# 3. use those parameters to visualize the probability density function ("d" family) and/or simulate additional data to use for other things


#--------------------EXAMPLE--------------------
#Empirical example

frog_data <- c(30.15, 26.3, 27.5, 22.9, 27.8,
               26.2)

z <- fitdistr(frog_data, "normal")
print(z)

#plot the density function for the normal data with these parameters and annotate w original data

x <- 0:50
p_density <- dnorm(x = x,
                   mean = z$estimate["mean"],
                   sd = z$estimate["sd"])

qplot(x = x, y = p_density, geom = "line") +
  annotate(geom = "point", x = frog_data,
           y =0.001) 

#one issue is if data were negative! which is not possible in real world
#for practice do the same for gamma distribution
z <- fitdistr(frog_data, "gamma")
print(z)

p_density <- dgamma(x = x,
                   shape = z$estimate["shape"],
                   rate = z$estimate["rate"])

qplot(x = x, y = p_density, geom = "line") +
  annotate(geom = "point", x = frog_data,
           y =0.001, color = "red") 





#Empirical example
# BUT WITH A WEIRD OUTLIER
outlier <- 0.05
frog_data <- c(30.15, 26.3, 27.5, 22.9, 27.8,
               26.2)

#insert outlier into frog dara
frog_data <- c(frog_data, outlier)

z <- fitdistr(frog_data, "normal")
print(z)

#plot the density function for the normal data with these parameters and annotate w original data

x <- 0:50
p_density <- dnorm(x = x,
                   mean = z$estimate["mean"],
                   sd = z$estimate["sd"])

qplot(x = x, y = p_density, geom = "line") +
  annotate(geom = "point", x = frog_data,
           y =0.001) 

#one issue is if data were negative! which is not possible in real world
#for practice do the same for gamma distribution
z <- fitdistr(frog_data, "gamma")
print(z)

p_density <- dgamma(x = x,
                    shape = z$estimate["shape"],
                    rate = z$estimate["rate"])

qplot(x = x, y = p_density, geom = "line") +
  annotate(geom = "point", x = frog_data,
           y =0.001, color = "red") 

