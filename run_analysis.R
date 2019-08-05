## Downloading source data to working directory
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "trackingdataset.zip")

## Data comes in form of zip file and needs to be expanded
unzip("trackingdataset.zip")
