# Pedro Armengol 
# This is an exploratory analysis of the DoT FARS data

library("readr")
library("haven")
library("dplyr")
library("tidyr")
library("stringr")
library("ggplot2")
library("plyr")

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

#Keep commun columns in both datasets
#ROAD_FNC: this variable is just in the 2014 dataset
elem1 <-  colnames(acc2014)[colnames(acc2014) %in% colnames(acc2015) == FALSE]
elem1
# RUR_URB"  "FUNC_SYS" "RD_OWNER": this three variables are in the 2015 dataset
elem2 <- colnames(acc2015)[colnames(acc2015) %in% colnames(acc2014) == FALSE]
elem2
#Append
acc <-bind_rows(acc2014,acc2015)

count(acc,RUR_URB)
# The 30,056 NA is because the table acc2014 doesn't have information for this variable

#FIPS Dataset
fips <- read.csv("/Users/Usuario/Documents/Chicago/DataVis/Data_Visualization_Class/Project1/fips.csv")
glimpse(fips)

#Merge FARS and FIPS
acc$STATE <- as.character(acc$STATE)
acc$COUNTY <- as.character(acc$COUNTY)
fips$StateFIPSCode <- as.character(fips$StateFIPSCode)
fips$CountyFIPSCode <- as.character(fips$CountyFIPSCode)
##Standarize keys
acc$STATE <- str_pad(acc$STATE, 2, side = c("left"), pad = "0")
acc$COUNTY <- str_pad(acc$COUNTY, 3, side = c("left"), pad = "0")
fips$StateFIPSCode <- str_pad(fips$StateFIPSCode, 2, side = c("left"), pad = "0")
fips$CountyFIPSCode <- str_pad(fips$CountyFIPSCode, 3, side = c("left"), pad = "0")

acc <- rename(acc, c("STATE"="StateFIPSCode", "COUNTY"="CountyFIPSCode"))
#Merge fips and acc
acc <- left_join(acc, fips, by = c("StateFIPSCode", "CountyFIPSCode"))

