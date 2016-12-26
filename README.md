Getting and Cleaning Data Course Project Readme
-----------------------------------------------

### Introduction

The goal is to prepare tidy data that can be used for later analysis. The project uses data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Contents

The project consists of three files:

1) *README.md* -- describes how to run the R script file.

2) *CodeBook.md* -- describes the variables, the data, and any transformations or work that was performed to clean up the data.

3) *run_analysis.R* -- the R script file.

### Running the script

1) Download the *UCI HAR Dataset.zip* file from the URL above.

2) Unzip the *UCI HAR Dataset.zip* file in the same directory as the *run_analysis.R* script file.

3) Set the R working directory to the directory containing the *run_analysis.R* script file.

4) Run the *run_analysis.R* script file.

5) Inspect the generated *tidy_dataset.txt* file.

### Implementation

Each of the 5 project steps is implemented in its own R function inside *run_analysis.R*. The functions are called consecutively and the result of each function call is saved to a separated variable whose value can be inspected in RStudio. The result for step 5 is additionally saved to the file named *tidy_dataset.txt*.

```{r}
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
```

The step functions are as follows:

#### Step1
Function ```mergeTrainAndTestDatasets()``` merges the training and the test sets to create one data set. Additinally, it assigns readable names to all variables.

```{r}
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
```

#### Step2
Function ```extractMeanAndStandardDeviationMeasurements()``` extracts only the measurements on the mean and standard deviation for each measurement. It does this by selecting only the columns Subject, Activity and the columns whose names contain "mean" and "std".

```{r}
extractMeanAndStandardDeviationMeasurements <- function(dataset) {
  # Select the column names containing "mean" and "std".
  columnsWithMeanAndStandardDeviationMeasurements <-
    grep(".*mean.*|.*std.*", names(dataset), ignore.case = TRUE)
  
  # Select and return only the Subject, Activity and the columns matching the
  # computed column names.
  dataset[, c(1, 2, columnsWithMeanAndStandardDeviationMeasurements)]
}
```

#### Step3
Function ```labelActivitiesWithDescriptiveNames()``` uses descriptive activity names to name the activities in the data set. It does this by substituting the numerical activity values with the corresponding activity labels.

```{r}
labelActivitiesWithDescriptiveNames <-
  function(dataset, activityLabels) {
    # Substitute the numerical value with the corresponding label.
    dataset$Activity <- activityLabels$V2[dataset$Activity]
    
    # Return the dataset.
    dataset
  }
```

#### Step4
Function ```labelDatasetWithDescriptiveVariableNames()``` appropriately labels the data set with descriptive variable names. It does this by replacing abbreviations with the full words and removing separators such as parentheses, dashes and periods.

```{r}
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
```

#### Step5
Function ```averageByActivityAndSubject()``` creates a second, independent tidy data set with the average of each variable for each activity and each subject. It does this by taking the result of step 4 and aggregating it on activity and subject using the mean function.

```{r}
averageByActivityAndSubject <- function(dataset) {
  # Aggregate by activity and subject and return the result.
  aggregate(. ~ Activity + Subject, dataset, mean)
}
```

--- END ---