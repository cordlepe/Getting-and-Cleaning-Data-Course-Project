rm(list=ls())
library(dplyr)

## prework

## the following code downloads and unzips the file in  your current working directory
fileName <- "project3DataSet.zip"

    ## download the dataset
if (!file.exists(fileName)){
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(URL, fileName, method = "curl")
}  

    ## unzip the dataset
if (!file.exists("UCI HAR Dataset")) { 
    unzip(fileName) 
}

    ## load activity labels and assign meaningful column names
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[ ,2] <- as.character(activityLabels[ ,2])
names(activityLabels) <- c("ActivityID","ActivityDSC")

    ## load list of features and assign meaningful column names
features <- read.table("UCI HAR Dataset/features.txt")
features[ ,2] <- as.character(features[ ,2])
names(features) <- c("featureCD","featureDSC")

    ## read in test data
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

    ## read in train data
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")


## 1 Merges the training and the test sets to create one data set

testFinal <- cbind(testActivity, testSubjects, testData)
trainFinal <- cbind(trainActivity, trainSubjects, trainData)

    ## combine test and train
activityData <- rbind(testFinal, trainFinal)

    ## assign meaningful column names
names(activityData) <- c("ActivityID", "Subject", features[ ,2])


## 2 Extracts only the measurements on the mean and standard deviation for each measurement

featuresMean <- features[grepl("mean", features$featureDSC), ]
featuresStd <- features[grepl("std", features$featureDSC), ]
featuresFinal <- rbind(featuresMean, featuresStd)

meanStdData <- activityData[ , featuresFinal[ , 2]]
activityData <- cbind(activityData[ , 1:2], meanStdData)


## 3 Uses descriptive activity names to name the activities in the data set

activityData <- merge(activityData, activityLabels, by = "ActivityID")

    ##reorder columns and drop ActivityID
activityData <- select(activityData, Subject, ActivityDSC, everything(), -ActivityID)


## 4 Appropriately labels the data set with descriptive variable names

activityDataColNames <- colnames(activityData)

    ##manipulate column names to be more meaningful
activityDataColNames <- gsub("[//(//)-]", "", activityDataColNames)
activityDataColNames <- gsub("^t", "Time", activityDataColNames)
activityDataColNames <- gsub("^f", "Freq", activityDataColNames)
activityDataColNames <- gsub("mean", "Mean", activityDataColNames)
activityDataColNames <- gsub("std", "StDev", activityDataColNames)
activityDataColNames <- gsub("BodyBody", "Body", activityDataColNames)

names(activityData) <- activityDataColNames


## 5 From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.

subActMeanData <-activityData %>% 
    group_by(Subject, ActivityDSC) %>%
    summarize_all(mean)


## write table to current working directory
write.table(subActMeanData, "tidyData.txt", row.name = FALSE)