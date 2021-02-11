# Data types and atomic vectors
#2.9.21
#IR
#-----------------------------

# Using the assignment operator

x <- 3 #preferred assignment operator
y = 4 #legal but should only use in functions
y = y + 1.1
print(y)

#conventions for naming of variables
z <- 3 #begin with lower case number
plantHeight <- 10 #camelCase
plant.Height <- 11 #avoid!!
plant_height <- 12 #snake_case
. <- 6 #reserve period for a generic holding variable

#---------------------------------

#data types
#DImensions   homogeneous(all same data type)   Hetero
#1-dimensions    atomic vector                  List
#2-dimensions    matrix                      dataframe
#n-dimensions    Array


#Types of atomic vectors
    #character string (anything bracketed with "")
    #integers
    #doubles
    #integers and doubles are "numeric"
    #logical (T or F)
    #factor
    #vector of lists



#one dimensional atomic vector
#the combine funciotn
z <- c(3.2,5,5,6)
print(z)
typeof(z) #double

is.numeric(z) #true
is.character(z) #false

# c() always "flattens" to an atomic vector
z <- c(c(3,4),c(5,6))
print(z)


#character strings bracketed by single or double quotes
z <- c("perch", "bass", "trout")
print(z)
z <- c("This is only 'one' character string",
       'a second')
print(z)
is.character(z)  # true

#building logicals
# Boolean, not with quotes, all caps
z <- c(TRUE, TRUE, FALSE)
typeof(z)
is.integer(z)  
is.logical(z)

#-------------------------------------------
          # Properties of a Vector
# Type

#Length (the amount of elments in vector)

#Name (optional, can name individual elements)



#Length
length(z)
typeof(z)


#type
z <- c(1.2, 3, 3.3)
typeof(z)
is.numeric(z)
as.character(z) #coerces a vector to another type
store_z <- as.character(z)
typeof(store_z)


#names
z <- runif(5) #random uniform num generator

    #names are an optional attribute
names(z)
print(z)

#add names after variables creater
names(z) <- c("chow", "pug", "beagle", 
              'greyhound', 'akita')
print(z)

#add names when variable is built (quotes optional)
z_2 <- c(gold = 3.3, silver = 10, lead = 2)
print(z_2)

#reset names
names(z_2) <- NULL
print(z_2)

#names can be added for only a few elements
#names do not have to be distinct, often are
names(z_2) <- c('copper', 'zinc')
print(z_2)



#---------------------------------------------------

#using brackets to specify a particular elements of an atomic vector
z <- c(10,12,15)
z[2] #specifies the second element
z[c(1,3)] #grab elemts 1 and 3
z[3] <- 100 #assigns element 3 value of 100
print(z)


#special elements in a vector
#NA to indicate missing values
z[3] <- NA
typeof(z)
length(z)
typeof(z[3]) #what is the type of the third element

z1 <- NA
typeof(z1)


#important for dealing with NAs
print(z)

is.na(z) #logical operator to find missing values
mean(z) #will not work bc of missing vals
!is.na(z) #will find elements that are NOT missing
mean(!is.na(z)) #wrong bc calculating on TRUE and FALSE
mean(z[!is.na(z)]) #CORRECT way to eleminate NA

#NAN, -Inf, and Inf from numeric division
z <- 0/0
print(z) #NaN  : not a number
typeof(z) #double bc of numeric

z <- 1/0
print(z) #infinity
typeof(z) #double

z <- -1/0
print(z) #negative infinity
typeof(z) #double


#NULL is an object that is nothing
# a reserved word in R

z<- NULL
typeof(Z) #NULL
length(z) #0
is.null(z) # True

#---------------------------------
        #FEATURES of atomic vectors

#Coercion
#Vectorization
#Recycling

#######

              ##Coercion

#All elements of an atomic vector must be of the same type
#what happens if they are not?
a <- c(2, 2.0)
typeof(a) #Double

#if elements are of different types,
#R coerces them to a common type
# logical -> integer -> double -> chracter

a <- c(TRUE, 3, '3.0')
print(a)
typeof(a) #character

a <c(1, 2.2, l)
print(a) #doesn't change

#use this "mistake" and coercion for powerful computing
a <- runif(10)
print(a)

#comparisons operators yield a logical result
a > 0.50

#conduct math operations on this vector of logical 
#true/false vals

#how may elements in the vector are > 0.5?
sum(a > 0.5) 
#prints a number, each TRUE (1) and FALSE (0)
# due to the coerision of boolean to int

#what proportion of vector values are > 0.5?
sum(a > 0.5) / length(a)
#or
mean(a > 0.5)


#qualifying exam question in biology
#Approximatelt what proportion of oberservations
#drawn form a standaed normal distribution (0, 1)
#are large than 2.0

mean(rnorm(1000) > 2.0) #0.025
#rnorm is a random num from normal distribution

#####
        #vectorization

z <- c(10, 20, 30)
z + 1 #adds 1 to each element

#corresponding elements ine ach vector are combined
z <- c(10, 20, 30)
y <- c(1, 2, 3)
z + y #adds two vectors together

y^2 # each elemtn in y is squared

#more complex vectorized calculations
10 + 3*y + 2*y^2

#####
        #recycling

#what if the vector lengths are not equal to eachother?
z <- c(10, 20, 30)
x <- c(1,2)

z + x
#Warning message: In z + x : longer object length is not a #multiple of shorter object length (30 becomes 31)

x <- 1
z + x
# 1 is added to each elment in z