```
The script run_analysis.r is written for the R course project "Getting and Cleaning Data" from 
John Hopkins University (3/2014).

The course project consists of creating a "tidy" dataset using the raw data from:

    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

In particular, run_analysis.r does the following: 

   (1) Merges the training and the test sets to create one data set.
   (2) Extracts only the measurements on the mean and standard deviation for each measurement. 
   (3) Uses descriptive activity names to name the activities in the data set.
   (4) Appropriately labels the data set with descriptive variable names. 
   (5) From the data set in step (4), creates a second, independent tidy data set 
       with the average of each variable for each activity and each subject.

Some comments on each of the above steps are provided below:

################## part(1) ##################

The test data (2947 observations) is appended to the training data (7352 observations) 
for the following file types:

  1) X_*.txt
  2) y_*.txt
  3) subject_*.txt

creating a total of 10299 observations.

The measurement variable names were read from the file: features.txt
The activity mapping was read from the file: activity_labels.txt

A consistency check between the data set sizes was performed.

################## part(2) ##################

Only measurements that are the output of either the mean() or std() function are retained. 
In particular, measurements that are the output of the function meanFreq() are excluded. 
The desired measurement variables indicated with the suffix of either "_mean()" or "_std()".

################## part(3) ##################

The activity enumerations in the original data sets were replaced by their corresponding 
activity labels (as determined by the file activity_labels.txt).

A minor modification to the "WALK" activity label was done. "WALK" was changed to "WALK_LEVEL" 
to explicitly indicate the activity of walking on level ground.

################## part(4) ##################

The original measurement variable names were quite descriptive. So only minor modifications 
were done for clean up. The changes are outlined below:

    1) Variable names are kept together (not split by the function operating on the data).
          ex: "tBodyAcc-mean()-X" ==> "tBodyAccX-mean()"
    2) The variables with the redundant "BodyBody" term are replaced with a single "Body" 
          ex: "fBodyBodyAccJerkMag-std() => "fBodyAccJerkMag-std()"
    3) The "()" are removed to allow variable names to work with dplyr functions
          ex: "fBodyBodyAccJerkMag-std() => "fBodyAccJerkMag-std"
    4) The "-" are replaced with "_" to allow variable names to work with dplyr functions
          ex: "fBodyBodyAccJerkMag-std => "fBodyAccJerkMag_std"

A few additional clean up tasks were performed. In particular: 

     1) The input conditions are prepended (in the col dimension) to the data measurements
     2) the rows are sorted 1st by the strenuous level of the activity, and 2nd by the subject ID
             activity level sort order: 
                 "LAYING"             
                 "SITTING"            
                 "STANDING"           
                 "WALKING_LEVEL"      
                 "WALKING_DOWNSTAIRS"
                 "WALKING_UPSTAIRS"
     3) the cols are kept in their original order with the exception that the mean and std of 
        the same variable are kept in adjacent cols (to easily assess the quality of the measurement).

################## part(5) ##################

"tidyData2" computes the mean of each measurement variable of "tidydata1" grouped by 
distinct (activity,subjectID).

"tidyData2" has the same columns as "tidyData1" (above) and thus has the same tidy aspects.

The rows of "tidyData2" are sorted, 1st, according to activity (least strenuous to most strenuous), 
and 2nd, by subject ID.

The data, "tidyData2", when written out to a file ("tidyDataSummary.txt"), is hard to read because 
of the large number of columns and the large number of displayed digits. But it was deemed preferable 
to keep full precision since this is an input file for further downstream processing.

The dataset can be easily read into R with: 

    read.table("tidyDataSummary.txt", header = TRUE)


```
