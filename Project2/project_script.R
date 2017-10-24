rm(list=ls())
#Script to create the firearms smuggling platform
devtools::install_github("dkahle/ggmap")

library("stringr")
library("devtools")
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
library("ggmap")

#PDF links for previous homework
#pdf("/Users/pedro/Documents/DataVis/Data_Visualization_Class/Project1/ps2_graphs_fireguns.pdf", onefile = TRUE)

#Data sources
#ATF : Licenses for type and merchant: https://www.atf.gov/firearms/listing-federal-firearms-licensees-ffls-2016
# xls files
#licenses_dec <- read_excel("/Users/pedro/Documents/DataVis/ATF/2016/dec.xlsx"
#Killings by firearms in Mexico:http://secretariadoejecutivo.gob.mx/incidencia-delictiva/incidencia-delictiva-fuero-comun.php
#STF


###################################################################################
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
##g1 <- g1 + theme_economist()
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
##g2 <- g2 + theme_economist()
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
                 caption = "Source: ATF data: U.S Firearms Commerce Report                *Production, imports and exports")
##g3 <- g3 + theme_economist()
g3 <- g3 + theme(plot.title=element_text(size=17, hjust=0.0, face="bold", colour="black", vjust=-1))
g3 <- g3 + theme(plot.subtitle=element_text(size=13, hjust=0.0, face="italic", color="maroon"))
g3 <- g3 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black"))
g3 <- g3 + theme(axis.title.y = element_text(size=7, hjust=0.5,angle=90,face="bold")) 
g3 <- g3 + theme(axis.title.x = element_text(size=7, hjust=1.0,angle=180,face="bold")) 
g3 <- g3 + scale_x_continuous(breaks = seq(1986,2015,4))
g3 <- g3 + guides(color=guide_legend(""))
g3


#Graph 4
#Not a pleasant neighbour anymore
crimes <- read_excel("/Users/pedro/Documents/DataVis/SESNSP/crimen.xls")
crimes <- subset(crimes, ANO != 2017 & MODALIDAD == "HOMICIDIOS" & TIPO == "DOLOSOS" & SUBTIPO == "CON ARMA DE FUEGO")
crimes$Murders <- rowSums(crimes[,7:18])
#Subset by the neighbour states: Baja California, Sonora, Chihuahua, Coahuila, Nuevo Le??n, Tamaulipas
crimes <- subset(crimes, ENTIDAD == "BAJA CALIFORNIA" | ENTIDAD == "SONORA" | ENTIDAD == "CHIHUAHUA" | ENTIDAD == "COAHUILA" | ENTIDAD == "NUEVO LEON" | ENTIDAD == "TAMAULIPAS")
crimes <- crimes[c("ENTIDAD", "ANO", "total")]
g4 <- ggplot(crimes, aes(ANO, ENTIDAD))  
g4 <- g4 + geom_tile(aes(fill = Murders), colour = "white")
g4 <- g4 + scale_fill_gradient(low = "white", high = "orangered3")
g4 <- g4 + geom_vline(xintercept = 2004, size = 1, colour = "steelblue")
g4 <- g4 + geom_text(aes(x=2004, label="Federal Assault Weapons Ban Finishes", y = "NUEVO LEON"), colour="steelblue", angle=90, vjust = 1.2, text=element_text(size=12))
g4 <- g4 + labs(x="Year", 
                y="State",
                title="Not a pleasant neighbour anymore",
                subtitle="Number of yearly firearm murders in the Mexico's neighbour states with the US ",
                caption = "Source: SESNSP (Executive Secretariat of the Public Security Council: Mexico)")
g4 <- g4 + theme(plot.title=element_text(size=15, hjust=0.0, face="bold", colour="black", vjust=-1))
g4 <- g4 + theme(plot.subtitle=element_text(size=10, hjust=0.0, face="italic", color="maroon"))
g4 <- g4 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black")) 
g4 <- g4 + theme(axis.title.y = element_text(size=11, hjust=0.5,angle=90,face="bold")) 
g4 <- g4 + theme(axis.title.x = element_text(size=11, hjust=0.5,angle=0,face="bold")) 
g4

#Graph 5 
#Deadly related?
#Crimes (murders with firearm)
crimes_agg <- crimes  %>%
  dplyr::group_by(ANO) %>%
  dplyr::summarize(total = sum(Murders)) 
#Crimes (murders in general)
crimes1 <- read_excel("/Users/pedro/Documents/DataVis/SESNSP/crimen.xls")
crimes1 <- subset(crimes1, ANO != 2017 & ANO != 2016 & MODALIDAD == "HOMICIDIOS" & TIPO == "DOLOSOS" )
crimes1$Murders <- rowSums(crimes1[,7:18])
crimes_agg1 <- crimes1  %>%
  dplyr::group_by(ANO) %>%
  dplyr::summarize(total = sum(Murders)) 
fill5 = economist_pal()(2)

p1 <- ggplot(subset(crimes_agg,ANO!=2016), aes(ANO)) 
p1 <- p1 + geom_line(aes(y = crimes_agg1$total), size =1,show.legend=FALSE)
p1 <- p1 + labs(x="", 
                y="Murders",
                title="",
                subtitle="",
                caption = "Source: ATF and SESNSP (Executive Secretariat of the Public Security Council: Mexico)")
