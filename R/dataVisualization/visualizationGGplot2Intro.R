
############### - Setup - ###############
#########################################
library(ggplot2)

View(diamonds)
## if only the dataset is known.
ggplot(diamonds) 

## if only X-axis is known. The Y-axis can be specified in respective geoms.
ggplot(diamonds, aes(x=carat))

## if both X and Y axes are fixed for all layers.
ggplot(diamonds, aes(x=carat, y=price))  

## Each category of the 'cut' variable will now have a distinct  color, once a geom is added.
ggplot(diamonds, aes(x=carat, color=cut))  

## The aes argument stands for aesthetics. ggplot2 considers the X and Y axis of the plot to be 
## aesthetics as well, along with color, size, shape, fill etc.
ggplot(diamonds, aes(x=carat), color="steelblue")

############### - The Layers - ###############
##############################################

## The layers in ggplot2 are also called ‘geoms’. Once the base setup is done, you can append 
## the geoms one on top of the other.
## Adding scatterplot geom (layer1) and smoothing geom (layer2).
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() 

## We have added two layers (geoms) to this plot - the geom_point() and geom_smooth(). 
## Since the X axis Y axis and the color were defined in ggplot() setup itself, these 
## two layers inherited those aesthetics. Alternatively, you can specify those aesthetics 
## inside the geom layer
## Alternate : # Same as above but specifying the aesthetics inside the geoms.
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + geom_smooth(aes(x=carat, y=price, color=cut))

## Q. Instead of having multiple smoothing lines for each level of cut, I want to integrate them all under one line
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth()

## Q. Make the shape of the points vary with color feature
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut, shape=color)) + geom_smooth()

############### - The Labels - ###############
##############################################

## add axis lables and plot title.
gg <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() + 
  labs(title="Scatterplot", x="Carat", y="Price") 

############### - The Theme - ################
##############################################
## Manipulating the size, color of the labels is the job of the ‘Theme’
## Adjusting the size of labels can be done using the theme() function by 
## setting the plot.title, axis.text.x and axis.text.y
## They need to be specified inside the element_text(). If you want to remove any of them, set it to element_blank() and 
## it will vanish entirely
## 'scale_shape_discrete'   - for legend is based on a shape attribute based on a factor variable 
## 'scale_shape_continuous' - for legend is based on a shape attribute based on a continious variable
## 'scale_color_discrete'   - for legend is based on a color attribute on a factor variable
## 'scale_color_continuous' - for legend is based on a color attribute on a continuous variable
## 'scale_fill_discrete'    - for legend is based on a fill attribute on a factor variable
## 'scale_fill_continuous'  - for legend is based on a fill attribute on a continuous variable
gg1 <- gg + theme(
                  plot.title=element_text(size=30, face="bold"),
                  axis.text.x = element_text(size = 15),
                  axis.text.y = element_text(size = 15),
                  axis.title.x = element_text(size = 25),
                  axis.title.y = element_text(size = 25)) + 
  scale_color_discrete(name="Cut of diamonds")
print(gg1)

############### - The Facet - ################
##############################################
## 1. facet_wrap(formula) takes in a formula as the argument. The item on the RHS corresponds to the column. 
##    The item on the LHS defines the rows.
gg1 + facet_wrap( ~ cut, ncol=3)
gg1 + facet_wrap(color ~ cut, scales="free")  # row: color, column: 

## 2. For comparison purposes, you can put all the plots in a grid as well using facet_grid(formula)
gg1 + facet_grid(color ~ cut)
