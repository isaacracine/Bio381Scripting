#Functions
# 3/2/21
# ISR

#---------------------------------------------------
library(ggplot2)

sum(3,2)# "prefix" function
3+2 #an "operator" is actually a funciton
`+`(3,2) #the operator is an "infix" function

y <- 3
print(y)
`<-`(yy,3) # another "infix" function
print(yy)

#can print functions
print(read.table)

sd #prints content of standard dev function
sd(c(3,2)) #calls funxtion w parameters
sd() #calls function w default vals for parameter

#-----------Anatomy of User Defined Function----------
#function decleration:
# functionName <- function(parX = defaultX, parY = defaultY){

  # body:
  #Lines of R code and annotations
  #May call other functions
  #May create fuctions
  #May define local variables

  #returns a single object (can be any data type, is optional)
  #returns (singleObject)
# }
#closing bracket



# functionName    #print the body
# functionName()  # run function w default vals
# function(parX = x, paryY) #passing object to function

#----------------Stylistic Conventions-----------------
# use prominent hash character fencing at start and finish
# give a header with the function name, descripition, in/outputs
#names inside a function can be fairly short and generic
#functions should be short and simple, no more than screenful
#if too long/complex, break it up into several functions
#provide default values for all functions arguments
#ideally use the random num generator as defualt vals for rapid testing

#----------------------Scope-------------------------------
# global vars: visible to all parts of code; declared in the main body
# local vars: visible only w in a function; declared in function or passed to the function through parameters
# functions can "see" global variables, but should not use them
#global environment cannot "see" variables in function environment
#what happens in the function stays in the function

#-----------------Practice Function Writing-----------------

##############################################################
# FUNCTION h_weinberg
# calculates Hardy-Weinbgerg equilibrium values
# input: an allele frequency p(0,1)
# output: p and frequencues if the 3 genotypes AA,AB and BB
#-----------------------------------------------------------
h_weinberg <- function(p = runif(1)) {
  #local vars
  q <- 1 - p  
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p = p, AA = f_AA, AB = f_AB, BB = f_BB),
                    digits = 3)
  return(vec_out)
}

###############################################################

#call function
h_weinberg() #try with default vals
h_weinberg(p=0.5) # pass value to input param 
  
pp <- 0.6
h_weinberg(p = pp)
print(pp)

p <- 0.7  #global variable
h_weinberg(p = p)

#----------Error Warning and Multiple Return Values----------
##############################################################
# FUNCTION h_weinberg2
# calculates Hardy-Weinbgerg equilibrium values
# input: an allele frequency p(0,1)
# output: p and frequencues if the 3 genotypes AA,AB and BB
#-----------------------------------------------------------
h_weinberg2 <- function(p = runif(1)) {
  if (p > 1.0 | p < 0.0){
    return("Function failure: p must be >=0 and <= 1.0")
    }
  #local vars
  q <- 1 - p  
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p = p, AA = f_AA, AB = f_AB, BB = f_BB),
                    digits = 3)
  return(vec_out)
}

##############################################################

h_weinberg2() #run w default
h_weinberg2(p=1.1) #gives message
z <- h_weinberg2(1.1)
print(z)


##############################################################
# FUNCTION h_weinberg3
# calculates Hardy-Weinbgerg equilibrium values
# input: an allele frequency p(0,1)
# output: p and frequencues if the 3 genotypes AA,AB and BB
#-----------------------------------------------------------
h_weinberg3 <- function(p = runif(1)) {
  if (p > 1.0 | p < 0.0){
    stop("Function failure: p must be >=0 and <= 1.0")
  }
  #local vars
  q <- 1 - p  
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p = p, AA = f_AA, AB = f_AB, BB = f_BB),
                    digits = 3)
  return(vec_out)
}

##############################################################

zz <- h_weinberg3(1.1)
print(zz)


#------------Exploring Scoping and Local Vars----------------

my_func <- function(a = 3, b = 4){
  z <- a + b
  return(z)
}

my_func()

my_func_bad <- function(a=3) {
  z <- a + b 
  return (z)
}
my_func_bad()
b <- 100
my_func_bad() # runs because b is in global

# fine to creae vars locally
my_func_OK <- function(a = 3) {
  bb <- 100
  z <- a + bb
  return(z)
}
my_func_OK()
print(bb) #errors bc does not exist in global environment


#----------------Setting Default Parameter Values------------
###########################################################
# FUNCTION : fit_linear
# fits a simple linear regression line
# inputs: numeric vector of predictor(x) and response (y)
# outputs: slope and p-value
#------------------------------------------------------------
fit_linear <- function(x = runif(20), y = runif(20)) {
  my_model <- lm(y~x)
  my_out <- c(slope = summary(my_model)$coefficients[2,1],
              pval = summary(my_model)$coefficients[2,4])
 # plot(x = x, y = y) #quick plot to check output
  z <- ggplot2::qplot(x = x, y = y)
  plot(z)
  return(my_out)
}
##############################################################
fit_linear() # default values


## a double colon following a package allows access to functions without loading it


###########################################################
# FUNCTION : fit_linear2
# fits a simple linear regression line
# inputs: numeric vector of predictor(x) and response (y)
# outputs: slope and p-value
#------------------------------------------------------------
fit_linear2 <- function(p = NULL) {
  if (is.null(p)) {
    p <- list(x = runif(20), y = runif(20))
  }
  my_model <- lm(p$y~p$x)
  my_out <- c(slope = summary(my_model)$coefficients[2,1],
              pval = summary(my_model)$coefficients[2,4])
  # plot(x = x, y = y) #quick plot to check output
  z <- ggplot2::qplot(x = p$x, y = p$y)
  plot(z)
  return(my_out)
}
##############################################################
fit_linear2()
my_pars <- list(x = 1:10, y =runif(10))
fit_linear2(my_pars)

z <- c(runif(99), NA)
mean(z) #doesn't work b/c NA present
mean(z, na.rm = TRUE) #change default val for function
mean(z, na.rm = TRUE, trim = 0.05)#throw out tails of data, 5%
l <- list(x = z, na.rm = TRUE, trim = 0.05)
do.call(mean, my_pars)  #works for a function and list of parameters