##p1 <- p1 + theme_economist()
p1 <- p1 + theme(plot.title=element_text(size=17, hjust=0.0, face="bold", colour="black", vjust=-1))
p1 <- p1 + theme(plot.subtitle=element_text(size=13, hjust=0.0, face="italic", color="maroon"))
p1 <- p1 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black"))
p1 <- p1 + theme(axis.title.y = element_text(size=7, hjust=0.5,angle=90,face="bold")) 
p1 <- p1 + theme(axis.title.x = element_text(size=7, hjust=1.0,angle=180,face="bold")) 
p1 <- p1 + scale_x_continuous(breaks = seq(1997,2015,4))

#Guns
firearms_agg = subset(firearms_long, type == "Rifles" & year > 1996)
firearms_agg$Total = firearms_agg$Total*1000

p2 <- ggplot(firearms_agg, aes(year,Total))
p2 <- p2 + geom_line(aes(),color = "#014d64", size =1,show.legend=FALSE)
p2 <- p2 + labs(x="", 
                y="Rifle production '000",
                title="Deadly related?",
                subtitle="Rifles production '000 (US) and Murders (Mexico)",
                caption = "")
#p2 <- p2 + theme_economist()
p2 <- p2 + theme(plot.title=element_text(size=17, hjust=0.0, face="bold", colour="black", vjust=-1))
p2 <- p2 + theme(plot.subtitle=element_text(size=13, hjust=0.0, face="italic", color="maroon"))
p2 <- p2 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black"))
p2 <- p2 + theme(axis.title.y = element_text(size=7, hjust=0.5,angle=90,face="bold")) 
p2 <- p2 + theme(axis.title.x = element_text(size=7, hjust=1.0,angle=180,face="bold")) 
p2 <- p2 + scale_x_continuous(breaks = seq(1997,2015,4))


gp1<- ggplot_gtable(ggplot_build(p1))
gp2<- ggplot_gtable(ggplot_build(p2))
maxWidth = unit.pmax(gp1$widths[2:3], gp2$widths[2:3])
gp1$widths[2:3] <- maxWidth
gp2$widths[2:3] <- maxWidth
grid.arrange(gp2, gp1)

cor(crimes_agg1$total[crimes_agg1$ANO != 2016], firearms_agg$Total,  method = "pearson")

#Graph 6 
#Tight legislation
#Number of recent law modifications per State
legis <- read_excel("/Users/pedro/Documents/DataVis/SFL/sfl_db.xls")
legis <- subset(legis, year != 2017)
legis$total <- rowSums(legis[,3:136])
legis_agg <- legis  %>%
  dplyr::group_by(state) %>%
  dplyr::summarize(total = sum(total)) 
legis_agg$state <- tolower(legis_agg$state)
#Dataframe states
states <- map_data("state")
names(states)[names(states)=="region"] <- "state"
#Analysis of comun observations
unique(states$state)
unique(legis_agg$state)
elem1 <-  unique(states$state)[unique(states$state) %in% unique(legis_agg$state) == FALSE]
#Fix tables
states <- subset(states, state != "district of columbia")
legis_agg <- subset(legis_agg, state != "alaska" | state != "hawaii")
#Merge
legis_map <- merge(legis_agg, states, by = c("state"))
#Map
g6 <- ggplot(data = legis_map)  
g6 <- g6 + geom_polygon(aes(x = long, y = lat, fill = total, group = group))  
g6 <- g6 + coord_fixed(1.3)
g6 <- g6 + labs(x="", 
                y="",
                title="Getting Thighter",
                subtitle="Number of state firearms laws 1991-2016",
                caption = "Source: State Firearm Law Database")
g6 <- g6 + theme(plot.title=element_text(size=15, hjust=0.0, face="bold", colour="black", vjust=-1))
g6 <- g6 + theme(plot.subtitle=element_text(size=10, hjust=0.0, face="italic", color="maroon"))
g6 <- g6 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black")) 
g6 <- g6 + theme(axis.title.y = element_text(size=11, hjust=0.5,angle=90,face="bold")) 
g6 <- g6 + theme(axis.title.x = element_text(size=11, hjust=0.5,angle=0,face="bold"))
g6 <- g6 + theme(
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.text = element_blank()
)
g6 <- g6 + scale_fill_gradient(low = "white", high = "deepskyblue4") ####Fill colors of the map
g6 <- g6 + theme(panel.background = element_rect(fill = 'white', colour = 'white'))
g6 <- g6 + guides(fill=guide_legend(title=""))
g6

#Graph 7
#Correlation between number of licenses and firearms laws for each state
licenses_state <- read_csv("/Users/pedro/Documents/DataVis/ATF/license_state.csv")
names(licenses_state)[names(licenses_state)=="State"] <- "state"
licenses_state$state <- tolower(licenses_state$state)
#merge licenses and laws
legis_licenses <- merge(legis_agg, licenses_state, by = c("state"))
g7 <- ggplot(legis_licenses, aes(FFL_Population,total))
g7 <- g7 + geom_point(colour = "blue", size = 3)
g7 <- g7 + labs(x="Number of Licenses (2016)", 
                y="Number of state firearms laws 1991-2016",
                title="Legislation and firearms",
                subtitle="Number of state firearms laws 1991-2016 and number of licenses (2016) ",
                caption = "Source: State Firearm Law Database and ATF")
g7 <- g7 + theme(plot.title=element_text(size=15, hjust=0.0, face="bold", colour="black", vjust=-1))
g7 <- g7 + theme(plot.subtitle=element_text(size=10, hjust=0.0, face="italic", color="maroon"))
g7 <- g7 + theme(plot.caption=element_text(size=10, hjust=0.0, color="black")) 
g7 <- g7 + theme(axis.title.y = element_text(size=11, hjust=0.5,angle=90,face="bold")) 
g7 <- g7 + theme(axis.title.x = element_text(size=11, hjust=0.5,angle=0,face="bold")) 
g7


