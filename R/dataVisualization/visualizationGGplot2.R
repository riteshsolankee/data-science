############# - Introduction To ggplot2 - #############
## 1. ggplot works with dataframes and not individual vectors
## 2. The second noticeable feature is that you can keep enhancing 
##    the plot by adding more layers (and themes) to an existing plot 
##    created using the ggplot() function.

# Data Setup
options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
data("midwest", package = "ggplot2")  # load the data
View(midwest)

## A blank ggplot is drawn. Even though the x and y are specified, there are no points 
## or lines in it. This is because, ggplot doesn’t assume that you meant a scatterplot 
## or a line chart to be drawn.

## aes() function is used to specify the X and Y axes. That’s because, any information 
## that is part of the source dataframe has to be specified inside the aes() function
# Init Ggplot
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'
## make a scatterplot on top of the blank ggplot by adding points using a geom layer 
## called geom_point
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point()

## add a smoothing layer using geom_smooth(method='lm'). Since the method is set as 
## lm (short for linear model), it draws the line of best fit
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")
plot(g)
############# - Adjusting the X and Y axis limits - ###########
###############################################################
## The X and Y axis limits can be controlled in 2 ways.
## Method 1:  By deleting the points outside the range
##            This can be done by xlim() and ylim()
## Delete the points outside the limits. Therefor, when using xlim() and ylim(), the 
## points outside the specified range are deleted and will not be considered while 
## drawing the line of best fit 
g + xlim(c(0, 0.1)) + ylim(c(0, 1000000))  

## Method 2:  Zooming In
##            The other method is to change the X and Y axis limits by zooming in to 
##            the region of interest without deleting the points. This is done using 
##            coord_cartesian().
## Since all points will be  considered, the line of best fit will not change

g1 <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + geom_smooth(method="lm") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))
plot(g1)

############# - How to Change the Title and Axis Labels - ###########
#####################################################################
## plot title and lable can be done in one go using the labs() function with title, 
## x and y arguments. Another option is to use the ggtitle(), xlab() and ylab()

g1 + labs(
  title="Area Vs Population", 
  subtitle="From midwest dataset", 
  y="Population", 
  x="Area", 
  caption="Midwest Demographics")
## or
g1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + 
  xlab("Area") + 
  ylab("Population")

########## - Full plot call - #############
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method="lm") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(
    title="Area Vs Population", 
    subtitle="From midwest dataset", 
    y="Population", x="Area", caption="Midwest Demographics")

############# - How to Change the Color and Size of Points - ###########
########################################################################
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(col="steelblue", size=3) +   # Set static color and size for points
  geom_smooth(method="lm", col="firebrick") +  # change the color of line
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(
    title="Area Vs Population", 
    subtitle="From midwest dataset", 
    y="Population", x="Area", caption="Midwest Demographics")

##  If we want the color to change based on another column in the source 
## dataset (midwest), it must be specified inside the aes() function
## Each point is colored based on the state it belongs because of aes(col=state)
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(
    title="Area Vs Population", 
    subtitle="From midwest dataset", 
    y="Population", x="Area", caption="Midwest Demographics")
plot(gg)
gg + theme(legend.position="None")  # remove legend
gg + scale_colour_brewer(palette = "Set1") # change color palette

############# - How to Change the X Axis Texts and Ticks Location - ###########
###############################################################################
## The breaks should be of the same scale as the X axis variable
## 'scale_x_continuous' or 'scale_y_continuous' for continuous variable
## 'scale_x_date' or 'scale_y_date' for date variable 
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(
    title="Area Vs Population", 
    subtitle="From midwest dataset", 
    y="Population", x="Area", caption="Midwest Demographics") +
  scale_x_continuous(breaks=seq(0, 0.1, 0.01)) + 
  scale_y_continuous(breaks=seq(0, 1000000, 100000))
