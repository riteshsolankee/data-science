## Load Test data ## 
library(ggplot2)
setwd("/Users/ritesh/pad-datascience/R/")
housing <- read.csv("dataVisualization/data/landdata-states.csv")
head(housing[1:5])
### 

#########################################
## data

## aesthetic mapping ##
# In ggplot land aesthetic means "something you can see"
# position (i.e., on the x and y axes)
# color ("outside" color)
# fill ("inside" color)
# shape (of points)
# linetype
# size
# Aesthetic mappings are set with the aes() function

## geometric object (geom) ## 
# Geometric objects are the actual marks we put on a plot
# points (geom_point, for scatter plots, dot plots, etc)
# lines (geom_line, for time series, trend lines, etc)
# boxplot (geom_boxplot, for, well, boxplots!)
# smother (geom_smooth())
# Text (Label Points) - geom_text
# A plot must have at least one geom; there is no upper limit. You can add a geom to a plot using the + operator
# List of  geometric Object 'help.search("geom_", package = "ggplot2")'

## statistical transformations ## 

## scales ##
# Aesthetic mapping (i.e., with aes()) only says that a variable should be mapped to an aesthetic. 
# It doesn't say how that should happen. For example, when mapping a variable to shape with 
# aes(shape = x) you don't say what shapes should be used. Similarly, aes(color = z) doesn't 
# say what colors should be used. Describing what colors/shapes/sizes etc. to use is done by 
# modifying the corresponding scale. In ggplot2 scales include
# position
# color and fill
# size
# shape
# line type
# Scales are modified with a series of functions using a scale_<aesthetic>_<type> naming scheme
p3 <- ggplot(housing,
             aes(x = State,
                 y = Home.Price.Index)) + 
  theme(legend.position="top",
        axis.text=element_text(size = 6))
(p4 <- p3 + geom_point(aes(color = Date),
                       alpha = 0.5,
                       size = 1.5,
                       position = position_jitter(width = 0.25, height = 0)))


p4 + scale_x_discrete(name="State Abbreviation") +
  scale_color_continuous(name="",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76", "'94", "'13"))
#coordinate system
#position adjustments

## faceting ##
# Faceting is ggplot2 parlance for small multiples
# The idea is to create separate graphs for subsets of data
# ggplot2 offers two functions for creating small multiples:
# 1. facet_wrap(): define subsets as the levels of a single grouping variable
# 2. facet_grid(): define subsets as the crossing of two grouping variables
# Facilitates comparison among plots, not just of geoms within a plot
p5 <- ggplot(housing, aes(x = Date, y = Home.Value))
p5 + geom_line(aes(color = State))
(p5 <- p5 + geom_line(aes(color = State)) + facet_wrap(~State, ncol = 10))
(p5 <- p5 + geom_line(aes(color = State)) + facet_grid(.~State))

## Themes ##
# The ggplot2 theme system handles non-data plot elements such as
# Axis labels
# Plot background
# Facet label backround
# Legend appearance
# Built-in themes include:

# theme_gray() (default)
# theme_bw()
# theme_classc()

p5 + theme_linedraw()
p5 + theme_light()
p5 + theme_minimal() +
  theme(text = element_text(color = "turquoise"))

#########################################