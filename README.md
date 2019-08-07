Getting and Cleaning Data Course Project README
-----------------------------------------------

This document will serve as an explanation of how the script in my
"run\_analysis.R" file works for the course project in the Coursera
"Getting and Cleaning Data" course. Students were required to create a
cleaner, tidier data set using accelorometer data collected from a
Samsung smartphone. The purpose of collecting the data was create
advanced algorithms for use in wearable computing devices such as a
Fitbit. Let's jump right in to the code.

### Part 1: Reading in the various data files and merging test and train data

Before beginning to address any specific parts of the assignment I
loaded the tidyverse package with functions that would assist me in
tidying the data as required by the project description.

    suppressPackageStartupMessages(suppressWarnings(library(tidyverse)))

The first part of the assignment required merging accelerometer datasets
for the train subjects and the test subjects. To accomplish this I
downloaded the data file using the url given on the assignment page and
unzipped the data files.

    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl, destfile = "trackingdataset.zip")
    unzip("trackingdataset.zip")

I then read the data files into R using the "read.table" command. The
files were located in a folder labeled "UCI HAR Dataset" in my working
directory after being unzipped.

    test_subject_data <- read.table("UCI HAR Dataset/test/X_test.txt")
    test_subject_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
    test_subject_id <- read.table("UCI HAR Dataset/test/subject_test.txt")
    train_subject_data <- read.table("UCI HAR Dataset/train/X_train.txt")
    train_subject_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
    train_subject_id <- read.table("UCI HAR Dataset/train/subject_train.txt")
    features <- read.table("UCI HAR Dataset/features.txt")
    activities <- read.table("UCI HAR Dataset/activity_labels.txt")

From there I wanted to add variables for the subject id and the name of
the activity being measured into the subject data tables. I merged the
subject data tables with the pertinent columns from the subject id and
and subject label data frames using the "mutate" function in the
dplyr/tidyverse package in R.

    test_subject_data <- mutate(test_subject_data, subjectid = test_subject_id[, 1])
    test_subject_data <- mutate(test_subject_data, activitynum = test_subject_labels[, 1])
    train_subject_data <- mutate(train_subject_data, subjectid = train_subject_id[, 1])
    train_subject_data <- mutate(train_subject_data, activitynum = train_subject_labels[, 1])

Finally, I used the "bind\_rows" function to combine the test subject
data and train subject data, thus completing part 1.

    merged_data <- bind_rows(test_subject_data, train_subject_data)

### Part 2: Extracting only the measurements on the mean and standard deviation for each measurement

The second requirement of the project was to subset the newly merged
data to only include those measurements that were the mean and standard
deviation of the various accelerometer measurements. The data frame
created by reading the "features.txt" file provided names for all of the
measurements. I converted the column in that data frame with those names
to character class.

    features$V2 <- as.character(features$V2)

This allowed me to use the "grep" function to search for the strings
"mean" and "std" in the measurement names and concatenate the results
into a single vector. This vector, which I named "meanstd\_cols"
contained numeric values of each column in the merged dataset that
measured mean or standard deviation of the accelerometer measurements.

    meanstd_cols <- c(grep("mean", features$V2), grep("std", features$V2))

Finally, I subsetted the merged data on those column numbers and called
the newer, smaller data set "merged\_data\_subset" which I stored in R.
I placed the "subjectid" and "activitynum" columns at the front of this
data frame.

    merged_data_subset <- merged_data[, c(562, 563, meanstd_cols)]

### Part 3: Give the activities measured in the data set descriptive names

At that point my data only had a variable for the activity number for
each type of the six activities measured. The "activities" data frame
that was read in with the original data contained names for each
activity corresponding to the given set of activity numbers. I created a
factor variable containing the activity names and used "mutate" to add
it to the merged data set. I then rearragned the variables in the data
set to place the new variable with activity names third, right after the
"subjectid and activitynum" variables.

    activityname <- factor(merged_data_subset$activitynum, labels = activities$V2)
    merged_data_subset <- mutate(merged_data_subset, activityname = activityname)
    merged_data_subset <- merged_data_subset[, c(1:2, 82, 3:81)]

### Part 4: Give appropriate labels to each variable in the data set

By then, the only variables in the merged data set containing
descriptive names were those I'd added, meaning only the first three
columns of an 82 column frame. The rest contained something in the
format "V\_" where the underscore represented an integer between 1 and
562, depending on the measurement in question. The data frame "features"
contained more descriptive names for each measurement, such as
"tBodyAccMean", which indicated a measurement of the body linear
acceleration derived in time. First, I subsetted the labels on only
those columns I had kept containing mean and standard deviation
measurements.

    varnames <- features[meanstd_cols, 2]

I felt the labels would be more descriptive if I converted the "t" on
measurements like the one above to "Time." On the similar frequency
domain measurements I converted the "f" at the beginning of the label to
"Freq." Finally, I removed hyphens, underscores, and parentheses that
were in the labels to improve clarity. To do all of this, I used the
"gsub" function and regular expressions.

    varnames <- gsub("-", "", varnames)
    varnames <- gsub("\\()", "_", varnames)
    varnames <- gsub("^t", "Time", varnames)
    varnames <- gsub("^f", "Freq", varnames)
    varnames <- gsub("_$", "", varnames)

Finally, I changed the column names in my merged data subset using
"colnames"

    colnames(merged_data_subset)[4:82] <- varnames

### Part 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

Now, I needed to create a much smaller tidy data set that only contained
the average for each of the variables I had in my data subset taken
based on the activity and the subject id. That is, there needed to be a
mean calculation for each of the 6 named activities for each of the 30
test subjects that had produced accelerometer data. To do this, I
grouped the data frame containing my subsetted data by the "subjectid"
variable and then the "activityname" variable. It should be noted that I
converted "subjectid" to a factor variable before using the "group\_by"
function to accomplish this. I then used the pipe operator to take the
mean of that grouped data using the "summarize\_all" function in the
same line of code.

    merged_data_subset$subjectid <- factor(merged_data_subset$subjectid)
    tidydata <- group_by(merged_data_subset, subjectid, activityname) %>% 
                summarize_all(mean) %>% as.data.frame

Lastly, I removed the variable containing the activity numbers, because
it felt redundant (and less tidy!) to have next to a variable containing
the more descriptive activity names

    tidydata <- tidydata[, c(1:2, 4:82)]

### Create .txt file for project submission containing final tidy data set

The last part of my script uses "write.table" to create a .txt file with
my tidy data set that will be uploaded to the Coursera assignment
submission portal. This data file will also be in the Github repository
that I link to when submitting my project.

    write.table(tidydata, file = "tidydata.txt", row.names = FALSE)
