#library packages...
library(lubridate)
library(dplyr)
library(ggplot2)

#create a folder in computer to store the data 
if(!file.exists("data")){ 
  dir.create("data")
}

#downlaod the data
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/machine_learning_repository.zip", method = "curl")

#unzip the data 
dir.create("./data/machine_learning_repository") #we create an empty folder for the files 
out_dir <- "./data/machine_learning_repository" #the directory we want to extract our files to 
unzip("./data/machine_learning_repository.zip", exdir = out_dir) #unzipping and extracting......

#read it into our environment 
ml_repo <- read.table("./data/machine_learning_repository/household_power_consumption.txt", 
                      sep = ";",
                      skip = 1)
ml_repo$V1 <- dmy(ml_repo$V1) #change the date format 
colnames(ml_repo) <- c("date", "time", "global_active_power", "global_reactive_power",
                       "voltage", "global_intensity", "sub_metering_1", "sub_metering_2",
                       "sub_metering_3")

#subset only the data we desire 
ml_repo_1 <- filter(ml_repo, ml_repo$date == "2007-02-01")
ml_repo_2 <- filter(ml_repo, ml_repo$date == "2007-02-02")
rm(ml_repo)
ml_repo <- rbind(ml_repo_1, ml_repo_2)
rm(ml_repo_1)
rm(ml_repo_2)

#are there any missing values? <- NO
sum(is.na(ml_repo)) 

#Our overall goal here is simply to examine how household energy usage varies over 
#a 2-day period in February, 2007. Your task is to reconstruct the following plots below, 
#all of which were constructed using the base plotting system.
#plot 2: 
#some sort of line graph? of global active power over thursday, friday and saturday. 
ml_repo$id <- seq.int(nrow(ml_repo))
summary(ml_repo$id) #provides the min/median/max for axis 
plot2 <- plot(ml_repo$id, ml_repo$global_active_power,
              type = "l",
              pch = ".",
              xlab = " ",
              ylab = "Global Active Power (kilowatts)",
              xaxt = "n"); axis(1, at = c(1, 1440.5, 2880.0), labels = c("Thu", "Fri", "Sat"))

