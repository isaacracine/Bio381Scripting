########################################################
# FUNCTION: get_data
# read in .csv file
# input: .csv file
# output: dataframe
#------------------------------------------------------
get_data <- function(file_name = NULL) {
  if(is.null(file_name)) {
    data_frame <- data.frame(ID = 101:110,
                             varA=runif(10),
                             varB=runif(10))
  } else {
    data_frame <- read.table(file = file_name,
                             header = TRUE,
                             sep = ",",
                             comment.char = "#")
  }
  
  return(data_frame)
}
#get_data()  #uncomment and run to test
########################################################
# FUNCTION: calculate_stuff
# fit an ordinary least squares regression
# input: x and y vector of numeric vals of same length
# output: entire summary of regression model
#------------------------------------------------------
calculate_stuff <- function(x_var = runif(10),
                            y_var = runif(10)) {
  data_frame <- data.frame(x_var, y_var)
  reg_model <- lm(y_var~x_var)
  return(summary(reg_model))
}
#calculate_stuff()    #run uncommented to check if working
########################################################
# FUNCTION: summarize_output
# pull elements from model summary list
# input: list fro summary call of lm
# output: vector of regression residuals
#------------------------------------------------------
summarize_output <- function(z = NULL) {
  if(is.null(z)) {
    z <- summary(lm(runif(10)~runif(10)))
  }
  return(z$residuals)
}
#summarize_output()  #run uncommented to check if working
########################################################
# FUNCTION: graph_results
# one line description
# input: x_var
# output: x
#------------------------------------------------------
graph_results <- function(x_var = runif(10),
                          y_var = runif(10)) {
  data_frame <- data.frame(x_var, y_var)
  # p1 <- ggplot2::qplot(data = data_frame,
  #                      x = x_var,
  #                      y = y_var,
  #                      geom=c("smooth", "point"))
  p1 <- ggplot2::ggplot(data_frame) +
                 ggplot2::aes(x = x_var, y = y_var) +
                 ggplot2::geom_point() + 
                 ggplot2::stat_smooth(method = "lm")
    
                        
  suppressMessages(print(p1))
  message("Regression graph created")
}
graph_results()  #run uncommented to test if working
#########################################################

