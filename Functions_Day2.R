# Isaac Racine
# Illustrate the use of functions and structured programming
# 09 Mar 2021
#------------------------------------------------
# All functions must be included at the top of the program
# this is because they need to come before they're called

#-------------- load libraries ---------------
library(ggplot2)
#necessary if ggplot2:: was not used, but bad programming

#-------------- source files ---------------
source("MyFunction_Day2.R")
#ALWAYS check path
#if need to add "Course_BlaBla/Topic_Blah/File_Blah"

#-------------- global variables ---------------
ant_file <- "antcountydata.csv"
x_col <- 7 #col 7, latitude center of each county 
y_col <- 5 #col 5, num of ant species

#-------------- RUnning the functions ---------------
#read in data
temp1 <- get_data(file_name = ant_file)

x <- temp1[,x_col] #extract predictor var
y <- temp1[,y_col] #extract response var

#fit regression model
temp2 <- calculate_stuff(x, y)

#extract residuals
temp3 <- summarize_output(temp2)

#create graph
graph_results(x_var = x, y_var = y)

#look at temp vars
print(temp3)
print(temp2)


