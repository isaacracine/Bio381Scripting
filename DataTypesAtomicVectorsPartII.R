# Data types and atomic vectors
#2.11.21
#IR
#-----------------------------
###create atomic vector 
#(AVOID the following method)
z <- vector(mode="numeric", length = 0)
print(z)
  #add elements to it w/ c
z <- c(z,5)
head(z)
  #this "dynamic sizing" is very SLOW!!

#create atomic vector (CORRECT)
# predefine vector length

#create vector of 100 0s
z <- rep(0,100)
head(z)

#BEST
#better to start w NAs
z <- rep(NA,100)
typeof(z)
z
z[1] <- "Washington"
head(z)
typeof(z)


### efficiently create a large vector w names
my_vector <- runif(100)
my_names <- paste("Species",
                  seq(1:length(my_vector)),
                  sep = "")
head(my_names)
names(my_vector) <- my_names
head(my_vector)


### using the repeat function
rep(0.5, 6) # repeat 0.5 six times
rep(x = 0.5, times = 6) #give input names
rep(times=6, x= 0.5) # order does not matter

my_vec <- c(1, 2, 3)
rep(x= my_vec, times =2)
rep(x = my_vec, each=2) #each element is repeated once at a time before moving to the next value

rep(x = my_vec, times = my_vec) #each element is matched to the replications for it

rep(x = my_vec, each = my_vec) #why don't work?


#### using Seq vector
seq(from=2, to =4)
2:4   #generates the exact same output

seq(from = 2, to = 4, by = 0.5)
# by is a incrementer

x <- seq(from = 2, to = 4, length = 7)
#will make boundaries based of the length (number of elements)

my_vec <- seq(1:length(x)) #gives 1-7 bc of length (SLOW)!
print(my_vec)

seq_along(x) #takes vector x and calculate seq along it FAST

seq_len(5) #will count from 1-5, FAST

#-------------------------
###RANDOM NUMBERS
runif(5)
runif(n=3, min = 100, max =103)

rnorm(6)  #mean of 0, SD of 1
rnorm(6, mean =100, sd = 30) #can change mean and sd

#Explore distributions by sampling and plotting
library(ggplot2)  #do at start
z <- runif(1000)
qplot(z)

#sample function
long_vec <- seq_len(10)
long_vec
sample(long_vec) # w no other parameters, this just reorders the data

sample(long_vec, size =3) #specify a number, sampling w out replacement

sample(long_vec, size=16) #too large of a sample

sample(long_vec, size =16,
       replace = TRUE) #sample w REPLACEMENT

#now lets considering wieghting the data, before each value had the same chance of being picked

my_weights <- c(rep(20,5),rep(100,5)) # a set of non zero positive weights, can be integers or real values
my_weights

sample(x = long_vec, replace =TRUE, prob = my_weights) #the probabilities are proportions to the values

sample(x = long_vec, replace =FALSE, prob = my_weights)


sample(x = long_vec, replace =TRUE, prob = long_vec)
#sampling w replaement, but weights are the same as the values themselves, otherwise a 10 is 10 times as likely to show up

#-------------------------------

###Subsetting, relational operators and logical operators

##Subsetting atomic vectors
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)

#positive index values
z[c(2, 3)]  #pulls out 2 and 3 values
z[c(2,2,3,3)]

#negative index values to exclude elements
z[-c(2,3)]  #returns all elements EXCEPT 2 and 3

#create a vector of logic elements to select
#based on values
z < 3   #generate vector of boolean
z[z<3]  #keeps any TRUEs

tester <- z<3
print(tester)
z[tester] #longer method, but above is more concise

#which function 
which(z < 3)  #returns the indexes that are TRUE

#use length to get positions relative to start
#and end of vector
#select everything but last two elements
z[-(length(z):(length(z)-1))]

#subset using named vector elements
names(z) <- letters[1:5]
z[c("b","c")]



##relational operators
# < less than
# > greater than
# <= less than or equal to
# >= greater than or equal to
# == equal to 


## logical operators
# ! not
# & and (will operate on entire vector)
# | or (also vector)
# xor(vec_a, vec_b)   one or the other, but NOT both
# &&    only for the first element
# ||    only for the first element


#PRACTICE
x <- 1:5
y <- c(1:3,7,7)

x == 2  #sees if all elements in vector are 2 or not
x != 2  #sees if all elements in vector are NOT 2

x == 7
x == 1
y == 7

x == 1 & y ==7  #looks for slots where both statements are true

x == 1 | y ==7  #looks for slots where either is TRUE
x == 3 | y == 3

xor(x == 3, y ==3)  #all FALSE, b/c xor means 1 of them can be true but NOT both

x == 3 && y == 3  #double & only compares first element!!



## Subscrippting with missing values
#set.seed takes a number and sets the rand num to start there
set.seed(90)
z <- runif(10)
print(z)
#SETTING SEED lets our results be reproducible

z < 0.5 #create logical vector
z[z < 0.5]
which(z < 0.5)  #returns index pointers for specific elements
z[which(z < 0.5)]


#which behaves differently if there are NAs!!!!!!
zD <- c(z, NA, NA)  #contaminate w NAs
zD[zD < 0.5]    #NA values carried along
zD[which(zD < 0.5)] #NAs are dropped
        # not very common bc will drop elements in other vector that are associated with the NAs