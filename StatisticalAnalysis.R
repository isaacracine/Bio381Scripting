#Statistical Relationship /Analysos
# Isaac Racine
# 2.25.21


#-----------CAUSE AND EFFECT RELATIONSHIPS----------
#measured in vars x and y
# NULL: X nd y do not affect eachother
# X causes Y

#approriate controls, random, manipulation, repetition
#does not give much insight of how x affects y

#IF neither were manipulated then must consider
    # y affects X
    # both x and y afect eachother : recpircal feedback loop
    # x and y don't affect eachother, but affected by var Z

#----------- Types of Variables-------------

#Discrete: distinct categores (species, sexes, treatments)
    #represented with character string

#Continuous: measured w real nums on a continuous scales
    #mass, length, vol
    #represented with numeric

#                 Response Continuous        Response Discrete
#Predictor Cont       linear reg              logistic reg
#Predictor Discret      ANOVA             Contingency Table  

    #linear reg: y = a + bx, then NULL: b = 0 or slope = 0
      #scatter plot: each data point represented in graph
    #ANOVA: NULL: the avg of response var among treatment groups does not differ
      #box plot: shows mean and vars of each compared groups
    #logistic regression
      #scatter plot???
    #Contingency Table Analysis
      # mosaic plot or bar graph

#-----------------PRACTICE-------------------------

library(tidyverse)
library(ggplot2)


#------------ Linear Regression Practice --------------------
#df construction for regression analysis
n <- 50 # num of obs (rows)
var_A <- runif(n) #rand uniform (independent var, x)
var_B <- runif(n) # random uniform (dependent)
var_C <- 5.5 + var_A * 10 # create noisy linear rltnship w varA

ID <- 1:n

reg_data <- data.frame(ID, var_A, var_B, var_C)
head(reg_data)
str(reg_data)

#regression analysis in R
reg_model <- lm(var_B ~ var_A, data = reg_data) #varB is a function of varA

print(reg_model)
str(reg_model)
head(reg_model$residuals) #contains residuals

#summary has the elments that we need
summary(reg_model)

z <- unlist(summary(reg_model))

reg_stats <- list(intercept = z$coefficients1,
                  slope = z$coefficients2,
                  intercept_p = z$coefficients7, #null slope
                  slope_p = z$coefficients8,
                  r2 = z$r.squared)

print(reg_stats)                  
#easy to add important values after making list

reg_stats$r2
reg_stats[[5]]
reg_stats[5] #NO! this is just a list item

#PLOTTING
reg_plot <- ggplot(reg_data) +
  aes(x = var_A, y = var_B) +
  geom_point() +
  stat_smooth(method = lm, se = 0.99) #default = 0.95

print(reg_plot)
ggsave(filename = "RegressionPlotPractice.pdf",
       plot = reg_plot,
       device = "pdf")

#-------------------ANOVA----------------------
n_group <- 3 # num of treatment groups
n_name <- c("Control", "Treat1", "Treat2") #names of groups
n_size <- c(12, 17, 9) #sample sizes for each treatment

#BEST to have 10 sample sizes for each treatment!!!!!!

n_mean <- c(40, 41, 60) #mean responses
n_sd <- c(5, 5, 5)  #sd of each group

#one of the assumptions is that their vars a relatively equal
#if not can preform transformations to better fit

ID <- 1:sum(n_size) #create unique ID

res_var <- c(rnorm(n = n_size[1], mean = n_mean[1],
                   sd = n_sd[1]),
             rnorm(n = n_size[2], mean = n_mean[2],
                   sd = n_sd[2]),
             rnorm(n = n_size[3], mean = n_mean[3],
                   sd = n_sd[3]))

trt_group <- rep(n_name, n_size)  #matches item by item             
ano_data <- data.frame(ID, trt_group, res_var)
head(ano_data)

# anaylsis of variance
ano_model <- aov(res_var ~ trt_group, ano_data)
print(ano_model)

z <- summary(ano_model)
print(z)
flat_out <- unlist(z)
ano_stats <- list(f_ratio <- unlist(z)[7], 
                  f_pval <- unlist(z)[9])
print(ano_stats)

#basic graphis w ggplot
ano_plot <- ggplot(ano_data) +
  aes(x = trt_group, y = res_var) +
  geom_boxplot()
print(ano_plot)

ggsave(filename = "ANOVAPlotPractice.pdf",
       plot=ano_plot,
       device = "pdf")


#------------------Logistic Regression--------------
#NULL: getting 0 or 1 is independent of x value
    #predicts the regression line is flat at 0.5

#construct df
x_var <- sort(rgamma(n=200, shape = 5, scale = 5)) #continuous
y_var <- sample(rep(c(1,0), each = 100), prob = seq_len(200))
lreg_data <- data.frame(ID = 1:200, xVar = x_var,
                        yVar = y_var)
head(lreg_data)

# analysis
lreg_model <- glm(yVar ~ xVar, data = lreg_data,
                  family = binomial(link = logit))
print(lreg_model)
summary(lreg_model)
summary(lreg_model)$coefficients

#plotting
lreg_plot <- ggplot(lreg_data) +
  aes(x = xVar, y = yVar) +
  geom_point() +
  stat_smooth(method = glm,   #this is where they differ
              method.args = list(family = binomial))   
print(lreg_plot)

ggsave(filename = "LogisticRegPlotPractice.pdf",
       plot = lreg_plot,
       device = "pdf")


#------------------Contingency Table------------