# Getting and Cleaning Data Course Project CodeBook
###### By: Paige Anderson
###### Last updated: 2/22/19

&nbsp;

This CodeBook contains 2 sections:

1. Variables - descriptions of identifier and measure variables
2. Transformations - list of steps taken to create `tidyData.txt` from the source data

## Variables

Note that the first row of `tidyData.txt` contains the variable names, all of which will be described below.

### Identifiers
* `Subject` - identifies subject, integer ranging from 1-30
* `ActivityDSC` - identifies activity performed, string with 6 possible values:
    * `WALKING`
    * `WALKING_UPSTAIRS`
    * `WALKING_DOWNSTAIRS`
    * `SITTING`
    * `STANDING`
    * `LAYING`
    
### Measures
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals TimeAcc-XYZ and TimeGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAcc-XYZ and TimeGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccJerk-XYZ and TimeBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccMag, TimeGravityAccMag, TimeBodyAccJerkMag, TimeBodyGyroMag, TimeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FreqBodyAcc-XYZ, FreqBodyAccJerk-XYZ, FreqBodyGyro-XYZ, FreqBodyAccJerkMag, FreqBodyGyroMag, FreqBodyGyroJerkMag.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

#### Measure List
* `TimeBodyAccMeanX`
* `TimeBodyAccMeanY`
* `TimeBodyAccMeanZ`
* `TimeGravityAccMeanX`
* `TimeGravityAccMeanY`
* `TimeGravityAccMeanZ`
* `TimeBodyAccJerkMeanX`
* `TimeBodyAccJerkMeanY`
* `TimeBodyAccJerkMeanZ`
* `TimeBodyGyroMeanX`
* `TimeBodyGyroMeanY`
* `TimeBodyGyroMeanZ`
* `TimeBodyGyroJerkMeanX`
* `TimeBodyGyroJerkMeanY`
* `TimeBodyGyroJerkMeanZ`
* `TimeBodyAccMagMean`
* `TimeGravityAccMagMean`
* `TimeBodyAccJerkMagMean`
* `TimeBodyGyroMagMean`
* `TimeBodyGyroJerkMagMean`
* `FreqBodyAccMeanX`
* `FreqBodyAccMeanY`
* `FreqBodyAccMeanZ`
* `FreqBodyAccMeanFreqX`
* `FreqBodyAccMeanFreqY`
* `FreqBodyAccMeanFreqZ`
* `FreqBodyAccJerkMeanX`
* `FreqBodyAccJerkMeanY`
* `FreqBodyAccJerkMeanZ`
* `FreqBodyAccJerkMeanFreqX`
* `FreqBodyAccJerkMeanFreqY`
* `FreqBodyAccJerkMeanFreqZ`
* `FreqBodyGyroMeanX`
* `FreqBodyGyroMeanY`
* `FreqBodyGyroMeanZ`
* `FreqBodyGyroMeanFreqX`
* `FreqBodyGyroMeanFreqY`
* `FreqBodyGyroMeanFreqZ`
* `FreqBodyAccMagMean`
* `FreqBodyAccMagMeanFreq`
* `FreqBodyAccJerkMagMean`
* `FreqBodyAccJerkMagMeanFreq`
* `FreqBodyGyroMagMean`
* `FreqBodyGyroMagMeanFreq`
* `FreqBodyGyroJerkMagMean`
* `FreqBodyGyroJerkMagMeanFreq`
* `TimeBodyAccStDevX`
* `TimeBodyAccStDevY`
* `TimeBodyAccStDevZ`
* `TimeGravityAccStDevX`
* `TimeGravityAccStDevY`
* `TimeGravityAccStDevZ`
* `TimeBodyAccJerkStDevX`
* `TimeBodyAccJerkStDevY`
* `TimeBodyAccJerkStDevZ`
* `TimeBodyGyroStDevX`
* `TimeBodyGyroStDevY`
* `TimeBodyGyroStDevZ`
* `TimeBodyGyroJerkStDevX`
* `TimeBodyGyroJerkStDevY`
* `TimeBodyGyroJerkStDevZ`
* `TimeBodyAccMagStDev`
* `TimeGravityAccMagStDev`
* `TimeBodyAccJerkMagStDev`
* `TimeBodyGyroMagStDev`
* `TimeBodyGyroJerkMagStDev`
* `FreqBodyAccStDevX`
* `FreqBodyAccStDevY`
* `FreqBodyAccStDevZ`
* `FreqBodyAccJerkStDevX`
* `FreqBodyAccJerkStDevY`
* `FreqBodyAccJerkStDevZ`
* `FreqBodyGyroStDevX`
* `FreqBodyGyroStDevY`
* `FreqBodyGyroStDevZ`
* `FreqBodyAccMagStDev`
* `FreqBodyAccJerkMagStDev`
* `FreqBodyGyroMagStDev`
* `FreqBodyGyroJerkMagStDev`

To prevent extremely long variable names, the longer words were abbreviated as follows:

* Freq = Frequency
* Acc = Accelerometer
* Gyro = Gyroscope
* Mag = Magnitude
* StDev = Standard Deviation

&nbsp;

## Transformations
The zip file containing the source data is located [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

`run_analysis.R` performs the following transformations on the source data to create `tidyData.txt`:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    * Any measurement containing `mean` or `std` was kept.
    * All other measurements were discarded.
3. Uses descriptive activity names to name the activities in the data set
    * These activity names can be seen in the identifiers section above.
4. Appropriately labels the data set with descriptive variable names (i.e. tBodyAcc-mean()-X was replaced with TimeBodyAccMeanX) using these rules:
    * Special characters `(`, `)`, and `-` were removed
    * Measures starting with `t` or `f` were replaced with `Time` and `Freq` respectively
    * `mean` was capitalized to `Mean`
    * `std` was renamed to `StDev`
    * Typo `BodyBody` was replaced with `Body`
5. From the data set in step 4, the final tidy data set (`tidyData.txt`) with the average of each variable for each activity and each subject was created.
