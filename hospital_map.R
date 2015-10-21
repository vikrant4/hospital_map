library(ggmap)
library(ggplot2)
if(!file.exists("datafile.csv")){
  file.create("datafile.csv")
  download.file("https://data.gov.in/node/356921/datastore/export/csv", "datafile.csv")
}
hospitals <- read.csv("datafile.csv")
colnames(hospitals)[22] <- "lat"
colnames(hospitals)[23] <- "lon"

hospitals$Hospital.Category <- tolower(hospitals$Hospital.Category)
hospitals$lon <- gsub("'", "", hospitals$lon)
hospitals$lon <- gsub("Â",".", hospitals$lon)

hospitals$lat <- gsub("'", "", hospitals$lat)
hospitals$lat <- gsub("Â",".", hospitals$lat)

hospitals$lat <- as.numeric(hospitals$lat)
hospitals$lon <- as.numeric(hospitals$lon)
map <- get_map("India", zoom = 5, source = "google", maptype = "terrain", color = "bw")
hospital_map <- ggmap(map, extent = "device",legend = "topleft")
hospital_map <- p + geom_point(aes(x = lon, y = lat, size = 4, alpha = 0.6, color = Hospital.Category),
               pch = 19, data = hospitals) + guides(alpha = FALSE, size = FALSE)
png("hospital_map.png", width = 720, height = 720)
print(hospital_map)
dev.off()