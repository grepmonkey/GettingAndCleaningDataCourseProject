Getting and Cleaning Data Course Project CodeBook
-------------------------------------------------

### Introduction

This document describes the variables, the data, and the transformations that were performed to clean up the data.

### Input Data

The project uses data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The input data consists of the following files:

- ./UCI HAR Dataset/train/subject_train.txt
- ./UCI HAR Dataset/train/y_train.txt
- ./UCI HAR Dataset/train/X_train.txt
- ./UCI HAR Dataset/test/subject_test.txt
- ./UCI HAR Dataset/test/y_test.txt
- ./UCI HAR Dataset/test/X_test.txt
- ./UCI HAR Dataset/features.txt
- ./UCI HAR Dataset/activity_labels.txt

From these files only the subject data, activity data, and the mean and standard deviation feature data was used.

These are all the input variables used:

```{r}
 [1] "Subject"                             
 [2] "Activity"                            
 [3] "tBodyAcc-mean()-X"                   
 [4] "tBodyAcc-mean()-Y"                   
 [5] "tBodyAcc-mean()-Z"                   
 [6] "tBodyAcc-std()-X"                    
 [7] "tBodyAcc-std()-Y"                    
 [8] "tBodyAcc-std()-Z"                    
 [9] "tGravityAcc-mean()-X"                
[10] "tGravityAcc-mean()-Y"                
[11] "tGravityAcc-mean()-Z"                
[12] "tGravityAcc-std()-X"                 
[13] "tGravityAcc-std()-Y"                 
[14] "tGravityAcc-std()-Z"                 
[15] "tBodyAccJerk-mean()-X"               
[16] "tBodyAccJerk-mean()-Y"               
[17] "tBodyAccJerk-mean()-Z"               
[18] "tBodyAccJerk-std()-X"                
[19] "tBodyAccJerk-std()-Y"                
[20] "tBodyAccJerk-std()-Z"                
[21] "tBodyGyro-mean()-X"                  
[22] "tBodyGyro-mean()-Y"                  
[23] "tBodyGyro-mean()-Z"                  
[24] "tBodyGyro-std()-X"                   
[25] "tBodyGyro-std()-Y"                   
[26] "tBodyGyro-std()-Z"                   
[27] "tBodyGyroJerk-mean()-X"              
[28] "tBodyGyroJerk-mean()-Y"              
[29] "tBodyGyroJerk-mean()-Z"              
[30] "tBodyGyroJerk-std()-X"               
[31] "tBodyGyroJerk-std()-Y"               
[32] "tBodyGyroJerk-std()-Z"               
[33] "tBodyAccMag-mean()"                  
[34] "tBodyAccMag-std()"                   
[35] "tGravityAccMag-mean()"               
[36] "tGravityAccMag-std()"                
[37] "tBodyAccJerkMag-mean()"              
[38] "tBodyAccJerkMag-std()"               
[39] "tBodyGyroMag-mean()"                 
[40] "tBodyGyroMag-std()"                  
[41] "tBodyGyroJerkMag-mean()"             
[42] "tBodyGyroJerkMag-std()"              
[43] "fBodyAcc-mean()-X"                   
[44] "fBodyAcc-mean()-Y"                   
[45] "fBodyAcc-mean()-Z"                   
[46] "fBodyAcc-std()-X"                    
[47] "fBodyAcc-std()-Y"                    
[48] "fBodyAcc-std()-Z"                    
[49] "fBodyAcc-meanFreq()-X"               
[50] "fBodyAcc-meanFreq()-Y"               
[51] "fBodyAcc-meanFreq()-Z"               
[52] "fBodyAccJerk-mean()-X"               
[53] "fBodyAccJerk-mean()-Y"               
[54] "fBodyAccJerk-mean()-Z"               
[55] "fBodyAccJerk-std()-X"                
[56] "fBodyAccJerk-std()-Y"                
[57] "fBodyAccJerk-std()-Z"                
[58] "fBodyAccJerk-meanFreq()-X"           
[59] "fBodyAccJerk-meanFreq()-Y"           
[60] "fBodyAccJerk-meanFreq()-Z"           
[61] "fBodyGyro-mean()-X"                  
[62] "fBodyGyro-mean()-Y"                  
[63] "fBodyGyro-mean()-Z"                  
[64] "fBodyGyro-std()-X"                   
[65] "fBodyGyro-std()-Y"                   
[66] "fBodyGyro-std()-Z"                   
[67] "fBodyGyro-meanFreq()-X"              
[68] "fBodyGyro-meanFreq()-Y"              
[69] "fBodyGyro-meanFreq()-Z"              
[70] "fBodyAccMag-mean()"                  
[71] "fBodyAccMag-std()"                   
[72] "fBodyAccMag-meanFreq()"              
[73] "fBodyBodyAccJerkMag-mean()"          
[74] "fBodyBodyAccJerkMag-std()"           
[75] "fBodyBodyAccJerkMag-meanFreq()"      
[76] "fBodyBodyGyroMag-mean()"             
[77] "fBodyBodyGyroMag-std()"              
[78] "fBodyBodyGyroMag-meanFreq()"         
[79] "fBodyBodyGyroJerkMag-mean()"         
[80] "fBodyBodyGyroJerkMag-std()"          
[81] "fBodyBodyGyroJerkMag-meanFreq()"     
[82] "angle(tBodyAccMean,gravity)"         
[83] "angle(tBodyAccJerkMean),gravityMean)"
[84] "angle(tBodyGyroMean,gravityMean)"    
[85] "angle(tBodyGyroJerkMean,gravityMean)"
[86] "angle(X,gravityMean)"                
[87] "angle(Y,gravityMean)"                
[88] "angle(Z,gravityMean)" 
```


