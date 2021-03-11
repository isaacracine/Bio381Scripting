# Isaac Racine
# Control Structure Day 1: boolean and if/else 
# 11 Mar 2021
#------------------------------------------------
#-------------- Review of Boolean ---------------

# Simple inequalities
  # uses logical operators
5 > 3 #true
5 < 3 #false
5 >= 5 #true
5 <= 5 #true
5 == 3 #does 5 equal 3 -> false
5 != 3 #not equal -> true

#compound statements use & or |
  # use & for and
  # use | for or

FALSE & FALSE # false
FALSE & TRUE  # false
TRUE & TRUE   # true
FALSE | FALSE # false
FALSE | TRUE  # true
TRUE | TRUE   # true

5 > 3 & 1 != 2  # true
1 == 2 & 1 != 2 # false
1 == 2 | 1 != 2 #true

# boolean operators wok with vectors

#each element in 1:5 vector is compared to statement
1:5 > 3

a <- 1:10
b <- 10:1
# will compare each element in list to >4 and return t/f
a > 4 & b > 4

sum(a > 4 & b > 4) # coerces booleans to numeric values
#produces 2 n/c 2 true vals


# "long" form evaluates only the first element

# evalute all elements give a vector of T/F
a < 4 & b > 4
# evaluate only the first comparison that gives a boolean
a < 4 && b > 4

# also a long form for or ||

#vector result
a < 4 | b > 4
#single boolean result
a < 4 || b > 4


# xor for exclusive "or" testing of vectors
# works for (TRUE FALSE) but not for (FALSE FALSE)
# or (TRUE TRUE), thus requires one T and one F

a <- c(0,0,1)
b <- c(0,1,1)
xor(a,b)
# middle is true because different values

# by comparison with an ordinary |
a | b
# middle and last are true because each has at least 1


#-------------- set operations ---------------

# boolean algebra on sets of atomic vectors (numeric,
# logical, character strings)

# can think of this as a ven-diagram

a <- 1:7
b <- 5:10

# union function to get all elements
# complete set between individuals (no repeats)
union(a,b)

# intersection to get common elements
intersect(a,b)

# setdiff to get distinct elements in A not in B
setdiff(a,b)
#distinct in B not in A
setdiff(b,a)

# setequalto check for identical elements
# not common / the same
setequal(a,b)

# more generally to compare any two objs
z <- matrix(1:12, nrow =4, byrow=TRUE)
z1 <- matrix(1:12, nrow = 4, byrow = FALSE)

# this just compares element by element
z == z1
# returns matrix of boolean with T/F values

# looks to se eif all slots are identical
identical(z,z1)

z1 <- z
identical(z, z1)

# most useful in if statements is %in% or is.element
# these are equivalent, but prefer %in% for readability

d <- 12
d %in% union(a,b)
is.element(d, union(a,b))


a <- 2
a == 1 | a == 2 | a == 3
a %in% c(1,2,3)

# check for partial matching w vector comparison
a <- 1:7
d <-  c(10,12)

#each element in d compared to argument
d %in% union(a,b)
d %in% a
