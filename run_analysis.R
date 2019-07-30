library(dplyr)
filename <- "Coursera_Cleaning_Data_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

Features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
Activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
Subject_Train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
Subject_Test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_Train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = Features$functions)
X_Test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = Features$functions)
Y_Train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
Y_Test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")


##Merges the training and the test sets to create one data set. (Step 1)##########################################################
X <- rbind(X_Train, X_Test)
Y <- rbind(Y_Train, Y_Test)
Subject <- rbind(Subject_Train, Subject_Test)
Merged_Data <- cbind(Subject, Y, X)

######Extracts only the measurements on the mean and standard deviation for each measurement (Step 2)######################################################
TidyDataSet1 <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


######Uses descriptive activity names to name the activities in the data set. (Step 3)######################################################
TidyDataSet1$code <- Activities[TidyDataSet1$code, 2]

######Appropriately labels the data set with descriptive variable names. (Step 4)######################################################
names(TidyDataSet1)[2] = "activity"
names(TidyDataSet1)<-gsub("Acc", "Accelerometer", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("Gyro", "Gyroscope", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("BodyBody", "Body", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("Mag", "Magnitude", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("^t", "Time", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("^f", "Frequency", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("tBody", "TimeBody", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("-mean()", "Mean", names(TidyDataSet1), ignore.case = TRUE)
names(TidyDataSet1)<-gsub("-std()", "STD", names(TidyDataSet1), ignore.case = TRUE)
names(TidyDataSet1)<-gsub("-freq()", "Frequency", names(TidyDataSet1), ignore.case = TRUE)
names(TidyDataSet1)<-gsub("angle", "Angle", names(TidyDataSet1))
names(TidyDataSet1)<-gsub("gravity", "Gravity", names(TidyDataSet1))

#######From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. (Step 5)######################################################
TidyDataSet2<- TidyDataSet1 %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(TidyDataSet2, "FinalTidyData.txt", row.name=FALSE)

