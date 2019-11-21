

setwd("C:/Users/laurentp/Desktop/Intro to Spatial Data shared")

library("choroplethr")
library("choroplethrMaps")
library("acs")
library("WDI")
library("gstat")
library("sp")
library("rgdal")
library("ggplot2")
library("dplyr")
library("maptools")
library("rworldmap")
library("plyr")


# 
# packages<-c("choroplethr", "choroplethrMaps", "RColorBrewer", "acs", "WDI",
#             "gstat", "sp", "rgdal", "ggplot2", "dplyr", "maptools", "rworldmap", "spdep", "latticeExtra", "tigris")
# #install.packages(packages)
# lapply(packages, require, character.only = TRUE)


tracts<-readOGR("tracts/tracts.shp", stringsAsFactors = FALSE)
subway<-readOGR("./subway/subwaylines.shp", stringsAsFactors = FALSE)
grocerystores<-readOGR("./grocery stores/grocerystores.shp", stringsAsFactors = FALSE)
neighborhoods<-readOGR("./neighborhoods/neighborhoods.shp", stringsAsFactors = FALSE)
#plot(tracts)
ggplot(tracts, aes(x = long, y = lat, group = group)) + geom_path()+ 
  theme_minimal()+
  coord_fixed()

tracts$MED_INC_HH<-as.numeric(tracts$MED_INC_HH)   # convert from string to numeric


tracts@data$id=rownames(tracts@data)
tracts_points<-fortify(tracts, region="id")
tracts_df<-join(tracts_points, tracts@data, by="id")

ggplot(tracts_df, aes(long, lat, group=group, fill=MED_INC_HH))+geom_polygon()+
  scale_fill_continuous(low="white", high="blue")+ coord_fixed() + 
  theme(aspect.ratio=0.6) + theme_minimal()+ 
  coord_fixed()


tracts@data$INC_BREAKS<-cut_interval(tracts@data$MED_INC_HH, n = 5, dig.lab=10)

tracts@data$id=rownames(tracts@data)
tracts_points<-fortify(tracts, region="id")
tracts_df<-join(tracts_points, tracts@data, by="id")

ggplot(tracts_df, aes(long, lat, group=group, fill=INC_BREAKS))+geom_polygon()+
  scale_fill_brewer(palette = 'Blues') + coord_fixed() + 
  theme_minimal()+ 
  coord_fixed()



subway_fortify   <- fortify(subway)
subway_df <- data.frame(id=rownames(subway@data), subway@data)
subway_fortify <- join(subway_fortify, subway_df, by="id")

ggplot(subway_fortify, aes(x=long, y=lat, group=group, color=LINE)) + 
  geom_line(lwd=1.5) + theme_minimal() + 
  scale_color_manual(values=c("darkblue", "darkmagenta", "forestgreen", 
                              "chocolate", "red"))+
  coord_fixed()


grocerystore_df<-data.frame(grocerystores)

ggplot()+
  geom_polygon(data=tracts_df, aes(long, lat, group=group), fill=NA, color="grey")+
  geom_point(data=grocerystore_df, 
             aes(x=Longitude, y=Latitude), fill="red", color="red", pch=24)+
  theme_minimal()+ coord_fixed()


ggplot()+
  
  # Income data
  geom_polygon(data=tracts_df, aes(long, lat, group=group, fill=INC_BREAKS))+
  scale_fill_brewer(palette = 'Blues', name="Median Household Income")+
  
  # Subway data
  geom_line(data=subway_fortify, aes(x=long, y=lat, group=group, color=LINE), lwd=1.5) + 
  scale_color_manual(values=c("darkblue", "darkmagenta", "forestgreen", 
                              "chocolate", "red"), 
                     name="Subway Line", 
                     labels=c("Blue", "Commuter Rail", "Green", "Orange", "Red")) +
  
  # Grocery store data
  geom_point(data=grocerystore_df, 
             aes(x=Longitude, y=Latitude, size=2),
             color="yellow", fill="yellow") + 
  scale_size("Grocery Stores", range=c(1, 1.5), 
             labels=c("Grocery Stores"))+
  
  # General plotting properties
  coord_fixed() + theme_minimal()

