# Isaac Racine
# Batch Processing
# 26 Mar 2021
#------------------------------------------------

#-------------- Path Names and Console Commands ---------------
#getwd() : prints working directory 
  # C: is the root
  # isaac: home directory

#absolute path: beigin with root
#relative path: system begins where it is right now, no \ for root


#list.files() : displays all files
  # can also place a directory that is a file w/ in ()
    # if I had a folder called scripts I would do:
      #  list.files("scripts")

# dir.create() : creates directory 
  # will create directory from wherever getwd() is
  # pass directory name like this: dir.create("Practice")
  # can also create directory within a directory
    # dir.create("Pracitice/MyFiles")
  # if making a new directory within another new directory must do:
    # dir.create("Practice1/MyFiles", recursive = TRUE)

#-------------- File Creation ---------------
# normally would be getting own data files

# today will use a function to create files for us

#---------------------------------------
# FUNCTION file_builder
# description: creates a set of random files for regression
# inputs: file_n = number of data files to create
#         file_folder = name of folder for random files
#         file_size = c(min, max) number of rows in file
#         file_NA = avergae number of NA values per column
# outputs: output_description
########################################
file_builder <- function(file_n = 10, 
                         file_folder = "RandomFiles/",
                         file_size = c(15,100),
                         file_NA = 3) {
  for (i in seq_len(file_n)){
    file_length <- sample(file_size[1]:file_size[2], size = 1) #choose random number from range of file size as length of file
    var_x <- runif(file_length)
    var_y <- runif(file_length)
    df <- data.frame(var_x, var_y)
    bad_vals <- rpois(n = 1, lambda = file_NA) # determine NA number
    df[sample(nrow(df), size = bad_vals), 1] <- NA 
    #sample function randomly picks rows to populate
    #poission used to choose rand num of NAs
    df[sample(nrow(df), size = bad_vals), 2] <- NA
    
    #create label for file name w padded zeros
    #allows for proper display of files
    file_label <- paste(file_folder, "randFile",
                        formatC(i,
                                width = 3,
                                format = "d",
                                flag = "0"),
                        ".csv", sep = "")
    # set up data file and incorporate time stamp and minimal metdata
    write.table(cat("# Simulated random data file for batch processing", "\n",
                "# timestamp: ", as.character(Sys.time()),
                "\n",
                "# ISR", "\n",
                "# --------------", "\n",
                "\n", 
                file = file_label,
                row.names = "",
                col.names = "",
                sep = ""))
    #now add the data frame
    write.table(x = df,
                file = file_label,
                sep = ",",
                row.names = FALSE,
                append = TRUE)} #end loop
  

} # end of file_builder
#---------------------------------------

#---------------------------------------
# FUNCTION reg_stats
# description: fits linear models, extract model stats
# inputs: 2-col data frame (x and y)
# outputs: slope, p-val and r-squared
########################################
reg_stats <- function(d = NULL) {
  if(is.null(d)){
    x_var <- runif(10)
    y_var <- runif(10)
    d <- data.frame(x_var, y_var)
  }
  
  . <- lm(data = d, d[,2]~d[,1])
  . <-summary(.)
  stats_list <- list(Slope = .$coefficients[2,1],
                     pVal = .$coefficients[2,4],
                     r2 = .$r.squared)
  
return(stats_list)

} # end of reg_stats
#---------------------------------------

#-------------- Actual Body of Program ---------------

library(TeachingDemos)
char2seed("Flatpicking solo")

#############################################          
#Global variables
file_folder <- "RandomFiles/"
n_files <- 100
file_out <- "StatsSummary1.csv"
#############################################  

#Create random data sets
dir.create(file_folder)
file_builder(file_n = n_files)
file_names <- list.files(path = file_folder)

#create a df to hold summary files statistics 
ID <- seq_along(file_names)
file_name <- file_names
slope <- rep(NA, length(file_names))
p_val <- rep(NA, length(file_names)) 
r2 <- rep(NA, length(file_names))

stats_out <- data.frame(ID, file_name, slope, p_val, r2)


#-------------- Serious Work ---------------
#batch process by looping through individuals
for ( i in seq_along(file_names)){
  data <- read.table(file = paste(file_folder, file_names[i],
                                  sep = ""),
                     sep = ",",
                     header = TRUE) 
  d_clean <- data[complete.cases(data), ] # subset for clean cases
  . <- reg_stats(d_clean) #pull out regression stats from clean file
  stats_out[i, 3:5] <- unlist(.) #unlist and copy into last 3 cols
}

#set up an output file and incorporate time stamp and minimal metdata
write.table(cat("# Summary stats for", 
                "batch processing of regression models",
                "\n",
                "# timestamp: ", as.character(Sys.time()),
                "\n",
                file = file_out,
                row.names = "",
                col.names = "",
                sep = ""))

#now add the data frame
write.table(x = stats_out,
            file = file_out,
            row.names = FALSE,
            col.names = TRUE,
            sep = ",",
            append = TRUE)

  