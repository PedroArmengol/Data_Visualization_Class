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
fips <- rename(fips, c("X...StateName"="StateName"))

##Standarize keys
acc$STATE <- str_pad(acc$STATE, 2, side = c("left"), pad = "0")
acc$COUNTY <- str_pad(acc$COUNTY, 3, side = c("left"), pad = "0")
fips$StateFIPSCode <- str_pad(fips$StateFIPSCode, 2, side = c("left"), pad = "0")
fips$CountyFIPSCode <- str_pad(fips$CountyFIPSCode, 3, side = c("left"), pad = "0")

acc <- rename(acc, c("STATE"="StateFIPSCode", "COUNTY"="CountyFIPSCode"))
#Merge fips and acc
acc <- left_join(acc, fips, by = c("StateFIPSCode", "CountyFIPSCode"))

#Descriptive Statistics 
#Aggregate data
agg <- acc %>%
  dplyr::group_by(YEAR,StateName) %>%
  dplyr::summarize(TOTAL = sum(FATALS))
#Change from long to wide and other stuff
agg_wide <- tidyr::spread(agg,YEAR,TOTAL)
agg_wide <- mutate(agg_wide, per_diff = ((agg_wide$"2015" - agg_wide$"2014")/agg_wide$"2014")*100)
agg_wide <- arrange(agg_wide, desc(per_diff))
agg_wide <- filter(agg_wide, per_diff > 15 & !is.na(StateName))

# In a single shot (Without <-)
#Aggregate data
agg <- acc %>%
  dplyr::group_by(YEAR,StateName) %>%
  dplyr::summarize(TOTAL = sum(FATALS)) %>%
  tidyr::spread(agg,YEAR,TOTAL) %>%
  mutate(per_diff = (("2015" - "2014")/"2014")*100) %>%
  arrange(desc(per_diff)) %>%
  filter(per_diff > 15 & !is.na(StateName))

glimpse(agg_wide)
