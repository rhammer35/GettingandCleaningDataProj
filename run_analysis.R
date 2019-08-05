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