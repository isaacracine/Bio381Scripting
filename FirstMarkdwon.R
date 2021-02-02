## ----------------------------------------------
# Don't forget to start with comments
# Let's make a predictor variable

#Preliminaries
library(ggplot2)

pred <- 1:10 #vector of 10 integers
res <- runif(10) #random uniform values

#print the random numbers
print(res)

#plot the graph
qplot(x = pred, y = res)


