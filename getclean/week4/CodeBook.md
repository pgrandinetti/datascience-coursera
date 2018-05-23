## Getting and Cleaning Data - Course Project CodeBook

This file is shipped as part of the final assignment for the John Hopkins University class _Getting and Cleaning Data_ (offered via Coursera).

Usage of the code in this repository is subject to the Coursera Honor Code.

## Data Description

The data set contains tidy data extracted from the original data set (available [here][http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#]). More precisely, the original data has been first sliced by extracting only measures about standard deviation `std` and average `mean` operation, and then augmented by adding the *subject* column (integer from 1 to 30, as thirty persons executed the experiments), and the *activity* column (a descriptive name of the activity executed by the subject for that experiment, among WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING).

Furthermore, the data set resulting from the above process has been grouped by pair `(subject, activity`) (that is, 180 pairs since there were 30 subjects and 6 activities), and for each group the mean of each column was computed.

Therefore, the final tidy data set contains 180 rows (one for every group) and 86 columns (84 from the original data set, plus 2 columns for subject and activity name).


# Variables description

Notice that `feat-XYZ` means three actual features `feat-X`, `feat-Y`, `feat-Y`, one for each axis in the space.

Also, about units measure, the sensors provide gravitational and body motion components: the body acceleration signal obtained by subtracting the gravity from the total acceleration and is measured in standard gravit units _g_, while the angular velocities vector measured by the gyroscope are measured in radians/second. Furthermore, the data are normalized in the interval \[-1, 1\].

  - COLUMN 1 `activity`: the descriptive name of the activity, one of the following WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING
  - COLUMN 2 `subject`: the identifier of the subject who executed the test, integer from 1 to 30.
  - COLUMN 3-5 `tBodyAcc-mean()-XYZ`: the acceleration signal was separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. This is the mean signal of "body" part in the original data set, averaged for each group.
  - COLUMN 6-8 `tBodyAcc-std()-XYZ`: the acceleration signal was separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. This is the standard deviation signal of "body" part in the original data set, averaged for each group.
  - COLUMN 9-11`tGravityAcc-mean()-XYZ`: the acceleration signal was separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. This is the mean signal of "gravity" part in the original data set, averaged for each group.
  - COLUMN 12-14 `tGravityAcc-std()-XYZ`: the acceleration signal was separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. This is the standard deviation signal of "gravity" part in the original data set, averaged for each group.
  - COLUMN 15-17 `tBodyAccJerk-mean()-XYZ`: The mean signal of the the Jerk signal computed on the body linear acceleration from the original data set, then averaged for each group.
  - COLUMN 18-20 `tBodyAccJerk-std()-XYZ`: The standard deviation signal of the the Jerk signal computed on the body linear acceleration from the original data set, then averaged for each group.
  - COLUMN 27-29 `tBodyGyroJerk-mean()-XYZ`: The mean signal of the the Jerk signal computed on the angular velocity from the original data set, then averaged for each group.
  - COLUMN 30-32 `tBodyGyroJerk-std()-XYZ`: The standard deviation signal of the the Jerk signal computed on the angular velocity from the original data set, then averaged for each group.
  - COLUMN 21-23 `tBodyGyro-mean()-XYZ`: The mean signal of the angular velocity in the original data set, then averaged for each group.
  - COLUMN 24-26 `tBodyGyro-std()-XYZ`: The standard deviation signal of the angular velocity in the original data set, then averaged for each group.
  - COLUMN 33 `tBodyAccMag-mean()`: Mean signal for the magnitude of `tBodyAcc` (computed using Euclidean norm), then averaged for each group.
  - COLUMN 34 `tBodyAccMag-std()`: Standard deviation signal for the magnitude of `tBodyAcc` (computed using Euclidean norm), then averaged for each group
  - COLUMN 35 `tGravityAccMag-mean()`: Mean signal for the magnitude of `tGravityAcc` (computed using Euclidean norm), then averaged for each group.
  - COLUMN 36 `tGravityAccMag-std()`: Standard deviation signal for the magnitude of `tGravityAcc` (computed using Euclidean norm), then averaged for each group.
  - COLUMN 37 `tBodyAccJerkMag-mean()`: Mean signal for the magnitude of `tBodyAccJerk`, then averaged for each group.
  - COLUMN 38 `tBodyAccJerkMag-std()`: Standard deviation signal for the magnitude of `tBodyAccJerk`, then averaged for each group.
  - COLUMN 39 `tBodyGyroMag-mean()`: Mean signal for the magnitude of `tBodyGyro`, then averaged for each group.
  - COLUMN 40 `tBodyGyroMag-std()`: Standard deviation signal for the magnitude of `tBodyGyro`, then averaged for each group.
  - COLUMN 41 `tBodyGyroJerkMag-mean()`: Mean signal for the magnitude of `tBodyGyroJerk`, then averaged for each group.
  - COLUMN 42 `tBodyGyroJerkMag-std()`: Standard deviation signal for the magnitude of `tBodyGyroJerk`, then averaged for each group.
  - COLUMN 43-45 `fBodyAcc-mean()-XYZ`: Mean signal for the frequency-domain value of `tBodyAcc`, then averaged for each group.
  - COLUMN 46-48 `fBodyAcc-std()-XYZ`: Standard deviation signal for the frequency-domain value of `tBodyAcc`, then averaged for each group.
  - COLUMN 49-51 `fBodyAcc-meanFreq()-XYZ`: Weighted average of the frequency components of `tBodyAcc`,  then averaged for each group.
  - COLUMN 52-54 `fBodyAccJerk-mean()-XYZ`: Mean signal for the frequency-domain value of `tBodyAccJerk`, then averaged for each group.
  - COLUMN 55-57 `fBodyAccJerk-std()-XYZ`: Standard deviation signal for the frequency-domain value of `tBodyAccJerk`, then averaged for each group.
  - COLUMN 58-60 `fBodyAccJerk-meanFreq()-XYZ`: Weighted average of the frequency components of `tBodyAccJerk`,  then averaged for each group.
  - COLUMN 61-63 `fBodyGyro-mean()-XYZ`: Mean signal for the frequency-domain value of `tBodyGyro`, then averaged for each group.
  - COLUMN 64-66 `fBodyGyro-std()-XYZ`: Standard deviation signal for the frequency-domain value of `tBodyGyro`, then averaged for each group.
  - COLUMN 67-69 `fBodyGyro-meanFreq()-XYZ`: Weighted average of the frequency components of `tBodyGyro`,  then averaged for each group.
  - COLUMN 70 `fBodyAccMag-mean()`: Mean signal for the magnitude of `tBodyAcc`, then averaged for each group.
  - COLUMN 71 `fBodyAccMag-std()`: Standard deviation signal for the magnitude of `tBodyAcc`, then averaged for each group.
  - COLUMN 72 `fBodyAccMag-meanFreq()`: Weighted average of the frequency components of `tBodyAccMag`,  then averaged for each group.
  - COLUMN 73 `fBodyAccJerkMag-mean()`: Mean signal for the magnitude of the frequency-domain value of `tBodyAccJerk`, then averaged for each group.
  - COLUMN 74 `fBodyAccJerkMag-std()`: Standard deviation signal for the magnitude of the frequency-domain value of `tBodyAccJerk`, then averaged for each group.
  - COLUMN 75: `fBodyAccJerkMag-meanFreq()`: Weighted average for the magnitude of the frequency components of `tBodyAccJerk`,  then averaged for each group.
  - COLUMN 76 `fBodyGyroMag-mean()`: Mean signal for the magnitude of `tBodyGyro`, then averaged for each group.
  - COLUMN 77 `fBodyGyroMag-std()`: Standard deviation signal for the magnitude of `tBodyGyro`, then averaged for each group.
  - COLUM 78 `fBodyGyroMag-meanFreq()`: Weighted average of the frequency components of `tBodyGyroMag`,  then averaged for each group.
  - COLUMN 79 `fBodyGyroJerkMag-mean()`: Mean signal for the magnitude of `tBodyGyroJerk`, then averaged for each group.
  - COLUMN 80 `fBodyGyroJerkMag-std()`: Standard deviation signal for the magnitude of `tBodyGyroJerk`, then averaged for each group.
  - COLUMN 81 `fBodyGyroJerkMag-meanFreq()`:  Weighted average of the frequency components of `tBodyGyroJerkMag`,  then averaged for each group.
  - COLUMN 82 `angle(tBodyAccMean,gravity)`: Obtained by averaging the signal `angle(tBodyAccMean,gravity)` in a signal window sample,  then averaged for each group.
  - COLUMN 83 `angle(tBodyAccJerkMean,gravityMean)`: Obtained by averaging the signal `angle(tBodyAccJerkMean,gravityMean)` in a signal window sample,  then averaged for each group.
  - COLUMN 84 `angle(tBodyGyroMean,gravityMean)`: Obtained by averaging the signal `angle(tBodyGyroMean,gravityMean)` in a signal window sample,  then averaged for each group.
  - COLUMN 85 `angle(tBodyGyroJerkMean,gravityMean)`: Obtained by averaging the signal `angle(tBodyGyroJerkMean,gravityMean)` in a signal window sample,  then averaged for each group.
  - COLUMN 86-88 `angle(-XYZ,gravityMean)`: Obtained by averaging the signal `angle(-XYZ,gravityMean)` in a signal window sample,  then averaged for each group.
