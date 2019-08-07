## Load tidyverse package for use in tidying data
library(tidyverse)

## Download source data to working directory
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "trackingdataset.zip")

## Data comes in form of zip file and needs to be expanded
unzip("trackingdataset.zip")

## Read .txt data files into R using read.table function
test_subject_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_subject_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject_id <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_subject_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject_id <- read.table("UCI HAR Dataset/train/subject_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

## Create variables in subject data frames for subject id and activity label
## by merging with other data frames containing that information
test_subject_data <- mutate(test_subject_data, subjectid = test_subject_id[, 1])
test_subject_data <- mutate(test_subject_data, activitynum = test_subject_labels[, 1])
train_subject_data <- mutate(train_subject_data, subjectid = train_subject_id[, 1])
train_subject_data <- mutate(train_subject_data, activitynum = train_subject_labels[, 1])

## Merge test subject data and train subject data into single data frame
## This is the first requirement for the project
merged_data <- bind_rows(test_subject_data, train_subject_data)

## Subset merged data to only measuresments on the standard deviation and the
## mean of each measurement
features$V2 <- as.character(features$V2)
meanstd_cols <- c(grep("mean", features$V2), grep("std", features$V2))
merged_data_subset <- merged_data[, c(562, 563, meanstd_cols)]

## Label the activities with descriptive names
activityname <- factor(merged_data_subset$activitynum, labels = activities$V2)
merged_data_subset <- mutate(merged_data_subset, activityname = activityname)
merged_data_subset <- merged_data_subset[, c(1:2, 82, 3:81)]

## Label the data variables with more descriptive names
varnames <- features[meanstd_cols, 2]
varnames <- gsub("-", "", varnames)
varnames <- gsub("\\()", "_", varnames)
varnames <- gsub("^t", "Time", varnames)
varnames <- gsub("^f", "Freq", varnames)
varnames <- gsub("_$", "", varnames)
colnames(merged_data_subset)[4:82] <- varnames

## Use merged and labeled data to create new data set containing average of
## each variable for each activity and each subject
merged_data_subset$subjectid <- factor(merged_data_subset$subjectid)
tidydata <- group_by(merged_data_subset, subjectid, activityname) %>% 
            summarize_all(mean) %>% as.data.frame
tidydata <- tidydata[, c(1:2, 4:82)]    ## Remove activity number variable

## Create .txt file to upload final tidy data table
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)

