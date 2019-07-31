### The run_analysis.R script performs the data preparation according to the 5 steps as described in the course project.

1) Downloaded the dataset and extracted in to folder called UCI HAR Dataset.

2) Assign each data to variables.
- Features <- features.txt (561 rows, 2 columns) 
<br /> The features are selected from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- Activities <- activity_labels.txt (6 rows, 2 columns) 
<br /> List of activities performed (when taking the corresponding measurements) and its codes (labels)
- Subject_Test <- test/subject_test.txt (2947 rows, 1 column)
<br /> test data of 9/30 observed volunteer test subjects.
- X_Test <- test/X_test.txt (2947 rows, 561 columns)
<br /> Rrecorded features test data
- Y_Test <- test/y_test.txt (2947 rows, 1 columns)
<br /> Test data of activities’code labels
- Subject_Train <- test/subject_train.txt (7352 rows, 1 column)
<br /> train data of 21/30 observed volunteer subjects.
- X_Train <- test/X_train.txt (7352 rows, 561 columns)
<br /> Recorded features train data
- Y_Train <- test/y_train.txt (7352 rows, 1 columns)
<br /> Train data of activities’code labels

3) Merges the training and the test sets to create one data set.
<br /> X = merged x_train and x_test using rbind() function. (10299 rows, 561 columns) 
<br /> Y = merged y_train and y_test using rbind() function. (10299 rows, 1 column)
<br /> Subject = merged subject_train and subject_test using rbind() function. (10299 rows, 1 column)
<br /> Merged_Data = merged Subject, Y and X using cbind() function. (10299 rows, 563 column) 

4) Extracts only the measurements on the mean and standard deviation for each measurement.
<br />TidyDataSet1 = subset of Merged_Data, with selected columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement. (10299 rows, 88 columns)

5) Uses descriptive activity names to name the activities in the data set.
<br /> Entire numbers in code column of the TidyDataSet1 replaced with corresponding activity taken from second column of the  Activities variable.

6) Appropriately labels the data set with descriptive variable names.
<br /> code column in TidyDataSet1 renamed into activities.
<br /> *Acc in column’s name replaced by Accelerometer.
<br /> Gyro in column’s name replaced by Gyroscope.
<br /> BodyBody in column’s name replaced by Body.
<br /> Mag in column’s name replaced by Magnitude.
<br /> All column’s name start with character f are replaced by Frequency.
<br /> All the column’s name start with character t replaced by Time*

7) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
<br />TidyDataSet2 = sumarization of TidyDataSet1 by taking the means of each variable for each activity and each subject, after groupped by subject and activity. (180 rows, 88 columns) 
<br /> Export TidyDataSet2 into FinalTidyData.txt file.

