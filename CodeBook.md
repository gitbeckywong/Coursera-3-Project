CodeBook.md for run_analysis.R
October 2014
Coursera - "3 - Getting and Cleaning Data" Course Project
gitbeckywong

=======
General
=======
This CodeBook has been adapted from "features_info.txt" which was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
(This data was originally from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )
The "Feature Selection - SOURCE Data" section of this document has not been modified from "features_info.text".
See "Feature Selection - OUTPUT Data" for information about the variables and summaries calculated for run_analysis.R.

===============================
Feature Selection - SOURCE Data
===============================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

===============================
Feature Selection - OUTPUT Data
===============================

The only features from the source data used for the output data are Subject, Activity, and any columns containing either "mean()" or "std()".  All other source data was excluded from this analysis.  (See README.Md for further explanation.)

Subject - I.D. of test subject (integer)
Activity - Description of activity the subject was doing when the measurement was taken.  Possible options are:
WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING

The source variables desribed in the section above were modified for clarity, but the general principles behind them still apply.  Due to the variables' lengths, camelCase was used for easier readability.

NOTE - For all of the variables described below, it is the ***AVERAGE*** of the data for each subject and activity that is presented in the final data set.
The signals below were used for the averages of the mean and standard deviation measures of the estimated variables of the feature vector for each pattern:

Time domain:
TimeBodyAcceleration [X, Y, and Z]
TimeGravityAcceleration [X, Y, and Z]
TimeBodyAccelerationJerk [X, Y, and Z]
TimeBodyGyroscope [X, Y, and Z]
TimeBodyGyroscopeJerk [X, Y, and Z]
TimeBodyAccelerationMagnitude
TimeGravityAccelerationMagnitude
TimeBodyAccelerationJerkMagnitude
TimeBodyGyroscopeMagnitude
TimeBodyGyroscopeJerkMagnitude

Frequency domain:
FrequencyBodyAcceleration [X, Y, and Z]
FrequencyBodyAccelerationJerk [X, Y, and Z]
FrequencyBodyGyroscope [X, Y, and Z]
FrequencyBodyAccelerationMagnitude
FrequencyBodyAccelerationJerkMagnitude
FrequencyBodyGyroscopeMagnitude
FrequencyBodyGyroscopeMagnitudeJerk

"[X, Y, and Z]" denotes that for the signal, there are separate variables for each of the three axes.
For each of the above signals, there are separate variables for "Mean" and "Std" (Standard Deviation), to represent those measurements.  Again, note that the dataset created by run_analysis.R is the AVERAGE of the signal measurement mean for each subject and activity, and the AVERAGE of the signal measurement standard deviation for each subject and activity.
