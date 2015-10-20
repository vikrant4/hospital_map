library(ggmap)
library(ggplot2)
if(!file.exists("datafile.csv")){
  file.create("datafile.csv")
  download.file("https://data.gov.in/node/356921/datastore/export/csv", "datafile.csv")
}
hospitals <- read.csv("datafile.csv")
colnames(hospitals)[22] <- "lat"
colnames(hospitals)[23] <- "lon"
hospitals$lon <- gsub("'", "", hospitals$lon)
hospitals$lon <- gsub("Â",".", hospitals$lon)

hospitals$lat <- gsub("'", "", hospitals$lat)
hospitals$lat <- gsub("Â",".", hospitals$lat)

hospitals$lat <- as.numeric(hospitals$lat)
hospitals$lon <- as.numeric(hospitals$lon)
p <- qmap("India", zoom = 5, color = "bw", maptype = "hybrid")
p <- p + geom_point(aes(x = lon, y = lat, color = Hospital.Category, size = 4, alpha = 0.6),
               pch = 19, data = hospitals) + guides(alpha = FALSE, size = FALSE)
png("hospital_map.png", width = 720, height = 720)
print(p)
dev.off()