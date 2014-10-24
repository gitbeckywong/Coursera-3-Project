README.md for run_analysis.R
October 2014
Coursera - "3 - Getting and Cleaning Data" Course Project
gitbeckywong

========================
GENERAL - THE ASSIGNMENT
========================
The Coursera "Getting and Cleaning Data" Course Project description is as follows:

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

===========
THE PRODUCT
===========
"tidydata.txt" is the result file created by run_analysis.R.  To view this file, use the following code:

read.table("tidydata.txt", header = TRUE)

=============
FILE LOCATION
=============
run_analysis.R assumes that the .zip file from the course project assignment description (see above) has already been downloaded and unzipped. It is also assumed that the unzipped Samsung data is in your working directory.  Note that this means the folders "test" and "train" are in the working directory.

================
REQUIRED R PACKAGE
================
The "dplyr" package is used in run_analyis.R.  It is loaded directly in the script via "library(dplyr)", but the script assumes that the user has already installed the required package.

===========
THE PROCESS
===========

To Begin:
---------
Once in the working directory, read all required files into R using read.table().  Use relative paths as necessary.  Important parameters for all files include sep = "" and header = FALSE.

When reading features.txt, stringsAsFactors needs to be set equal to FALSE so that the features will remain as strings, which becomes important later in the script.

When reading subject_test.txt and subject_train.txt, the column names are set to "Subject".

When reading Y_test.txt and Y_train.txt, the column names are set to "Activity".

When reading X_test.txt and X_train.txt, the columns are set to equal the second column of data that was in features.txt; this represents all of the measurement data.

The tbl_df function is applied to all of the above tables for ease of use within R (most notably when printing the data.)

Lastly, the "Inertial Signals" folder is ignored, since it contains no mean or standard deviation data, and therefore would ultimately just get thrown out anyways.

Part 1:
-------
The functions cbind() and rbind() are used to combine all subject, activity, and data files into one 10299 x 563 data frame.

Part 2:
-------
The dplyr functions select() and contains() are used to first extract and combine the subject, activity, and any mean or std measurements, including any other variables that may contain the strings "mean" or "std".  Note that this line of code impacts the order of the columns (all "std" come after all "mean", rather than mixed together as they are in the source data); however, since the data itself is unchanged and associated with the correct variables, this method is considered acceptable.

select() and contains() are then used again in order to remove any columns containing "meanFreq" or "angle".  This step may or may not be necessary, depending on the individual's interpretation of Part 2 in the Course Project Assignment (see above).  For this script, though, I have interpreted that only the variables "mean" and "std" estimated from the signals are intended to be part of the final data set, and that no signals that happen to contain the strings "mean" or std" are to be included.

Part 3:
-------
Convert the Activity column from integers to factors.  Then change the levels of the factors to the activity descriptions that were in the activity_labels.txt file.  Reassigning these to the Activity column results in the column being populated with the activity descriptions instead of the activity integer codes.

Part 4:
-------
All variables are renamed using the gsub() function to be more descriptive, per the assignment directions.  Additionally, problematic symbols such as - and () are removed.  The names() function was used to reassign the variables to the data frame.

Note that camelCase was used rather than lowercase, to make it easier to read the variable descriptions since many of them are quite long.

See CodeBook.md for more detail about the variable names.

Part 5:
-------
A new independent tidy data set is created containing the AVERAGE of each variable for each activity and each subject using the group_by() and summarise_each() functions of the dplyr package.

Note that the variables are NOT changed to reflect that the values in this new data set are AVERAGES.  This is also made clear in CodeBook.md.

This data set is consistent with the recommendations in Hadley Wickham's "Tidy Data" article found at:
http://vita.had.co.nz/papers/tidy-data.pdf .  
Each variable forms a column and each observation forms a row.  I believe in this case a "wide" data set is tidier and easier to use than a "tall" data set, which is why the script and the final resultant file reflect this.

Final Step:
-----------
The final tidy data set is written to a .txt file (tidydata.txt) using write.table(), with row.name = FALSE.