library(ggmap)
library(ggplot2)
hospitals <- reac.csv("datafile.csv")
colnames(hospitals)[22] <- "lat"
colnames(hospitals)[23] <- "lon"
hospitals$lon <- gsub("'", "", hospitals$lon)
hospitals$lon <- gsub("Â",".", hospitals$lon)

hospitals$lat <- gsub("'", "", hospitals$lat)
hospitals$lat <- gsub("Â",".", hospitals$lat)

hospitals$lat <- as.numeric(hospitals$lat)
hospitals$lon <- as.numeric(hospitals$lon)
p <- qmap("India", zoom = 5, maptype = "toner")
png("hospital_map.png")
p + geom_point(aes(x = lon, y = lat, color = Hospital.Category, size = 4, alpha = 0.6),
               pch = 19, data = hospitals) + guides(alpha = FALSE)
dev.off()