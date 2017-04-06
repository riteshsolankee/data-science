setwd("R/machineLearning/data/")
x <- read.csv("datafile.csv", header = TRUE, sep = ",")
head(x)
#attach(x)

#two predictor model
two_pred_mod <- lm(
  x$Total...Irrigation.potential.created ~
    x$Irrigation.potential.created...Rabi +
    x$Irrigation.potential.created...Perennial,
  data = x
)
two_pred_mod
fitted(two_pred_mod)
summary(two_pred_mod)
#Three predictor model
three_pred_mod <- lm(
  x$Total...Irrigation.potential.created ~
    x$Irrigation.potential.created...Rabi +
    x$Irrigation.potential.created...Perennial + 
    x$Irrigation.potential.created...Kharif,
  data = x
)

three_pred_mod
fitted(three_pred_mod)
summary(three_pred_mod)



##########
mlr <- read.csv(mlr06.csv)
