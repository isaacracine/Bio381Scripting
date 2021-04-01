# Isaac Racine
# GGPLot day 2
# 01 Apr 2021
#------------------------------------------------

#-------------- Multiple PLots and Aesthetics ---------------

#-------------- Preliminaries ---------------
library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("crocus")
d <- mpg # use mpg data set

#-------------- Multiple plots ---------------

#create a series of plots
g1 <- ggplot(data = d, 
             mapping = aes(x = displ, y =cty)) +
  geom_point() +
  geom_smooth()
print(g1)

g2 <- ggplot(data = d,
             mapping = aes(x =fl,
                           fill = I("tomato"),
                           color = I("black"))) +
  geom_bar(stat = "count") +
  theme(legend.position = "none") #remove figure legend
print(g2)

g3 <- ggplot(data = d,
             mapping = aes(x = displ,
                           fill = I("royalblue"),
                           color = I("black"))) +
  geom_histogram()
print(g3)

g4 <- ggplot(data = d,
             mapping = aes(x = fl, y = cty,
                           fill = fl)) +
  geom_boxplot() +
  theme(legend.position = "none")
print(g4)

#-------------- Use patchwork to combine plots ---------------

#place two plots horizontally
g1 + g2

#place 3 plots vertically
g1 + g2 + g3 + plot_layout(ncol = 1)

# change the relative area of each plot
g1 + g2 + plot_layout(ncol = 1, heights = c(2,1))
#g1 is twice as tall as g2

g1 + g2 + plot_layout(ncol = 2, widths = c(1, 2))
#g2 is twice as wide as g1

#add spacer plot
g1 + plot_spacer() + g2

#use nested plots
g1 + {
  g2 + {
    g3 + 
      g4 +
      plot_layout(ncol = 1)
  }
} +
  plot_layout(ncol= 1)

# - (minus) operator for subtrack element
g1 + g2 - g3 + plot_layout(ncol =1)

# / and | for intuitive plot layouts
(g1 | g2 | g3) / g4

(g1 | g2) / (g3 | g4)

# Add title, subtitle to patchwork
g1 + g2 + plot_annotation("This is a title",
                          caption = "made with patchwork")
#look in bottom right corner

# change the styling of patchwork annotations
g1 + g2 + 
  plot_annotation(title = "This is a title",
                  caption = "made with patchwork",
                  theme = theme(plot.title = element_text(size = 16)))

#add tags to the plot
g1 / (g2 | g3 ) + 
  plot_annotation(tag_levels = 'A')

#-------------- swapping axes and orientation ---------------
g3a <- g3 + scale_x_reverse()
print(g3a)
#reversed x axis

g3b <- g3 +scale_y_reverse()

g3c <- g3 + scale_x_reverse() + scale_y_reverse()

(g3 | g3a) / (g3b | g3c)

#coordinate flips
(g3 + coord_flip() | g3a + coord_flip()) / (g3b + coord_flip() | g3c + coord_flip())

#-------------- aesthetic mappings ---------------
# mapping of discrete varaible to point color
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           color = class)) +
  geom_point(size = 3)
print(m1)

# mapping a discrete varible to point shape (<= 6 groups to work correctly)
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           shape = class)) +
  geom_point(size = 3)
print(m1)

#mapping a discrete variable to point size(not recommended)
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           size = class)) +
  geom_point()
print(m1)

#mapping a continuous variable to point size: MORE useful
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           size = hwy)) +
  geom_point()
print(m1)

# mapping a continuous variable to point color
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           color = hwy)) +
  geom_point(size = 5)
print(m1)

#map two variables o different aesthetics
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           shape = class,
                           color = hwy)) +
  geom_point(size = 5)
print(m1)

# use shape for a smaller number of categories
#map two variables o different aesthetics
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           shape = drv,
                           color = fl)) +
  geom_point(size = 5)
print(m1)

# use all 3 (size, shape, color) to indicate 5 data attributes
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           shape = drv,
                           color = fl,
                           size = hwy)) +
  geom_point()
print(m1)

