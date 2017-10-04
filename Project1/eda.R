# Pedro Armengol 
# This is an exploratory analysis of the DoT FARS data

library("readr")
library("haven")
library("dplyr")
library("tidyr")
library("stringr")
library("ggplot2")

acc2014 <- read.csv("/Users/Usuario/Documents/Chicago/DataVis/Data_Visualization_Class/Project1/accident.csv")
acc2015 <- read_sas("/Users/Usuario/Documents/Chicago/DataVis/Data_Visualization_Class/Project1/accident.sas7bdat")

ls()

class(acc2014)
class(acc2015)

