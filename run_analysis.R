download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "./data.zip", method="curl")
unzip("data.zip",exdir="./")
FeatureNames <- read.table(file = "features.txt")
ActivityLabels <- read.table(file = "activity_labels.txt",header = FALSE)

## Load the Training Data Set
train_subject <- read.table(file = "train/subject_train.txt",header = FALSE)
train_activity <- read.table(file = "train/y_train.txt",header = FALSE)
train_features <- read.table(file = "train/X_train.txt",header = FALSE)

## Load the Testing Data Set
test_subject <- read.table(file = "test/subject_test.txt",header = FALSE)
test_activity <- read.table(file = "test/y_test.txt",header = FALSE)
test_features <- read.table(file = "test/X_test.txt",header = FALSE)

## Merge the Training and Testing Data Set 
Subject <- rbind(train_subject,test_subject)
Activity <- rbind(train_activity,test_activity)
Features <- rbind(train_features,test_features)

## Name the Columns 
colnames(Features) <- t(FeatureNames[2])
colnames(Activity) <- "Activity"
colnames(Subject) <- "Subject"

## Create a complete Data Set
CompleteData <- cbind(Features,Activity,Subject)

##Columns with Mean and Standard Deviation
ColMeanSD <- grep("*Mean*|*Std*", names(CompleteData),ignore.case = TRUE)

##Column Set
FinalCol <-c(ColMeanSD,562,563)

##Get the required data set
FinalData <- CompleteData[,FinalCol]

##Activity Labels
for(i in 1:nrow(FinalData))
{
 FinalData$Activity <-ActivityLabels[FinalData$Activity,2] 
}


##Appropriately labels the data set with descriptive variable names. 
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

##Final clean data
cleanData<-aggregate(FinalData,by=list(FinalData$Activity,FinalData$Subject),FUN = mean)

##Order data based on Activity and Subject
cleanData <- cleanData[order(cleanData$Activity,cleanData$Subject),]

##Write the data set into a file.
write.table(cleanData, file = "CleanData.txt", row.names = FALSE)


