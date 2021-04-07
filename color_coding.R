# Isaac Racine
# Bar plot geoms and colors in ggplot
# 06 Apr 2021
#------------------------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
#library(colorblindr)
library(cowplot)
library(colorspace)
library(ggsci)
library(wesanderson)
library(TeachingDemos)


char2seed("Dark Star")
d <- mpg

#############################################  

#-------------- working with black and white---------------

# gray colors and gray functions 
# built in gray colors (0  = black 100 = white)
my_grays <- c("gray20", "gray50", "gray80")
demoplot(my_grays, "bar")

my_grays2 <- gray(seq(from = 0.1, 
                      to = 0.9,
                      length.out = 10))
print(my_grays2)
demoplot(my_grays2, "heatmap")

# convert colors plots to black and white
p1 <- ggplot(d, aes(x = as.factor(cyl),
                    y = cty,
                    fill = as.factor(cyl))) +
                    geom_boxplot()
plot(p1)

#colorblindr would not download :(
p1_des <- colorblindr::edit_colors(p1, desaturate)
plot(p1_des)

#desaturate with custom color
p2 <- p1 + scale_fill_manual(values = c("red", "blue", "green", "yellow"))
plot(p2)

#again no colorblindr
p2_des <- colorblindr::editcolors(p2, desaturate)
plot(p2_des)

#using alpha transparency for histogram
x1 <- rnorm(n = 100, mean = 0)
x2 <- rnorm(n = 100, mean =2.7)
d_frame <- data.frame(v1 = c(x1, x2))
lab <- rep(c("Control", "Treatment"), each = 100)
d_frame <- cbind(d_frame, lab)
tr(d_frame)


#create a plot
h1 <- ggplot(d_frame, aes(x = v1, fill = lab))
h1 + geom_histogram(position = "identity",
                    alpha = 0.5,
                    color = "black")

# color customization in ggplots
d <- mpg 

# discrete classification
# scall_fill_manual() (histogram, boxplots, bars)
# scale_color_manual() (lines, points)

# box plot with no color
p_fil <- ggplot(d, aes(x = as.factor(cyl), y = cty))
p_fil + geom_boxplot()

# boxlot w default fill
p_fil <- ggplot(d, aes(x = as.factor(cyl), y = cty,
                       fill = as.factor(cyl)))
p1 + geom_boxplot()

# create custom color palette
my_cols <- c("red", "brown", "blue", "orange")
p_fil + geom_boxplot() +
  scale_fill_manual(values = my_cols)

#scatterplot w no color
p_col <- ggplot(d, aes( x = displ, y = cty)) + 
  geom_point(size = 3)
print(p_col)

#scatter default ggplot colors
p_col <- ggplot(d, aes( x = displ, y = cty,
                        col = as.factor(cyl))) + 
  geom_point(size = 3)
print(p_col)

# scatterplot woth custom colors
p_col + scale_color_manual(values = my_cols)

# continous classification for color gradient 

# defaul color gradient

p_grad <- ggplot(d, aes(x = displ, 
                        y = cty, 
                        col = hwy)) + 
                   geom_point(size = 3)
print(p_grad)                 

# custom sequential gradient (2 colors) 
p_grad + scale_color_gradient(low = "green",
                              high = "red")

#custom divergin gradient (3 colors)
mid <- median(d$hwy)
p_grad + scale_color_gradient2(midpoint = mid,
                              low = 'blue',
                              mid = 'white',
                              high= 'red')

#custom divergin gradient n colors
p_grad +scale_color_gradient(colors = c("blue",
                                        "green",
                                        "yellow",
                                        "purple",
                                        "orange"))

#-------------- oalette tour ---------------
library(wesanderson)
print(wes_palettes)
demoplot(wes_palettes$BottleRocket1, "pie")
demoplot(wes_palettes[[2]][1:3], 'spine')

my_colrs <- wes_palettes$GrandBudapest2[1:4]
p_fil +geom_boxplot() + scale_fill_manual(values = my_cols)

library(RColorBrewer)
display.brewer.all()
display.brewer.all(colorblindFriendly = TRUE)

demoplot(brewer.pal(4, "Accent"), "bar")
demoplot(brewer.pal(11, "Spectral"), "heatmap")
my_cols <- c("gray75", brewer.pal(3, "Blues"))
print(my_cols)

p_fil + geom_boxplot() + scale_fill_manual(values = my_cols)

# nice tool for seeing hex values
library(scales)
show_col(my_cols)

# virids palettes

#making a heat map
x_var <- 1:30 
y_var <- 1:5
my_data <- expand.grid(x_var=x_var,y_var= y_var)
head(my_data)

z_var <- my_data$x_var + my_data$y_var + 2 * rnorm(n = 150) 

my_data <-cbind(my_data, z_var)

# default gradient colors in r
p4 <- ggplot(my_data, aes( x =x_var, 
                           y = y_var, 
                           fill = z_var)) +
  geom_tile()
print(p4)


#user dfined divergent palette
p4 + scale_fill_gradient2(midpoint = 19,
                          low = "brown",
                          mid = gray(0.8),
                          high = "darkblue")

# use virids continous scale
p4 + scale_fill_viridis_c()

# options virdis, cividis, magma, inferno, plasma

p4 + scale_fill_viridis_c(option="cividis")
p4 + scale_fill_viridis_c(option="magma")
p4 + scale_fill_viridis_c(option="inferno")
p4 + scale_fill_viridis_c(option="plasma")

#desaturation
p4 <- p4 + scale_fill_viridis_c()
p4_des <- edit_colors(p4, desaturate)
plot(p4_des)
