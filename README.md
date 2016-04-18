Getting-and-Cleaning-Data-Course-Project

This project has 5 goals:
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity     and each subject.
    
The data set is retrived from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Additional content:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


How to Run

The script will load the two libraries that are needed for this session

Check to see if the directory is created; create it if it is not.

Sets working directory to new file structure

Downloads the zip file and store in the designated directory.

Unzips all the files that are in the data set.

This script will only look at the following 

        activity_labels.txt
        features.txt
        test/subject_test.txt
        test/X_test.txt
        test/y_test.txt
        train/subject_train.txt
        train/X_train.txt
        train/y_train.txt

Reads the testing files and creates corresponding testing data tables
Reads the training files and creates corresponding training data tables
The script then concatenates tables by row
The script sets the names with variables
Moves the subject and activity data into a single file
combined_data_set <- cbind(data_subject, data_activity)
	1. Merges the training and the test sets to create one data set.
    	Binds the features, subject and the activity into a one large set
    2.  Extracts only the measurements on the mean and standard deviation for each measurement.
	3. Uses descriptive activity names to name the activities in the data set
		Subsets the data based on the selected names
	4. Appropriately labels the data set with descriptive variable names.
		Changes the single character identifcation [^denote the first character in a title]
		Changing abbreviations to proper names
		Eliminating the redundant "body" in the variable name
 	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for  
    	each activity and each subject.
		Aggregate based on subject and activity and apply mean function
		Set the order in the tidy data set
		Create a new text file from the tidy data set
