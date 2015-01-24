# GettingData
Repository for coursera project in Getting Data course

This repo contains R code file 
1. run_analysis.R
2. tidydata_set.txt (the output file)
3. a code book describing the variables CodeBook.md

Basically, this code takes the raw data from working directly, read both training set and test set data.
What this code does is:
Merges the training and the test sets to create one data set, called "all".
Extracts only the measurements on the mean and standard deviation for each measurement. 
Only mean data paired with std were extracted. 
Uses descriptive activity names to name the activities in the data set.
activities are named based on the original activity_labels.txt file.

Appropriately labels the data set with descriptive variable names. 
Subject and measurements were renamed.
A new tidy data set was created after above operations, with the average of each variable for each activity and each subject.

My r-code may be clumsy. But I managed to do it. :D
