## Load the "dplyr" package. (It is assumed that the "dplyr" package has already been installed.)
library(dplyr)

## Before proceeding, ensure all folders and data files are contained in the working folder.
## Specifically, the folders "test" and "train" should be in the working folder.

## Read all required files into R.  Use relative file paths as needed.
## Note - "Inertial Signals" folder is ignored, since it contains no mean or std data.
features <- tbl_df(read.table("features.txt", sep = "", header = FALSE, stringsAsFactors = FALSE))
subject_test <- tbl_df(read.table("./test/subject_test.txt", sep = "", header = FALSE, col.names = "Subject"))
X_test <- tbl_df(read.table("./test/X_test.txt", sep = "", header = FALSE, col.names = features[[2]]))
Y_test <- tbl_df(read.table("./test/Y_test.txt", sep = "", header = FALSE, col.names = "Activity"))
subject_train <- tbl_df(read.table("./train/subject_train.txt", sep = "", header = FALSE, col.names = "Subject"))
X_train <- tbl_df(read.table("./train/X_train.txt", sep = "", header = FALSE, col.names = features[[2]]))
Y_train <- tbl_df(read.table("./train/Y_train.txt", sep = "", header = FALSE, col.names = "Activity"))
activity_labels <- tbl_df(read.table("activity_labels.txt", sep ="", header = FALSE))

## Step 1:
## Use cbind and rbind to "merge" all files into one complete data set.
test_all <- tbl_df(cbind(subject_test, Y_test, X_test))
train_all <- tbl_df(cbind(subject_train, Y_train, X_train))
completedata <- tbl_df(rbind(test_all, train_all))

## Step 2:
## Use select and contains to extract subject, activity, and any mean or std measurements,
## as well as any other variables that may contain the string "mean" or "std".
meanstddata_withFreq <- select(completedata, Subject, Activity, contains("mean"), contains("std"))
## Remove any columns with "meanFreq" or "angle" from this dataset, as they are not what the question is asking for.
meanstddata <- select(meanstddata_withFreq, -contains("meanFreq"), -contains("angle"))

## Step 3:
## Convert Activity column from integers to factors, then change the levels to the activity_labels.
fact <- as.factor(meanstddata$Activity)
levels(fact) <- activity_labels[[2]]
meanstddata$Activity <- fact

## Step 4:
## Rename all variables to be more descriptive.
## Due to variables' lengths, I have used camelCase for easier understanding.
## Use gsub() function to more easily edit the variable names (rather than having to rename each one individually).
tablenames <- names(meanstddata)
newnames <- gsub("\\.","",tablenames)
newnames <- gsub("BodyBody","Body",newnames)
newnames <- gsub("mean","Mean",newnames)
newnames <- gsub("std","Std",newnames)
newnames <- gsub("Acc","Acceleration",newnames)
newnames <- gsub("Gyro","Gyroscope",newnames)
newnames <- gsub("Mag","Magnitude",newnames)
newnames <- gsub("tBody","TimeBody",newnames)
newnames <- gsub("tGravity","TimeGravity",newnames)
newnames <- gsub("fBody","FrequencyBody",newnames)
names(meanstddata) <- newnames

## Step 5: Create a new independent tidy data set with the average of each variable for each activity and each subject.
## (Chaining used to simplify code.)
finaltidydata <-
    meanstddata %>%
    group_by(Subject, Activity) %>%
    summarise_each(funs(mean))

## Create a .txt file containg the final tidy data.
write.table(finaltidydata, file = "tidydata.txt", row.name = FALSE)