### Output Data

The output data is saved to a file named *tidy_data.txt* in tabular format with a single space used as delimiter. It includes only the subject data, the activity data, and the mean and standard deviation data extracted and merged from the input data.

Here are all the output variables as mapped to input variables by index:

```{r}
 [1] "Activity"                                                
 [2] "Subject"                                                 
 [3] "TimeBodyAccelerometerMeanX"                              
 [4] "TimeBodyAccelerometerMeanY"                              
 [5] "TimeBodyAccelerometerMeanZ"                              
 [6] "TimeBodyAccelerometerStandardDeviationX"                 
 [7] "TimeBodyAccelerometerStandardDeviationY"                 
 [8] "TimeBodyAccelerometerStandardDeviationZ"                 
 [9] "TimeGravityAccelerometerMeanX"                           
[10] "TimeGravityAccelerometerMeanY"                           
[11] "TimeGravityAccelerometerMeanZ"                           
[12] "TimeGravityAccelerometerStandardDeviationX"              
[13] "TimeGravityAccelerometerStandardDeviationY"              
[14] "TimeGravityAccelerometerStandardDeviationZ"              
[15] "TimeBodyAccelerometerJerkMeanX"                          
[16] "TimeBodyAccelerometerJerkMeanY"                          
[17] "TimeBodyAccelerometerJerkMeanZ"                          
[18] "TimeBodyAccelerometerJerkStandardDeviationX"             
[19] "TimeBodyAccelerometerJerkStandardDeviationY"             
[20] "TimeBodyAccelerometerJerkStandardDeviationZ"             
[21] "TimeBodyGyroscopeMeanX"                                  
[22] "TimeBodyGyroscopeMeanY"                                  
[23] "TimeBodyGyroscopeMeanZ"                                  
[24] "TimeBodyGyroscopeStandardDeviationX"                     
[25] "TimeBodyGyroscopeStandardDeviationY"                     
[26] "TimeBodyGyroscopeStandardDeviationZ"                     
[27] "TimeBodyGyroscopeJerkMeanX"                              
[28] "TimeBodyGyroscopeJerkMeanY"                              
[29] "TimeBodyGyroscopeJerkMeanZ"                              
[30] "TimeBodyGyroscopeJerkStandardDeviationX"                 
[31] "TimeBodyGyroscopeJerkStandardDeviationY"                 
[32] "TimeBodyGyroscopeJerkStandardDeviationZ"                 
[33] "TimeBodyAccelerometerMagnitudeMean"                      
[34] "TimeBodyAccelerometerMagnitudeStandardDeviation"         
[35] "TimeGravityAccelerometerMagnitudeMean"                   
[36] "TimeGravityAccelerometerMagnitudeStandardDeviation"      
[37] "TimeBodyAccelerometerJerkMagnitudeMean"                  
[38] "TimeBodyAccelerometerJerkMagnitudeStandardDeviation"     
[39] "TimeBodyGyroscopeMagnitudeMean"                          
[40] "TimeBodyGyroscopeMagnitudeStandardDeviation"             
[41] "TimeBodyGyroscopeJerkMagnitudeMean"                      
[42] "TimeBodyGyroscopeJerkMagnitudeStandardDeviation"         
[43] "FrequencyBodyAccelerometerMeanX"                         
[44] "FrequencyBodyAccelerometerMeanY"                         
[45] "FrequencyBodyAccelerometerMeanZ"                         
[46] "FrequencyBodyAccelerometerStandardDeviationX"            
[47] "FrequencyBodyAccelerometerStandardDeviationY"            
[48] "FrequencyBodyAccelerometerStandardDeviationZ"            
[49] "FrequencyBodyAccelerometerMeanFrequencyX"                
[50] "FrequencyBodyAccelerometerMeanFrequencyY"                
[51] "FrequencyBodyAccelerometerMeanFrequencyZ"                
[52] "FrequencyBodyAccelerometerJerkMeanX"                     
[53] "FrequencyBodyAccelerometerJerkMeanY"                     
[54] "FrequencyBodyAccelerometerJerkMeanZ"                     
[55] "FrequencyBodyAccelerometerJerkStandardDeviationX"        
[56] "FrequencyBodyAccelerometerJerkStandardDeviationY"        
[57] "FrequencyBodyAccelerometerJerkStandardDeviationZ"        
[58] "FrequencyBodyAccelerometerJerkMeanFrequencyX"            
[59] "FrequencyBodyAccelerometerJerkMeanFrequencyY"            
[60] "FrequencyBodyAccelerometerJerkMeanFrequencyZ"            
[61] "FrequencyBodyGyroscopeMeanX"                             
[62] "FrequencyBodyGyroscopeMeanY"                             
[63] "FrequencyBodyGyroscopeMeanZ"                             
[64] "FrequencyBodyGyroscopeStandardDeviationX"                
[65] "FrequencyBodyGyroscopeStandardDeviationY"                
[66] "FrequencyBodyGyroscopeStandardDeviationZ"                
[67] "FrequencyBodyGyroscopeMeanFrequencyX"                    
[68] "FrequencyBodyGyroscopeMeanFrequencyY"                    
[69] "FrequencyBodyGyroscopeMeanFrequencyZ"                    
[70] "FrequencyBodyAccelerometerMagnitudeMean"                 
[71] "FrequencyBodyAccelerometerMagnitudeStandardDeviation"    
[72] "FrequencyBodyAccelerometerMagnitudeMeanFrequency"        
[73] "FrequencyBodyAccelerometerJerkMagnitudeMean"             
[74] "FrequencyBodyAccelerometerJerkMagnitudeStandardDeviation"
[75] "FrequencyBodyAccelerometerJerkMagnitudeMeanFrequency"    
[76] "FrequencyBodyGyroscopeMagnitudeMean"                     
[77] "FrequencyBodyGyroscopeMagnitudeStandardDeviation"        
[78] "FrequencyBodyGyroscopeMagnitudeMeanFrequency"            
[79] "FrequencyBodyGyroscopeJerkMagnitudeMean"                 
[80] "FrequencyBodyGyroscopeJerkMagnitudeStandardDeviation"    
[81] "FrequencyBodyGyroscopeJerkMagnitudeMeanFrequency"        
[82] "AngleTimeBodyAccelerometerMeanGravity"                   
[83] "AngleTimeBodyAccelerometerJerkMeanGravityMean"           
[84] "AngleTimeBodyGyroscopeMeanGravityMean"                   
[85] "AngleTimeBodyGyroscopeJerkMeanGravityMean"               
[86] "AngleXGravityMean"                                       
[87] "AngleYGravityMean"                                       
[88] "AngleZGravityMean"  
```

