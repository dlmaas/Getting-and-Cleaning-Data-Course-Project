library(data.table)
library(plyr)
#
#		Check to see if the directory is created; create it if it is not.
#
if(!file.exists("./week4data")){dir.create("./week4data")}
#
#		Sets working directory to new file structure
#
setwd("./week4data")
#
# 		Downloads the zip file and store in the designated directory.
#
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="dataset.zip")
#
#		Unzips all the files that are in the data set.
#
unzip(zipfile="dataset.zip")
#
#		THis script only considers the following files from the zip noted above.
#		activity_labels.txt
#		features.txt
#		subject_test.txt
#		X_test.txt
#		y_test.txt
#		subject_train.txt
#		X_train.txt
#		train/y_train.txt
#
#
#		Reads testing files and creates corresponding data tables
#
test_data_activity  <- read.table(file.path("UCI HAR Dataset", "test" , "Y_test.txt" ),header = FALSE)
test_data_features  <- read.table(file.path("UCI HAR Dataset", "test" , "X_test.txt" ),header = FALSE)
test_data_subject   <- read.table(file.path("UCI HAR Dataset", "test" , "subject_test.txt"),header = FALSE)
#
#		Reads training files and creates corresponding data tables
#
train_data_activity <- read.table(file.path("UCI HAR Dataset", "train", "Y_train.txt"),header = FALSE)
train_data_features <- read.table(file.path("UCI HAR Dataset", "train", "X_train.txt"),header = FALSE)
train_data_subject  <- read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt"),header = FALSE)
#
#		Concatenates tables by row
#
data_subject <- rbind(train_data_subject, test_data_subject)
data_activity<- rbind(train_data_activity, test_data_activity)
data_features<- rbind(train_data_features, test_data_features)
#
#		Sets the names with variables
#
names(data_subject)<-c("subject")
names(data_activity)<- c("activity")
names_data_features <- read.table(file.path("UCI HAR Dataset", "features.txt"),head=FALSE)
names(data_features)<- names_data_features$V2
#
#		Moves the subject and activity data into a single file
#
combined_data_set <- cbind(data_subject, data_activity)
#
#
#	1. Merges the training and the test sets to create one data set.
#
#		Binds the features, subject and the activity into a one large set
#
final_data_set <- cbind(data_features, combined_data_set)
#
#	2.  Extracts only the measurements on the mean and standard deviation for each measurement.
#
names_data_features_names_subset<-names_data_features$V2[grep("mean\\(\\)|std\\(\\)", names_data_features$V2)]
#
#	3. Uses descriptive activity names to name the activities in the data set
#
Chosen_Variable_Names<-c(as.character(names_data_features_names_subset), "subject", "activity")
#
#		Subsets the data based on the selected names
#
final_data_set<-subset(final_data_set,select=Chosen_Variable_Names)
#
#	4. Appropriately labels the data set with descriptive variable names.
#
#		Changes the single character identifcation [^denote the first character in a title]
#
names(final_data_set)<-gsub("^t", "time", names(final_data_set))
names(final_data_set)<-gsub("^f", "frequency", names(final_data_set))
#
#		Changes abbreviations to proper names
#
names(final_data_set)<-gsub("Acc", "Accelerometer", names(final_data_set))
names(final_data_set)<-gsub("Gyro", "Gyroscope", names(final_data_set))
names(final_data_set)<-gsub("Mag", "Magnitude", names(final_data_set))
names(final_data_set)<-gsub("std", "StandardDeviation", names(final_data_set))
names(final_data_set)<-gsub("mean", "MeanValue", names(final_data_set))
#
#		Eliminates the redundant "body" in the variable name
#
names(final_data_set)<-gsub("BodyBody", "Body", names(final_data_set))
#
#
# 	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for  
#	each activity and each subject.
#
#		Aggregates based on subject and activity and apply mean function
#
tidy_data_set<-aggregate(. ~subject + activity, final_data_set, mean)
#
#		Sets the order in the tidy data set
#
tidy_data_set<-tidy_data_set[order(tidy_data_set$subject,tidy_data_set$activity),]
#
#		Creates a new text file from the tidy data set
#
write.table(tidy_data_set, file = "tidy_data_set.txt",row.name=FALSE)
#
#
