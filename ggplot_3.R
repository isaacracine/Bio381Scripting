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
# bar plots
 table(d$drv)

p1 <- ggplot(d, aes(x = drv)) +
  geom_bar(color="black",
           fill = "cornsilk")
print(p1)

# aesthetic mapping for multiple groups in each bar

p1 <- ggplot(d, aes(x = drv, fill = fl)) +
  geom_bar()
print(p1)

#stacking with color transparency, adjust alpha which is color
#transparenct of each bar
#alpha = 0 all colors invisible
#alpha = 1 all colors completely opaque
p1 <- ggplot(d, aes(x = drv, fill = fl)) +
  geom_bar(alpha = 0.3, position = "identity")
print(p1)

# better to use position = fill for stacking
# w. constant height
p1 <- ggplot(d, aes(x = drv, fill = fl)) +
  geom_bar(position = "fill")
print(p1)

# best to use position = dodge, generates multiple bars
p1 <- ggplot(d, aes(x = drv, fill = fl)) +
  geom_bar(position = "dodge", color = "black",
  size = 0.8)
print(p1)


# more typical bar plot has heights as values such as mean or total
d_tiny <- tapply(X=d$hwy, INDEX = as.factor(d$fl),
                 FUN = mean)
#takes vector, splits it to pieces according to index and then
# to each of those sectors it calls function (mean)

d_tiny <- data.frame(hwy = d_tiny)
d_tiny <- cbind(fl = row.names(d_tiny), d_tiny)

p2 <- ggplot(d_tiny, aes(x = fl, y = hwy, fill = fl)) +
  geom_col()
print(p2)

#much better for a box plot
p2 <- ggplot(d, aes(x = fl, y = hwy, fill = fl)) +
  geom_boxplot()
print(p2)

#overlay the raw data is small
p2 <- ggplot(d, aes(x = fl, y = hwy, fill = fl)) +
  geom_boxplot(fill = "thistle", outlier.shape = NA) +
  geom_point()
print(p2)

#improve visualization of data 
p2 <- ggplot(d, aes(x = fl, y = hwy, fill = fl)) +
  geom_boxplot(fill = "thistle", outlier.shape = NA) +
  geom_point(position = position_jitter(width = 0.1,
                                        height = 0.7),
             color = "gray60")
print(p2)


#-------------- Colors ---------------

# hue - wavelength of visible light
# saturation - intensity 
# lighteness - black to white
# red, blue, green
# name colors in R


# Aesthetics
# attractive colors
# - large geoms (bars, boxplots), light, pale colors
# - small geoms (points, line), dark vibrant colors
# color palettes that are visible to color blind
# color palettes that convert well to black and white

# Information 
# use colors to group similar treatments
# neutral colors (black, gray, white) for control
# symoblic colors (heat = red, cool = blue, photosynthesis/growth = green, oligotrophic = blue, infected = red)
# dyes or stains, or even colors of organisms

# discreete scales - distinct groups

# continous scales (as in a het map)
# monochromatic (different shades of one color)
# 2 tone chromatic scale (fomr color x to coly y)
# 3 tone divergent scale (from color x through color y to color z)
# consisntent color scheme for manuscript
# use consistent colors within and between you figures

my_cols <- c('#ca0020', '#f4a582', '#92c5de', '#30517b0')

#viewing  colors
demoplot(my_cols, "map")
demoplot(my_cols, "bar")
demoplot(my_cols, "scatter")
demoplot(my_cols, "spine")
demoplot(my_cols, "heatmap")
demoplot(my_cols, "perspective")

my_r_colors <- c("red", "brown", "cyan", "green")
demoplot(my_r_colors, "pie") # ugly

