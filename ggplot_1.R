# Isaac Racine
# GG PLot 1
# 30 Mar 2021
#------------------------------------------------

#-------------- Histroy  ---------------

#Base model uses pen and ink model, each time call to graph literally drawing onto it

#ggplot uses grammar mechanic to graph

#-------------- ggplot language ---------------

# 1. data(in data frame)
# 2. aesthetic mapping (variables are mapped to an aesthetic)
# 3. geom (geometric object used to draw the layer; points, bars, polygons, etc.)
# 4. stat (raw data and transforms it for something useful in a plot)
# 5. position (adjust point for overplotting)
# 6. facet function for producing multiple plots
# 7. coordinate function lets use switch  and y axis

#-------------- TEMPLATE for ggplot components ---------------

# p1 <- ggplot(data = <DATA>,
#              mapping = aes(<MAPPING>)) +
#       <GEOM_FUNCTION.(mapping = aes(<MAPPING>),
#                       stat = <STAT>,
#                       position = <POSITION>) +
#       <COORDINATE_FUNCTION> +
#       <FACET_FUNCTION>
# print(p1)
# ggsave(plot = p1,
#        filename = "MyPlot",
#        width = 5,
#        height = 3,
#        unit = "in",
#        device = "pdf")

#-------------- Preliminaries ---------------
library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)

char2seed("doubling time")

d <- mpg #use built in data set on care performance 
str(d)
table(d$fl) #can see categories or values by count

#-------------- fast plotting with qplot ---------------

#meant for looking in the midst of your program

# basic historgram
qplot(x = d$hwy)
qplot(x = d$hwy, fill = I("tan"), color = I("black"))

# make yyour own custom histogram function
my_histo <- function(x_var, fil_col = "goldenrod"){
  qplot( x = x_var, color = I("black"), fill = I(fil_col))}

my_histo(d$hwy)
my_histo(d$hwy, "thistle")

# basic density plot
qplot(x = d$hwy, geom = "density")

# basic scatterplot
qplot(x = d$displ, 
      y = d$hwy,
      geom = c("smooth","point"))

# basic scatterplot with linear regression
qplot(x = d$displ,
      y = d$hwy,
      geom = c("smooth", "point"), method = "lm")

# basic boxplot
qplot(x = d$fl,
      y = d$cty,
      geom = "boxplot",
      fill = I("tan"))

# basic  barplot ("long format")
qplot(x = d$fl, geom = "bar", fill = I("tan"))

# common mistake
qplot(x = d$fl, geom = "bar", fill = "tan") #I stands for identity to may to a specific layer

# bar plot with specified count or means ("Short format")
x_treatment = c("Control", "Low", "High")
y_response = c(12, 2.5, 22.9)
qplot(x = x_treatment, y = y_response, geom = "col", fill = I(c("grey20", "grey50", "grey90")))
      
# basic curves and functions
my_vec <- seq(1, 100, by = 0.1)
head(my_vec)
my_fun <- function(x) sin(x) + 0.1*x
qplot(x = my_vec, y = sin(my_vec), geom = "line") # built in function 
qplot(x = my_vec, y = dgamma(my_vec, shape = 5, scale = 3),
      geom = "line") # density function

qplot(x = my_vec, y = my_fun(my_vec), geom = "line")

#-------------- Themes and fonts ---------------
p1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty)) +
      geom_point()
print(p1)

p1 + theme_classic() # no background grid lines or shading

p1 + theme_linedraw() # adds grid

p1 + theme_dark() #make background dark

p1 + theme_base() #make similar to display of base

p1 + theme_void() #remove axis and title

p1 + theme_economist() #theme form economist mag

p1 + theme_bw() #traditional

p1 + theme_grey() # default theme 

#-------------- Major Theme Modifications ---------------
p1 + theme_classic(base_size = 40)  #scale axis labels fonts and line

p1 + theme_classic(base_family = "serif") # change font

# defaults: theme_grey, base_size = 16, base_family = "Helvetica"

# default font families (Mac): Times, Ariel, Monaco, Courier Helvetica, serif, sans

# use coordinate_flip to invert entire plot
p2 <- ggplot(data = d, mapping = aes(x = fl, fill = fl)) + 
      geom_bar()
print(p2)

p2 + coord_flip()

#-------------- Minor Theme Modifications ---------------
p1 <- ggplot(data = d,
             mapping = aes(x = displ, y =cty)) + 
      geom_point(size = 7, shape = 21, color = "black", fill = "steelBlue")
print(p1)

p1 <- ggplot(data = d,
             mapping = aes(x = displ, y =cty)) + 
  geom_point(size = 7, shape = 21, color = "black",
             fill = "steelBlue") + 
  labs(title = "My graph title here",
       subtitle = "An extended subtitle that will print below main",
       x = "My x axis label",
       y = " My y axis label")
print(p1)

p1 <- ggplot(data = d,
             mapping = aes(x = displ, y =cty)) + 
  geom_point(size = 7, shape = 21, color = "black",
             fill = "steelBlue") + 
  labs(title = "My graph title here",
       subtitle = "An extended subtitle that will print below main",
       x = "My x axis label",
       y = " My y axis label") +
  xlim(0, 4) + 
  ylim(0, 20)
print(p1)
# screened out some of the data

