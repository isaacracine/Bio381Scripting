# Data structure comparisons and Data Curations
# 2.18.21
#ISR
#----------------------------

#Distinction bt lists and matricies

#creat a matrix and data frame w same structure
z_mat <- matrix(data=1:30, ncol= 3, byrow = TRUE)
z_dframe <- as.data.frame(z_mat)

#comapr structures
str(z_mat)  #atomic vector in 2D
str(z_dframe) #lisr w 3 int vectors

head(z_dframe) #can see the autommatic var naming
head(z_mat) #no automatic names

#put some in for z_mat so truly the same
colnames(z_mat) <- c("V1", "V2", "V3")


#element refrencing is the same in both
z_mat[3,3]
z_dframe[3,3]

#row referencing is also the same
z_mat[3,]
z_dframe[3,]

#column referencing is also same
z_mat[,3]
z_dframe[,3]

#one difference when calling by name !!!!!!
z_mat[,"V3"]  #grabs third col
z_dframe[,"V3"] #method one
z_dframe$V3  #method two

#what happens if only reference 1 dimension
z_mat[3]  #gives third element of matrix
#BUT for df
z_dframe[3] #actually selects entire third col

#df: set of atomic vectors of all same length but not #all same type

#VS:

#matrix: atomic vector with all same type

#-----------------Subsetting-------------------
m <- matrix(1:12, nrow=3)
dimnames(m) <- list(paste("Species",
                          LETTERS[1:nrow(m)],sep = ''),
                    paste("Site", 1:ncol(m), sep=""))

#subset based on elements
m[1:2,3:4]  #first two rows, 3 and 4 col
#can also do it with names
m[c("SpeciesA","SpeciesB"),c("Site1","Site2")]

m[1:2,] #first two rows for all cols
m[,3:4] #cols 3 and 4 of all rows


#####Using logicals for more complex subsetting
colSums(m) > 15 #returns boolean for each cols
m[,colSums(m) >15]

#now for the rows
m[rowSums(m) == 22,]  #prints elements for row that sums to 22

#select for NOT relation
m[!rowSums(m) == 22,]


#choose all rows for which the numbers for site 1 < 3
# and choose all cols for which the nums of species A < 5
m[,"Site1"] < 3
m[m[, "Site1"] < 3,] 
#takes all entries in rows for any row where site1 is less than 3


#Set up the logical for cols
m["SpeciesA",] < 5
m[,m["SpeciesA",] < 5]
#returns entire column for any entry with SpeciesA < 5

#COMBINE
m[m[,"Site1"]<3,m["SpeciesA",]<5]


###CAUTION
#when subscripting a matrix, you can accidentally convert
#the matrix to a vector
z <- m[1,]
print(z)
str(z)

#AVOID BY
#use drop = FALSE
z2 <- m[1,,drop = FALSE]
print(z2)
str(z2)


#--------------------DATA CURATION-----------------
#metadata <- infromation about the data
#stored in first column of a spread sheet
#all start with a hashtag
#once metadata finished can begin to enter data

#always make each row have an id (index)
#can embed comments within the spread sheet w/ #

#this format allows for the metadata to be embedded

#----------------IN and OUTputs-------------------
#where are you / what path
#in terminal: pwd   or in console: getwd()

#use read.table to import a .csv file as a df
#give an absolute path statement
#header = TRUE used for metadata
#must use sep = "," but depends on file type
#comment.char used for comments
my_data <- read.table(file = "C:/Users/isaac/Desktop/OriginalDataCleaned.csv", header = TRUE,
                      sep =",",
                      comment.char = "#")

###error the first time bc a carriage return must be done
#after the last line in files being read by R

str(my_data)

#There is a problem however, because of the absolute path
#fix this using a RELATIVE path to get to the data
my_data1 <- read.table(file = "../OriginalDataCleaned.csv", header = TRUE,
                      sep =",",
                      comment.char = "#")

#the double period instructs path statement ot go up one level from where we are in the directoy
#however, the data is in the desktop and this project is not, would work if project was on the desktop
#that's why all [rojects should have foldersss

#ADDING a new variable
my_data$newVar <- runif(4)
str(my_data)

#NOT BEST WAY to use R
#WRITE a .csv to disk
#saving the dataframe as a different csv file
#can also use RELATIVE and not DIRECT path w/ ..
#also don't need header = TRUE bc R will automatically assign
#headers if none present
write.table(x = my_data,
            file = "C:/Users/isaac/Desktop/ModifiedData.csv",
            sep = ",")
            

#####INSTEAD use saveRDS() function to create a binary obj
#that R can read and use
#use .. instead for RELATIVE path
#us optional .RDS suffix for clarity
saveRDS(my_data,
        file = "C:/Users/isaac/Desktop/my_data.RDS")
 
#can then bring into comp
z <- readRDS(file="C:/USers/isaac/Desktop/my_data.RDS")
str(z)


#THESE are great for sharing / collaberating 
#Best to just save as RDS and do new script for actual computation
#can combine objs in R
    #thus can combine several things need for a project in 
    # one RDS file

#DO NOT USE save() and load()
#save and loads the entore meomery environmnet
