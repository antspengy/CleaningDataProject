run_analysis <- function() {
 
  ## This run_analysis function downloads, cleans, and summarises 
  ## data collected from the accelerometers from the Samsung Galaxy S smartphone
  ## It has been developed for the Coursera 'Getting and Cleaning Data Course Project'
  ## More information is available in the readme file.
  
  ## Step 0 - DOWNLOADS AND UNZIPS DATA SET FILES
  ## In this step we check to see whether an '/assignmentdata' folder is in the
  ## current working directory, and creates one if there isn't.  The zip file is downloaded
  ## to the folder and is then unzipped.
  if(!file.exists("./assignmentdata")){dir.create("./assignmentdata")}
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl,destfile="./assignmentdata/dataset.zip",method="auto")
  unzip(zipfile="./assignmentdata/dataset.zip", exdir="./assignmentdata")
  files_location <- "./assignmentdata/UCI HAR Dataset/"
  
  
  ## STEP 1 - MERGING DATA SET FILES INTO ONE FILE
  ## During this step we merge the various training and test sets of the dataset to 
  ## create one data set.  I 
  
  ## creates dataframes for each of the three test files
  subjecttest <- read.table(paste(files_location, "test/subject_test.txt", sep=""))
  xtest <- read.table(paste(files_location, "test/X_test.txt", sep=""))
  ytest <- read.table(paste(files_location, "test/y_test.txt", sep=""))
  
  ## creates dataframes for each of the three training files
  subjecttrain <- read.table(paste(files_location, "train/subject_train.txt", sep=""))
  xtrain <- read.table(paste(files_location, "train/X_train.txt", sep=""))
  ytrain <- read.table(paste(files_location, "train/y_train.txt", sep=""))  
  
  ## merges each of the test and training dataframes together and then merges them
  ## into one dataframe "fullmerged". 
  subjectmerged <- rbind(subjecttrain, subjecttest)
  xmerged <- rbind(xtrain, xtest)
  ymerged <- rbind(ytrain, ytest)
  fullmerged <- cbind(subjectmerged, ymerged, xmerged)
  
  ## Each of the variables in the 'fullmerged' dataframe aren't labelled so we need to 
  ## get the variable names from the features.txt file and then assign
  ## them to each column of the 'fullmerged' dataframe.  We have to also add our own 
  ## labels for the first two columns ('subject' and 'activity').  
  columnnames <- read.table(paste(files_location, "features.txt", sep=""))
  variablenames<- as.character(columnnames$V2)
  names(fullmerged) <- c("subject", "activity", variablenames) 

  
  ## STEP 2 - EXTRACT MEASUREMENTS OF MEAN AND STANDARD DEVIATION
  ## This code identifies the columns that have "Mean()", "mean()", "Std()", or "std()"
  ## in the column labels and then extracts these columns and the subjectid and activityid 
  ## columns into a new data set 'extracteddata'
  columnstoselect <- grep("[Mm]ean\\(\\)|[Ss]td\\(\\)", names(fullmerged))
  extracteddata <- fullmerged[,c(1, 2, columnstoselect)]
  
  
  ## STEP 3 - USE DESCRIPTIVE ACTIVITY NAMES IN DATASET
  ## This code loads the activity description file and then replaces the numeric values 
  ## in the activityid column with activity descriptions that are more meaningful.
  ## e.g. All '1' values are replaced with 'WALKING'.  
  activitydescriptions <- read.table(paste(files_location, "activity_labels.txt", sep=""))
  activitynames<- as.character(activitydescriptions$V2)
  extracteddata$activity <- activitynames[extracteddata$activity]
  extracteddata$activity <- as.factor(extracteddata$activity)
  
  
  ## STEP 4 - MAKE VARIABLE NAMES MORE MEANINGFUL
  ## This code replaces the variable names in the dataset to more meaningful names 
  ## by:
  ##    - making them lower case
  ##    - substituting abbreviations with descriptions (e.g. 'std' become 'standarddeviation')
  ##    - removing hyphens and brackets
  names(extracteddata) <- tolower(names(extracteddata))
  names(extracteddata) <- gsub("std","standarddeviation",names(extracteddata))
  names(extracteddata) <- gsub("acc","accelerometer",names(extracteddata))
  names(extracteddata) <- gsub("gyro","gyroscope",names(extracteddata))
  names(extracteddata) <- gsub("-","",names(extracteddata))
  names(extracteddata) <- gsub("\\(\\)","",names(extracteddata))

  
  ## STEP 5 - CREATE NEW, TIDY DATA SET WITH VARIABLE AVERAGES BY ACTIVITY AND SUBJECT
  ## This code creates a new dataframe 'variableaverages' with the average of each variable for 
  ## each activity and for each subject.  It then writes the dataframe to a text file called
  ## 'variable_averages.txt' that is saved in the 'assignmentdata' folder.
  variableaverages <- aggregate(extracteddata[,(3:ncol(extracteddata))], by=list(subject=extracteddata$subject,activity=extracteddata$activity), FUN=mean, na.rm=TRUE)
  write.table(variableaverages, row.names = FALSE, file = "./assignmentdata/variable_averages.txt")
  
}


  