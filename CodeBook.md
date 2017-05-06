CodeBook

This document describes the data and transofrmations used by run_analysis.R and the definition of variables in CleanData.txt.

##Dataset Used

This data is obtained from "Human Activity Recognition Using Smartphones Data Set". The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data set used can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

##Input Data Set

The input data containts the following data files:

X_train.txt contains variable features that are intended for training.
y_train.txt contains the activities corresponding to X_train.txt.
subject_train.txt contains information on the subjects from whom data is collected.
X_test.txt contains variable features that are intended for testing.
y_test.txt contains the activities corresponding to X_test.txt.
subject_test.txt contains information on the subjects from whom data is collected.
activity_labels.txt contains metadata on the different types of activities.
features.txt contains the name of the features in the data sets.

##Transformations

Following are the transformations that were performed on the input dataset:

X_train.txt is read into train_features.
y_train.txt is read into train_activity.
subject_train.txt is read into train_subject.
X_test.txt is read into test_features.
y_test.txt is read into test_activity.
subject_test.txt is read into test_subject.
features.txt is read into FeatureNames.
activity_labels.txt is read into ActivityLabels.

The subjects in training and test set data are merged to form Subject.
The activities in training and test set data are merged to form Activity.
The features of test and training are merged to form Features.

The name of the features are set in Features from FeatureNames.
Features, Activity and Subject are merged to form CompleteData.

Indices of columns that contain std or mean, activity and subject are taken into ColMeanSD .
FinalData is created with data from columns in ColMeanSD.

Activity column in FinalData is updated with descriptive names of activities taken from ActivityLabels. 

Acronyms in variable names in extractedData, like 'Acc', 'Gyro', 'Mag', 't' and 'f' are replaced with descriptive labels such as 'Accelerometer', 'Gyroscpoe', 'Magnitude', 'Time' and 'Frequency'.
CleanData is created as a set with average for each activity and subject of FinalData. Entries in CleanData are ordered based on activity and subject.
Finally, the data in CleanData is written into CleanData.txt.

##Output Data Set

The output data CleanData.txt is a a space-delimited value file. The header line contains the names of the variables. It contains the mean and standard deviation values of the data contained in the input files. The header is restructued in an understandable manner.