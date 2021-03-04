#Structued Programming 1
# ISR
# 3.4.21
#NEEEEED TO DOWNLOAD antcountydata, but is not on course website yet!!!!!!!!!!!!!!!!!!!!!!!!!!

#--------------------------Pseudocode--------------
#basics of program
  #get data: get_data()
  #calculate stuff: calculate_stuff()
  #summarize output: summarize_output()
  #graph results: graph_results()

#this is the body of program
#first we must create functions above the body
#---------------------------------------------------


#-----------------Example--------------------------
#Sample program to illustrate structured programming
#with functions.

#All functions must be declared at the start

#Placed functions in MyFunction script
#Add a source line to take whatever text or script file and run it entirely

#We can call MyFunction a library, it can be present in this script but is rather dense
#Must run MyFuncrion so functions avliable

#Preliminaries----------------------------------
#load all packages
library(ggplot2)
set.seed(99)     #for replicable results if using rand nums
#add source of functions
source("MyFunction.R")


#Global Variables---------------------------------
antFile <- "antcountydata.csv"
xCol <- 7 # column 7 has the latitudinal center of each county
yCol <- 5 # Col 5 has number of ant species 


#Program body----------------------------------------
#construct data frame
temp_1 <- get_data(file_name = antFile)

#select variables from table
x <- temp_1[,xCol]  #extract predictor
y <- temp_1[,yCol]  #extract response

#fit regression model
temp_2 <- calculate_stuff(xVar = x, yVar = y)

#extract residuals
temp_3 <- summarize_output(temp_2)

#Graph the results
graph_results(x_var = x, y_var = y)

#prints the residuals
print(temp_3)

#prints model summary
print(temp_2)


#See if functions work
  # get_data()
  # calculate_stuff()
  # summarize_output()
  # graph_results()
