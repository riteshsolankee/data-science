# Load MASS package
library(MASS)
library(ggplot2)

## loading Cars93 data set
data(Cars93)
## assign to a variable
tmpCars <- Cars93
## Inspect the data set
str(tmpCars)

## Generate a Histogram using ggplot and geom functions for MPG.city variable
ggplot(tmpCars, aes(MPG.city )) +  geom_histogram(bins = 10)

##Generate a Bar Chart using ggplot and geom functions for Type variable.
ggplot(tmpCars, aes(Type)) +  geom_bar(width = .5, fill="white", colour="darkgreen")
ggplot(tmpCars, aes(Type)) +  geom_bar(width = .5)
ggplot(tmpCars, aes(Type)) +  geom_bar(width = .5) + coord_flip()

# Use qplot
qplot(factor(Type), data=tmpCars, geom="bar", fill=factor(Type))

##Generate a Scatter Diagram using ggplot and geom function for Weight and MPG.city variables.  
ggplot(tmpCars, aes(y=Weight, x=MPG.city)) + geom_point() 
ggplot(tmpCars, aes(x=Weight, y=MPG.city)) + geom_point() + geom_smooth(method=lm)
# Line plot
ggplot(tmpCars, aes(y=Weight, x=MPG.city)) + geom_line() # scatter plo is much better

## Generate a Box-Plot using ggplot and geom function for Cylinders and MPG.city.
ggplot(tmpCars, aes(factor(Cylinders), MPG.city)) + geom_boxplot(outlier.colour = "red", aes( fill = Cylinders))
ggplot(tmpCars, aes(Cylinders, MPG.city)) + geom_boxplot(outlier.colour = "red", aes( fill = Cylinders))

##  Generate a Scatter Plot using ggplot and geom function for Weight, MPG.city and use color to represent Cylinders.  
ggplot(tmpCars, aes(x=Weight, y=MPG.city)) + geom_point(aes(color=Cylinders)) +  facet_grid(. ~DriveTrain)

###### loading 'maps' package #######
library(maps)

us_map = map_data("state")
head(us_map,3)

ggplot(subset(us_map, region %in% c("ohio", "indiana")),
       aes(x = long, y = lat, fill = region)) +
  geom_polygon()
