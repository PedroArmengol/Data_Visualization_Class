rm(list=ls())
#Script to create the firearms smuggling platform

library("extrafont")
library("ggthemes")
library("readr")
library("haven")
library("dplyr")
library("tidyr")
library("stringr")
library("ggplot2")
library("plyr")
library("ggrepel")
library("grid")
library("gridExtra")
library("gdata") 
library("readxl")
library("scales")
library("gtable")

#Data sources
#ATF : Licenses for type and merchant: https://www.atf.gov/firearms/listing-federal-firearms-licensees-ffls-2016
# xls files
#licenses_dec <- read_excel("/Users/pedro/Documents/DataVis/ATF/2016/dec.xlsx"
#Killings by firearms in Mexico:http://secretariadoejecutivo.gob.mx/incidencia-delictiva/incidencia-delictiva-fuero-comun.php

#Graph 1
#Firearms munifactured
firearms <- read_excel("/Users/pedro/Documents/DataVis/ATF/atf_production.xlsx") 
firearms_long <- gather(firearms,ao, Total,"1986.0":"2015.0", factor_key=TRUE) 
names(firearms_long)[names(firearms_long) == 'Year'] <- 'type' 
names(firearms_long)[names(firearms_long) == 'ao'] <- 'year'
firearms_long$year <- as.numeric(firearms_long$year) + 1985
firearms_long$Total <- firearms_long$Total/1000000
fill = economist_pal()(6)

g1 <- ggplot(subset(firearms_long, type != "Total"), aes(x = year, y = Total, fill=type))
g1 <- g1 + geom_bar(stat = "identity", position = "stack")
g1 <- g1 + labs(x="", 
                y="",
                title="Ain't it fun",
                subtitle="Firearms production in the US *millions",
                caption = "Source: ATF data: U.S Firearms Commerce Report")
g1 <- g1 + theme_economist()
g1 <- g1 + theme(plot.title=element_text(size=17, hjust=0.0, face="bold", colour="black", vjust=-1))
g1 <- g1 + theme(plot.subtitle=element_text(size=13, hjust=0.0, face="italic", color="maroon"))
g1 <- g1 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black"))
g1 <- g1 + theme(axis.title.y = element_text(size=7, hjust=0.5,angle=90,face="bold")) 
g1 <- g1 + theme(axis.title.x = element_text(size=7, hjust=1.0,angle=180,face="bold"))
g1 <- g1 + theme(legend.position="bottom", legend.direction="horizontal", legend.title = element_blank())
g1 <- g1 + scale_x_continuous(breaks = seq(1986,2015,4))
g1 <- g1 + guides(color=guide_legend(""))
g1 <- g1 + scale_colour_economist()
#g1 <- g1 + theme(plot.title=element_text(family="ITCOfficinaSans LT Book"))
#g1 <- g1 + theme(text=element_text(family="OfficinaSanITC-Book"))
g1 <- g1 + scale_fill_manual("", values = fill)
g1

#Graph 2
#Speaking about trade deficits
firearms <- read_csv("/Users/pedro/Documents/DataVis/ATF/atf_columns.csv") 
firearms$export <- firearms$export/1000000
firearms$imports <- firearms$imports/1000000
fill = economist_pal()(2)


g2 <- ggplot(firearms, aes(year)) 
g2 <- g2 + geom_line(aes(y = imports, colour = "Imports"), size = 1)
g2 <- g2 + geom_line(aes(y = export, colour = "Exports"), size = 1)
g2 <- g2 + labs(x="", 
                 y="",
                 title="Speaking about trade deficit",
                 subtitle="Firearms imports/exports in the US *millions",
                 caption = "Source: ATF data: U.S Firearms Commerce Report")
g2 <- g2 + theme_economist()
g2 <- g2 + theme(plot.title=element_text(size=17, hjust=0.0, face="bold", colour="black", vjust=-1))
g2 <- g2 + theme(plot.subtitle=element_text(size=13, hjust=0.0, face="italic", color="maroon"))
g2 <- g2 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black"))
g2 <- g2 + theme(axis.title.y = element_text(size=7, hjust=0.5,angle=90,face="bold")) 
g2 <- g2 + theme(axis.title.x = element_text(size=7, hjust=1.0,angle=180,face="bold")) 
g2 <- g2 + scale_x_continuous(breaks = seq(1986,2015,4))
g2 <- g2 + scale_colour_manual("", 
                    breaks = c("Imports", "Exports"),
                    values = fill)
g2 <- g2 + guides(color=guide_legend(""))
g2

#Graph 3
#Consolidation
firearms <- read_csv("/Users/pedro/Documents/DataVis/ATF/atf_columns.csv") 
firearms$licenses <- round(firearms$licenses/1000, digits = 1)
fill = economist_pal()(1)

g3 <- ggplot(firearms,aes(y = licenses, x = year))
g3 <- g3 + geom_area(fill = fill,stat="identity", alpha =0.7)
g3 <- g3 + labs(x="", 
                 y="",
                 title="Consolidate and conquer",
                 subtitle="Number of licenses for firearms production*  '000",
                 caption = "Source: ATF data                *Production, imports and exports")
g3 <- g3 + theme_economist()
g3 <- g3 + theme(plot.title=element_text(size=17, hjust=0.0, face="bold", colour="black", vjust=-1))
g3 <- g3 + theme(plot.subtitle=element_text(size=13, hjust=0.0, face="italic", color="maroon"))
g3 <- g3 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black"))
g3 <- g3 + theme(axis.title.y = element_text(size=7, hjust=0.5,angle=90,face="bold")) 
g3 <- g3 + theme(axis.title.x = element_text(size=7, hjust=1.0,angle=180,face="bold")) 
g3 <- g3 + scale_x_continuous(breaks = seq(1986,2015,4))
g3 <- g3 + guides(color=guide_legend(""))
g3

#Graph 4
#Thight Legislation

#Graph 5 
#Spreading the blood






