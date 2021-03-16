# Isaac Racine
# Basic anatomy and use of for loops
# 16 Mar 2021
#------------------------------------------------


#-------------- Anatomy ---------------
# for (var in seq) { #designates start of loop

  #body of loop

#} designates end of loop

#var is a counter variable that holds the current values of the counter in the loop

#seq is an a vector (integer or character string) that defines starting and ending values of the loop

#suggest using i, j, k for the var variable (counter)

#-------------- Example ---------------
my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

#how to NOT use loop
for(i in my_dogs){
  print(i) 
}

#want var to be able to take on numeric indexes as well

#CORRECT way
for(i in 1:length(my_dogs)){
  cat("i = ", i, " my_dogs[i] = ", my_dogs[i],"\n")
}

# potential hazard: suppose our vector is empty!
my_bad_dogs <- NULL
for(i in 1:length(my_bad_dogs)){
  cat("i = ", i, " my_bad_dogs[i] = ", my_bad_dogs[i],"\n")
}
#length of my_bad_dogs is 0, so goes 1 then 0


# SAFEST way to code var in the for loop is use seq_along
for(i in seq_along(my_dogs)){
  cat("i = ", i, " my_dogs[i] = ", my_dogs[i],"\n")
}

# handles empty vector correctly
for(i in seq_along(my_bad_dogs)){
  cat("i = ", i, " my_bad_dogs[i] = ", my_bad_dogs[i],"\n")
}
# prints nothing!

#could also define vector length from a constant
zz <- 5
for(i in seq_len(zz)){
  cat("i = ", i, " my_dogs[i] = ", my_dogs[i],"\n")
}
#seq_len makes a seq of the length passed

#-------------- For Loop Tips ---------------
# Tip 1: do NOT change object dimensions inside a loop
  #avoid these functions (cbind, rbind, c, list)

my_dat <- runif(1)
for(i in 2:10){
 temp <- runif(1)
 my_dat <- c(my_dat, temp) #don't do this!
 cat("loop number = ", i, "vector element = ", my_dat[i], "\n")
}
print(my_dat)

# Tip 2: Don't do things in a loop if you don't need to
for(i in 1:length(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i]) #don't do this in loop
  cat("i = ", i, "my_dogs[i] = ", my_dogs[i], "\n")
}

z <- c("dog", "cat", "pig")
toupper(z)
           
# Tip 3: do not use a loop if you can vectorize
my_dat <- seq(1:10)
for(i in seq_along(my_dat)){
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number = ", i, "vector element = ", my_dat[i], "\n")
}

# no loop needed here
z <- 1:10
z <- z + z^2
print(z)

# Tip 4: understand the distinction between the counter variable, i, and the vector element, z[i]
z <- c(10, 2, 4)
for(i in seq_along(z)){
  cat("i = ", i, "z[i] = ", z[i], "\n")
}

# What is the value of i at the end of the loop
print(i)

# what is the value of z at end of loop
print(z)

# Tip 5: use next to skip certain elements in the loop
z <- 1:20

#suppose we want to only work with odd-numbered elements?
#next is helpful for skipping over elemnts that we do
# not want the for loop operating on
for(i in seq_along(z)){
  if (i %% 2 == 0) next
  print(i)
}

# another method, probably faster (why?)
z <- 1:20
z_sub <- z[z %%2 != 0]
print(z_sub)

length(z)
length(z_sub)

for(i in seq_along(z_sub)){
  cat("i = ", i, "z_sub[i] = ", z_sub[i], "\n"
}

# Tipe 6: use break to set up conditional to break out of a loop early
  # create a simple random walk population model function
#---------------------------------------
# FUNCTION ran_walk
# description: stochastic random walk
# inputs: times = number of time steps 
#         n1 = inital population size (=n[1])
#         lambda = finite rate of increase
#         noise_Sd = standard deviation of a normal 
#                   distribution with mean 0
# outputs: vector n with population sizes > 0
#           until extinction, then NA values
########################################
library(tcltk)
library(ggplot2)
ran_walk <- function(times = 100,
                     n1 = 50,
                     lambda = 1.0,
                     noise_sd = 10) {
  n <- rep(NA, times) #creating output vector
  n[1] <- n1 #initialize starting population size
  noise <-rnorm(n = times, mean = 0, sd = noise_sd)
  # create random noise vector
  
  for (i in 1:(times - 1)){
    n[i + 1] <- n[i] * lambda + noise[i]
    if(n[i + 1] <= 0) {
      n[i + 1] <- NA
      cat("Population extinction at time ", i-1, "\n")
      tkbell()
      break } #terminates loop 
  } #end of for loop

return(n)

} # end of ran_walk
#---------------------------------------
ran_walk()
