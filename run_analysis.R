library(data.table)

# 
# Step1 - Merges the training and the test sets to create one data set.
# 
mergeTrainAndTestDatasets <-
  function(trainSubjects,
           trainActivities,
           trainFeatures,
           testSubjects,
           testActivities,
           testFeatures,
           featureNames) {
    # Merge the train and test data by subject, activity and features.
    mergedSubjects <- rbind(testSubjects, trainSubjects)
    mergedActivities <- rbind(testActivities, trainActivities)
    mergedFeatures <- rbind(testFeatures, trainFeatures)
    
    # Assign readable column names.
    colnames(mergedSubjects) <- "Subject"
    colnames(mergedActivities) <- "Activity"
    colnames(mergedFeatures) <- t(featureNames[2])
    
    # Merge and return the data.
    cbind(mergedSubjects, mergedActivities, mergedFeatures)
  }

# 
# Step2 - Extracts only the measurements on the mean and standard deviation for
# each measurement.
# 
extractMeanAndStandardDeviationMeasurements <- function(dataset) {
  # Select the column names containing "mean" and "std".
  columnsWithMeanAndStandardDeviationMeasurements <-
    grep(".*mean.*|.*std.*", names(dataset), ignore.case = TRUE)
  
  # Select and return only the Subject, Activity and the columns matching the
  # computed column names.
  dataset[, c(1, 2, columnsWithMeanAndStandardDeviationMeasurements)]
}

# 
# Step3 - Uses descriptive activity names to name the activities in the data
# set.
# 
labelActivitiesWithDescriptiveNames <-
  function(dataset, activityLabels) {
    # Substitute the numerical value with the corresponding label.
    dataset$Activity <- activityLabels$V2[dataset$Activity]
    
    # Convert activity to factor.
    dataset$Activity <- as.factor(dataset$Activity)
    
    # Return the dataset.
    dataset
  }

# 
# Step4 - Appropriately labels the data set with descriptive variable names.
# 
labelDatasetWithDescriptiveVariableNames <- function(dataset) {
  # Replace abreviations.
  names(dataset) <- gsub("Acc", "Accelerometer", names(dataset))
  names(dataset) <- gsub("Freq", "Frequency", names(dataset))
  names(dataset) <- gsub("Gyro", "Gyroscope", names(dataset))
  names(dataset) <- gsub("Mag", "Magnitude", names(dataset))
  
  names(dataset) <- gsub("-mean", "Mean", names(dataset))
  names(dataset) <- gsub("-std", "StandardDeviation", names(dataset))
  names(dataset) <- gsub("-freq", "Frequency", names(dataset))
  
  # Replace mistakes.
  names(dataset) <- gsub("BodyBody", "Body", names(dataset))
  
  # Replace angle() arguments.
  names(dataset) <- gsub("tBody", "TimeBody", names(dataset))
  names(dataset) <- gsub("gravity", "Gravity", names(dataset))
  
  # Replace prefixes.
  names(dataset) <- gsub("^t", "Time", names(dataset))
  names(dataset) <- gsub("^f", "Frequency", names(dataset))
  names(dataset) <- gsub("^angle", "Angle", names(dataset))
  
  # Remove separators such as parentheses, dashes and commas.
  names(dataset) <- gsub("\\(|\\)|-|,", "", names(dataset))
  
  # Return the dataset.
  dataset
}

# 
# Step5 - From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.
# 
averageByActivityAndSubject <- function(dataset) {
  # Aggregate by activity and subject and return the result.
  aggregate(. ~ Activity + Subject, dataset, mean)
}

# Run Step1
question1Results <-
  mergeTrainAndTestDatasets(
    trainSubjects = read.table("UCI HAR Dataset/train/subject_train.txt"),
    trainActivities = read.table("UCI HAR Dataset/train/y_train.txt"),
    trainFeatures = read.table("UCI HAR Dataset/train/X_train.txt"),
    testSubjects = read.table("UCI HAR Dataset/test/subject_test.txt"),
    testActivities = read.table("UCI HAR Dataset/test/y_test.txt"),
    testFeatures = read.table("UCI HAR Dataset/test/X_test.txt"),
    featureNames = read.table("UCI HAR Dataset/features.txt")
  )

# Run Step2
question2Results <-
  extractMeanAndStandardDeviationMeasurements(question1Results)

# Run Step3
question3Results <-
  labelActivitiesWithDescriptiveNames(question2Results,
                                      read.table("UCI HAR Dataset/activity_labels.txt"))

# Run Step4
question4Results <-
  labelDatasetWithDescriptiveVariableNames(question3Results)

# Run Step5
question5Results <- averageByActivityAndSubject(question4Results)

# Save the dataset to file
write.table(question5Results, file = "tidy_dataset.txt", row.names = FALSE)