# mapping a variable to the same aesthetic in two different geoms
m1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = cty,
                           color = drv)) + 
  geom_point(size = 2) + geom_smooth(method = "lm")
print(m1)

#if aesthetics are not specified in geom, then they're inherited from mapping aes


#-------------- Faceting ---------------

# basic faceting w variables split by row, col or both
m1 <- ggplot(data = d, 
             mapping = aes(x = displ, y = cty)) + 
  geom_point()
m1 + facet_grid(class~fl)
#rows~cols
#allows us to see relationships we wouldn't see otherwise
#scale is same in each graph: good for comparisons

# change axes by letting some of them be free
m1 + facet_grid(class~fl, scales = "free_y")
# diff scale for each y 

# let both axes be free in scale
m1 + facet_grid(class~fl, scales = "free")

#facets also work with one-way layout
#collapse over one of two axes
m1 + facet_grid(.~class)
#collapses over fuel type, just looking at diffs in classes
#each class comes up as column in graph

#one way with differing rows
m1 + facet_grid(class~.)
#now the classes are shown by row


# use facet wrap when variables are not crossed
m1 + facet_grid(.~class)
m1 + facet_wrap(.~class)
#wrap does not lay out by individual cols/rows, algorithm rather maximizes squareness of plots and figures

# add a second variable to facet wrap
m1 + facet_wrap(~class + fl)
# each of the combination are slapped together in a plot, only for plots where there is data

# include "empty" combos in facet_wrap
m1 + facet_wrap(~class + fl, drop =FALSE)
#retains empty data combos

#contract w grid two way layout
m1+ facet_grid(class~fl)



#can use facet w other aesthetic mappings within rows or cols
m1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = cty, 
                           color = drv)) +
  geom_point()
m1 + facet_grid(.~class)             

#easy to switch to other geoms
m1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = cty, 
                           color = drv)) +
  geom_smooth(se = FALSE, method = "lm")
m1 + facet_grid(.~class)  
#removes the smoothing, CI, around the regression line

# fitting boxplots w a continuous variable
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty)) +
  geom_boxplot()
m1 + facet_grid(.~class)
#box plots located over average displacement

# add a "group" and fill mappings for subgroups
m1 <- ggplot(data = d,
             mapping = aes(x = displ, y = cty,
                           group = drv, fill = drv)) +
  geom_boxplot()
m1 + facet_grid(.~class)
#same as previous, except now there can be three boxplots in each facet, simulating the drive type

#-------------- Aesthetic mapping ---------------
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy)) + 
  geom_point() + geom_smooth()
print(p1)

#break out drive types (note what "group" designation affects)
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy,
                           group = drv)) + 
  geom_point() + geom_smooth()
print(p1)
#Grouping splits the smoothing by group

# break out drive types (note what "color" affects)
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy,
                           color = drv)) + 
  geom_point() + geom_smooth()
print(p1)
#color mapping affects the line and point color for each group
#if have a boxplot or bar plot then fill is needed


# break out drive types (note what "fill" affects)
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy,
                           fill = drv)) + 
  geom_point() + geom_smooth()
print(p1)

# color both points and CI if choose too
# break out drive types (note what "color" affects)
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy,
                           color = drv,
                           fill = drv)) + 
  geom_point() + geom_smooth()
print(p1)

#use aesthetic mappings to override defaults
# subset data to plot what is needed
# break out drive types (note what "color" affects)
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy,
                           color = drv)) + 
  geom_point(data = d[d$drv == "4",]) + geom_smooth()
print(p1)
#prints only the points of drive of 4 due to subsetting


#instead of subsetting, just map an aesthetic
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy)) + 
  geom_point(mapping = aes(color = drv)) + geom_smooth()
print(p1)
#w/ og mapping is doing points and smoother, however now it is just points that are being colored due to mapping the aesthetic within the geom_point object

# conversely, map the smoother, but not the points
p1 <- ggplot(data = d,
             mapping = aes(x = displ,
                           y = hwy)) + 
  geom_point() + geom_smooth(mapping = aes(color = drv))
print(p1)
