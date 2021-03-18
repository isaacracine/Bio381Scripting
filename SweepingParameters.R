# Isaac Racine
# Parameter Sweeping
# 18 Mar 2021
#------------------------------------------------
# writing functions for equations and sweeping over parameters
library(ggplot2)

# S = cA^z describes species area relationship
  # the number of species that can be found in relation to the area

#---------------------------------------
# FUNCTION species_area_Curve
# description: creates a power function for S and A
# inputs: A is a vector of island areas
#         c is the intercept constant
#         z is the slope constant
# outputs: S is a vector of species richness
########################################
species_area_Curve <- function(A = 1:5000,
                               c = 0.5,
                               z = 0.26) {
  S <- c*(A^z)
# function body

return(S)

} # end of species_area_Curve
#---------------------------------------
head(species_area_Curve())


#---------------------------------------
# FUNCTION species_area_plot
# description: plots the species area curve with parameter values
# inputs: A = vector of area
#         c = single value for c parameter
#         z = single value for z parameters
# outputs: smoother curve with parameters printed in graph
########################################
species_area_plot <- function(A = 1:5000,
                              c = 0.5,
                              z = 0.26) {
  
  plot(x = A, y = species_area_Curve(A, c, z),
       type = "l",
       xlab = "Island Area",
       ylab = "S (number of species)",
       ylim = c(0,2500))  
  mtext(paste("c = ", c, " z = ", z), cex = 0.7)

} # end of species_area_plot
#---------------------------------------
species_area_plot()

# build a grid of plots (faceting)

# global variables
c_pars <- c(100, 150, 175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)
par(mfrow = c(3, 4)) # grid arrange with 3 rows and 4 cols

for(i in seq_along(c_pars)){
  for(j in seq_along(z_pars)){
    species_area_plot(c = c_pars[i], z = z_pars[j])
  }
}

# Nick does not like while loop, would rather use a break in a for loop

#-------------- expand.grid ---------------
expand.grid(c_pars, z_pars)
# creates a df where each row corresponds to a different combination of the parameters presented


#---------------------------------------
# FUNCTION sa_output
# description: summary stats for species area power function
# inputs: vector of predicted species richness values
# outputs: list of max - min, coefficient of variation
########################################
sa_output <- function(S = runif(1:10)) {
  
  sum_stats <- list(s_gain = max(S) - min(S),
                    s_cv = sd(S) / mean(S))
  
return(sum_stats)

} # end of sa_output
#---------------------------------------
sa_output()

#Build program body

# Global variables
Area <- 1:5000
c_pars <- c(10, 150, 175)
z_pars <- c(0.10, 0.16, 0.26, 0.30)

# set up model data frame
model_frame <- expand.grid(c = c_pars, z = z_pars)
str(model_frame)
model_frame$SGain <- NA
model_frame$SCV <- NA
head(model_frame)

# cycle through model calculations
for(i in 1:nrow(model_frame)) {
  
  # generate S vector
  temp1 <- species_area_Curve(A=Area,
                              c=model_frame[i,1],
                              z=model_frame[i,2])
  #calculate output stats
  temp2 <- sa_output(temp1)
  
  # pass results to cols in df
  model_frame[i, c(3,4)] <- temp2
}
print(model_frame)

#############################################  
# parameter sweep redux with ggplot graphics

area <- 1:5
c_pars <- c(100, 150, 175)
z_pars <- c(0.1, 0.16, 0.26, 0.3)

#set up model frame
model_frame <- expand.grid(c =c_pars,
                           z = z_pars,
                           A = area)
head(model_frame)
nrow(model_frame)

# add response variable
model_frame$S <- NA

# loop thru parameters and fill w sa function
for (i in 1:length(c_pars)){
  for (j in 1:length(z_pars)){
    model_frame[model_frame$c == c_pars[i] & model_frame$z == z_pars[j], "S"] <- species_area_Curve(A = area, c = c_pars[i], z = z_pars[j])
  }
}
head(model_frame)

#-------------- Lattice Plots---------------
p1 <- ggplot(data = model_frame)
p1 + geom_line(mapping = aes(x = A, y = S)) +
  facet_grid(c~z)

p2 <- p1
p2 + geom_line(mapping = aes(x = A, y = S, group = z)) +
  facet_grid(.~c)
# the . in face grid says to combine all Z's onto same plot for c

p3 <- p1
p3 + geom_line(mapping = aes(x = A, y = S, group = c)) +
  facet_grid(z~.)
