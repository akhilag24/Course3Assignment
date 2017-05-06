Getting and Cleaning Data Course Assignment

##Goal

Companies like FitBit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The aim of the project is to clean and extract usable data from the above zip file. R script called run_analysis.R that does the following:

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
In this repository, you find:

run_analysis.R : the R-code run on the data set

CleanData.txt : the clean data extracted from the original data using run_analysis.R

CodeBook.md : the CodeBook reference to the variables in CleanData.txt

README.md : the analysis of the code in run_analysis.R


Getting Started

###Basic Assumption The R code in run_analysis.R proceeds under the assumption that the zip file available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip is downloaded and extracted in the R Home Directory.

###Libraries Used

The libraries used in this operation are data.table and dplyr. We prefer data.table as it is efficient in handling large data as tables. dplyr is used to aggregate variables to create the tidy data.

library(data.table)
library(dplyr)

###Read Supporting Metadata

The supporting metadata in this data are the name of the features and the name of the activities. They are loaded into variables featureNames and activityLabels.

FeatureNames <- read.table(file = "features.txt")
ActivityLabels <- read.table(file = "activity_labels.txt",header = FALSE)

##Format training and test data sets

Both training and test data sets are split up into subject, activity and features. They are present in three different files.

###Read training data

train_subject <- read.table(file = "train/subject_train.txt",header = FALSE)
train_activity <- read.table(file = "train/y_train.txt",header = FALSE)
train_features <- read.table(file = "train/X_train.txt",header = FALSE)

###Read test data

test_subject <- read.table(file = "test/subject_test.txt",header = FALSE)
test_activity <- read.table(file = "test/y_test.txt",header = FALSE)
test_features <- read.table(file = "test/X_test.txt",header = FALSE)

##Part 1 - Merge the training and the test sets to create one data set We can use combine the respective data in training and test data sets corresponding to subject, activity and features. The results are stored in Subject, Activity and Features.

Subject <- rbind(train_subject,test_subject)
Activity <- rbind(train_activity,test_activity)
Features <- rbind(train_features,test_features)

###Naming the columns The columns in the features data set can be named from the metadata in featureNames

colnames(Features) <- t(featureNames[2])

###Merge the data The data in features,activity and subject are merged and the complete data is now stored in CompleteData.

colnames(Activity) <- "Activity"
colnames(Subject) <- "Subject"
CompleteData <- cbind(Features,Activity,Subject)

##Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement

Extract the column indices that have either mean or std in them.

ColMeanSD <- grep("*Mean*|*Std*", names(CompleteData),ignore.case = TRUE)

Add activity and subject columns to the list .

FinalCol <-c(ColMeanSD,562,563)

We create FinalData with the selected columns in FinalCol. 

FinalData <- completeData[,FinalCol]

##Part 3 - Uses descriptive activity names to name the activities in the data set The activity field in extractedData is originally of numeric type. We need to change its type to character so that it can accept activity names. The activity names are taken from metadata activityLabels.

for(i in 1:nrow(FinalData))
{
 FinalData$Activity <-ActivityLabels[FinalData$Activity,2] 
}


##Part 4 - Appropriately labels the data set with descriptive variable names Here are the names of the variables in FinalData

names(FinalData)
By examining FinalData, we can say that the following acronyms can be replaced:

Acc can be replaced with Accelerometer

Gyro can be replaced with Gyroscope

BodyBody can be replaced with Body

Mag can be replaced with Magnitude

Character f can be replaced with Frequency

Character t can be replaced with Time

names(FinalData)<-gsub("Acc", "Accelerometer", names(FinalData))
names(FinalData)<-gsub("Gyro", "Gyroscope", names(FinalData))
names(FinalData)<-gsub("BodyBody", "Body", names(FinalData))
names(FinalData)<-gsub("Mag", "Magnitude", names(FinalData))
names(FinalData)<-gsub("^t", "Time", names(FinalData))
names(FinalData)<-gsub("^f", "Frequency", names(FinalData))
names(FinalData)<-gsub("tBody", "TimeBody", names(FinalData))
names(FinalData)<-gsub("-mean()", "Mean", names(FinalData), ignore.case = TRUE)
names(FinalData)<-gsub("-std()", "STD", names(FinalData), ignore.case = TRUE)
names(FinalData)<-gsub("-freq()", "Frequency", names(FinalData), ignore.case = TRUE)
names(FinalData)<-gsub("angle", "Angle", names(FinalData))
names(FinalData)<-gsub("gravity", "Gravity", names(FinalData))

##Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

We create CleanData as a data set with average for each activity and subject. Then, we order the enties in CleanData and write it into data file CleanData.txt that contains the processed data.

cleanData<-aggregate(FinalData,by=list(FinalData$Activity,FinalData$Subject),FUN = mean)
cleanData <- cleanData[order(cleanData$Activity,cleanData$Subject),]
write.table(cleanData, file = "CleanData.txt", row.names = FALSE)

Testing:-

Part1
The training and the test sets are merged into  one data set CompleteData and Column Features has correct column name as provided in features.txt

CompleteData

Part2
Only the measurements on the mean and standard deviation for each measurement is extracted into the dataset FinalData.

FinalData
dim(completeData)
dim(FinalData)

Part3
Descriptive activity names to name the activities in the data set FinalData as provided in activity_labels.txt

FinalData

Part4
The data set is labelled with descriptive variable names in FinalData.

names(FinalData)

Part5
A second, independent tidy data set with the average of each variable for each activity and each subject is created.

cleanData
CleanData.txt is tidy,clean and understandable.