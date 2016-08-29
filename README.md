### Introduction

This project was developed as part of the Coursera 'Getting and Cleaning Data Course Project'.
The purpose of this project was to demonstrate my ability to collect, work with, and clean a data set. The goal was to prepare tidy data that can be used for later analysis.  


### Information about the raw data that was collected and cleaned
The raw data that is processed being collected, relates to wearable computing.
The data analysed represents data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Information about the process used to clean and analyse the data
An R script called run_analysis.R which was created and is available in this repository that 
automatically does all the steps required to download, clean, and analyse the data.
The output of the R script is a file called 'variable_averages.txt' that is an independent, tidy data set containing 
the average of each variable for each activity and each subject from the raw data.  
A codebook Codebook.MD is also in the repository and contains more information about each of the variables in the 'variable_averages.txt' data set:

The high level steps undertaken by the run_analysis.R script are:
Step 0 - Downloads and unzips the dataset from the website link above.
Step 1 - Merges the training and the test sets to create one data set.
Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
Step 3 - Uses descriptive activity names to name the activities in the data set
Step 4 - Appropriately labels the data set with descriptive variable names.
Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Detailed information about each step undertaken by the run_analysis.R script:
The detailed steps undertaken by the run_analysis.R file are described below.  This information is also provided as 
commnets within the run_analysis.R file as well to assist people reading the code:

STEP 0 - DOWNLOADS AND UNZIPS DATA SET FILES
In this step the script checks to see whether an '/assignmentdata' folder is in the
current working directory, and creates one if there isn't.  The zip file is downloaded
to the folder and is then unzipped.


STEP 1 - MERGING DATA SET FILES INTO ONE FILE
During this step the script merges the various training and test sets of the dataset to 
create one data set. 
- It creates dataframes for each of the three test files
- It then creates dataframes for each of the three training files
- It then merges each of the test and training dataframes together and then merge them
  into one dataframe "fullmerged"
- Each of the variables in the 'fullmerged' dataframe aren't labelled so the scripts need to 
  get the variable names from the features.txt file and then assign
  them to each column of the 'fullmerged' dataframe.  It also adds 
  labels for the first two columns ('subject' and 'activity'). 


STEP 2 - EXTRACT MEASUREMENTS OF MEAN AND STANDARD DEVIATION
The script identifies the columns that have "Mean()", "mean()", "Std()", or "std()"
in the column labels and then extracts these columns and the 'subject' and 'activity' 
columns into a new data set 'extracteddata'


STEP 3 - USE DESCRIPTIVE ACTIVITY NAMES IN DATASET
The script loads the activity description file and then replaces the numeric values 
in the activityid column with activity descriptions that are more meaningful.
e.g. All '1' values are replaced with 'WALKING'. 


STEP 4 - MAKE VARIABLE NAMES MORE MEANINGFUL
The script replaces the variable names in the dataset to more meaningful names 
by:
  - making them lower case
  - substituting abbreviations with descriptions (e.g. 'std' become 'standarddeviation')
  - removing hyphens and brackets
  
  
STEP 5 - CREATE NEW, TIDY DATA SET WITH VARIABLE AVERAGES BY ACTIVITY AND SUBJECT
The script creates a new dataframe 'variableaverages' with the average of each variable for 
each activity and for each subject.  It then writes the dataframe to a text file called
'variable_averages.txt' that is saved in the 'assignmentdata' folder.
  