### Transformations

These are all the transformations that were applied to the input data to produce the output data:

1) Subjects, activities and features training and test data was merged into a new dataset.

2) Readable variable names were assigned to the new dataset.

    - Used "Subject" for subject variable.
    
    - Used "Activity" for activity variable.
    
    - Used data from ./UCI HAR Dataset/features.txt for features variables.
    
3) Variables other than subject, activity, mean and standard deviation were removed from the new dataset.

4) Readable activity labels were assigned to the activity variable.

    - Used data from ./UCI HAR Dataset/activity_labels.txt
    
    - Converted activity variable to factor.
    
5) The new dataset variable names were transformed into readable names.

    - The following regular expression transformations were applied to variable names:
    
        - "Acc" -> "Accelerometer"
        
        - "Freq" -> "Frequency"
        
        - "Gyro" -> "Gyroscope"
        
        - "Mag" -> "Magnitude"
        
        - "-mean" -> "Mean"
        
        - "-std" -> "StandardDeviation"
        
        - "-freq" -> "Frequency"
        
        - "BodyBody" -> "Body"
        
        - "tBody" -> "TimeBody"
        
        - "gravity" -> "Gravity"
        
        - "^t" -> "Time"
        
        - "^f" -> "Frequency"
        
        - "^angle" -> "Angle"
        
        - "(|)|-|," -> ""
        
6) The new dataset was aggregated by activity and subject and the mean function applied.

--- END ---