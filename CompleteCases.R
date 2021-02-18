# Complete cases function
# Cleans out vector / matrix so no NAs
# 2.18.21
# ISR
#-----------------------------------
z <- c(10,20,NA,NA,50)

#returns true if value, false if NA
#thus gives a boolean vector 
complete.cases(z)

#gets rid of NAs
z[complete.cases(z)]

#use which to return indexes, however is looking
#for not (!) true instances
which(!complete.cases(z))

#sweeping out missing values in a matrix
#try to make dimmensions different nums
#prevents future errors
m <- matrix(1:20, nrow=5)
print(m)
m[1,1] <- NA
m[5,4] <- NA
print(m)

#eliminate rows with any missing vals
m[complete.cases(m), ]

#remove NA rows just from first and second col
m[complete.cases(m[,c(1,2)]), ] #drops row 1
m[complete.cases(m[,c(2,3)]), ] #drops no rows
m[complete.cases(m[,c(3,4)]), ] #drops rpw 5
m[complete.cases(m[,c(1,4)]), ] #drops rows 1 and 5
