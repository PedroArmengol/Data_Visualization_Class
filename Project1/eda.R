# Pedro Armengol 
# This is an exploratory analysis of the DoT FARS data

library("readr")
library("haven")
library("dplyr")
library("tidyr")
library("stringr")
library("ggplot2")

acc2015 <- read.csv("/Users/Usuario/Documents/Chicago/DataVis/Data_Visualization_Class/Project1/accident.csv")
acc2014 <- read_sas("/Users/Usuario/Documents/Chicago/DataVis/Data_Visualization_Class/Project1/accident.sas7bdat")
#See enviroment
ls()
#Check class of the object
class(acc2014)
class(acc2015)

# Impute missing values
acc2014 <- mutate(acc2014, TWAY_ID2 = na_if(TWAY_ID2,""))
table(is.na(acc2014$TWAY_ID2))

dim(acc2014)
dim(acc2015)


elem1 <-  colnames(acc2014)[colnames(acc2014) %in% colnames(acc2015) == FALSE]
elem1
elem2 <- colnames(acc2015)[colnames(acc2015) %in% colnames(acc2014) == FALSE]
elem2


