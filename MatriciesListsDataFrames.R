#Matricies, lists, data frames
#2.16.21
#ISR
#--------------------------------------------
#preliminaries
library(ggplot2)


#---------------Matricies-------------------

#Matrix: an atomic vector wrapped up in 2D structure
#   it is built from an atomic vector
m <- matrix(data=1:12, nrow=4, ncol=3)
print(m)

m <- matrix(data=1:12, nrow=4)
print(m)

#Fill one row at a time in order rather than by col
m <- matrix(data=1:12, nrow = 4, byrow=TRUE)
print(m)

#use function dim to see dimensions 
dim(m)  #2 number vector, number of rows, num of cols

#matrix dimesnions can be changed (must be correct size)
dim(m) <- c(6,2)
print(m)
dim(m) <- c(4,3)
print(m)

#get row and col nums seperately
nrow(m)
ncol(m)

#NOTE!!!! the len of matrix is referring to the atomic vector underlying
length(m)

#can add names
rownames(m) <- c("a","b","c","d")
print(m)
colnames(m) <- LETTERS[1:ncol(m)]
print(m)
#reverse order
rownames(m) <- letters[nrow(m):1]
print(m)

####    INDEXING Matrix
#Specify single element
print(m[2,3]) #prints second row, third col

#subset an entire row or col bu leaving other dim blank
print(m[2,])  #prints all of row 2
print(m[,3])  #prints all of col 3

#print entire matrix
print(m)
print(m[,])
print(m[])

rownames(m) <- paste("species", LETTERS[1:nrow(m)], sep="")
colnames(m) <- paste("Site", 1:ncol(m), sep ="")    
print(m)

#instead of separate calls use dimnames
#two elements, first passes to row names, second passes to col names
dimnames(m) <-list(paste("species", LETTERS[1:nrow(m)], sep=""), paste("Site", 1:ncol(m), sep ="") )
print(m)

#TRANSPOSE a amtrix w/ t(): switches row and col
m_trans <- t(m)
print(m_trans)

#ADDING a ROW w/ rbind()
#rbind(matrix, thing wish to bind)
m2 <- rbind(m_trans, c(10,20,30,40)) 
print(m2)
#fix label
rownames(m2)  #call species vector, so find element which will replace/add name
rownames(m2)[4] <- "Site4"
print(m2)

#NAMED MATRIX allows access to individ row and cols by name
m2["Site4","speciesA"]


#ADDING COLS to matrix with cbind()
speciesE <- c(13,2,0,1)
m2 <- cbind(m2, speciesE)
print(m2) #Since speciesE is declared as atomic vector its name is carried over for the column

#CONVERT back to atomic vec
my_vec <-as.vector(m2)
print(my_vec)



#-----------------LISTS---------------------
#lists are an atomic vector, but it can hold
#objects of diff types
my_list <- list(1:10, matrix(1:8,nrow=4,
                byrow=TRUE), letters[1:3], pi)
#str = structure, shows data type and each element grouped
str(my_list)
#print shows each list element seperately in double []
print(my_list)


#using sinle brackets [] does not give contents
#it just gives the list item!
my_list[4]
my_list[4] - 3  #FAILS

#if a list has 10 elements it is like a train with 10 cars
#contents of the 5th car must do [[5]]
#[c[4,5,6]] create a little train with cars 4,5 and 6

#use double brackets then carry out operations
my_list[[4]] - 3  #RUNS 

#once double bracket is called, individ elements can
#be accessed in the usual way
my_list[[2]]
#content of second list item is matrix
#to pull out certain item in  list do as follows
my_list[[2]][4,1] 


#name list items when they are created
my_list2 <- list(tester = FALSE, little_m = matrix(1:9, nrow=3)) 

#named elements can be accessed w the dollar sign prefix
#specifies element little_m, and selects item in 2 row and 3 col of the matrix
my_list2$little_m[2,3]
my_list2$little_m  #print entire matrix
my_list2$little_m[2,]  #prints second row
my_list2$little_m[2]  #second element of vector


#the unlist function puts everything into a single atomic vector
unrolled <- unlist(my_list2)
print(unrolled)
#tester is converted from boolean to numeric
#allows for items to be found easily


#output from a linear model is a list with info we need
y_var <- runif(10)
x_var <- runif(10)
#create linear model w/ lm where y is fitted to x
my_model <- lm(y_var~x_var)
qplot(x=x_var, y=y_var)
#look at output
print(my_model) #give intercept and slope
#summary statistics
summary(my_model)
str(summary(my_model))

#pull out what we need
summary(my_model)$coefficients
str(summary(my_model)$coefficients)
stats <- summary(my_model)$coefficients
stats["x_var","Pr(>|t|)"]
stats[2,4] #same as above more consise

#let's get our numbers using unlist
u <- unlist(summary(my_model))
print(u)
my_pval <- u$coefficients8


#---------------Data Frames---------------------
#a specialized kind of list
#is a list of equal length atomic vectors
#in a matrix all data of same type, but in df
#diff data types spread across cols

var_a <- 1:12
var_b <- rep(c("Control", "LowN", "HighN"), each =4)
var_c <- runif(12)
#stringsasfactors = False, good bc do not want to always set strings as factors, is no default
d_frame <- data.frame(var_a, var_b, var_c)
str(d_frame)
print(d_frame)
#good to make a column of indexes, that way when subsetting know what rows


#add rows to df: rbind()
#make sure you add it as a list with each named item
#corresponding to a column
new_data <- list(var_a=13, var_b = "HighN", var_c=0.6687)
#can put new-data first but will be added to the begining
d_frame <- rbind(d_frame, new_data)
str(d_frame)
tail(d_frame)

#add columns to df: cbind()
#not in a list strcutre, because everythin in one column is of same data type
var_d <-runif(13)
d_frame <- cbind(d_frame, var_d)
str(d_frame)
print(d_frame)

#more concise addition of a col
d_frame$var_e <- 13:1
str(d_frame)
print(d_frame)
d_frame$var_f <- rnorm(12)  #errors bc not same dim
d_frame$var_f <- c(rnorm(12), NA)
str(d_frame)
print(d_frame)
tail(d_frame)
