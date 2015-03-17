```
The original data sets are described in READMEsource.txt and CODEBOOKsource.txt (copied to my Repo)

The original variable names (from the features.txt file) are already quite descriptive.
Thus, the new data variable names for the tidy dataset are essentially the original data variable names 
with the following slight modifications:

    1) Variable names are kept together (not split by the function operating on the data).
          ex: "tBodyAcc-mean()-X" ==> "tBodyAccX-mean()"
    2) The variables with the redundant "BodyBody" term are replaced with a single "Body" 
          ex: "fBodyBodyAccJerkMag-std() => "fBodyAccJerkMag-std()"
    3) The "()" are removed to allow variable names to work with dplyr functions which operate on unquoted names 
          ex: "fBodyBodyAccJerkMag-std() => "fBodyAccJerkMag-std"
    4) The "-" are replaced with "_" to allow variable names to work with dplyr functions which operate on unquoted names
          ex: "fBodyBodyAccJerkMag-std => "fBodyAccJerkMag_std"

The activity label "WALK" was changed to "WALK_LEVEL" to explicitly indicate walking on level ground.
      
The new variable name can be decoded (from left to right) as follows:
    
    1) 1st character:
          t: indicates a time domain variable
          f: indicates a frequency domain variable (FFT of the corresponding time domain variable)
    2) next word:
          "Body": measurement processed to filter out the effects of gravity and noise (measure body motion only)
          "Gravity": measurement processed to filter out the effects of body motion (measure gravity effects only)
    3) next word:
          "Acc": accelerometer measurement
          "Gyro": gyroscope measurement
          "AccJerk": derivative with respect to time of accelerometer measurement
          "GyroJerk": derivative with respect to time of gyroscope measurement
    4) next word:
          "X": indicates measurement along the x-axis
          "Y": indicates measurement along the y-axis
          "Z": indicates measurement along the z-axis
          "Mag": derived magnitude from the (X,Y,Z) components of the basic variables
    5) final word:
          "_mean": the mean of that variable's measurements
          "_std": the std of that variable's measurements
            
Finally, note that the measurements have all been normalized to lie within [-1...1]; 
therefore the measurement variables are all unitless   

----------------------------------------
column variable     
----------------------------------------              
   [1] "activity" (factor)  
            "LAYING"                (1)             
            "SITTING"               (2)          
            "STANDING"              (3) 
            "WALKING_LEVEL"         (4) 
            "WALKING_DOWNSTAIRS"    (5)
            "WALKING_UPSTAIRS"      (6)
   [2] "subjectID" (integer)
            [1...30] unitless
   [3] "tBodyAccX_mean" (numeric)
            [-1...1] unitless
   [4] "tBodyAccX_std" (numeric) 
            [-1...1] unitless       
   [5] "tBodyAccY_mean" (numeric) 
            [-1...1] unitless      
   [6] "tBodyAccY_std" (numeric) 
            [-1...1] unitless       
   [7] "tBodyAccZ_mean" (numeric) 
            [-1...1] unitless      
   [8] "tBodyAccZ_std" (numeric) 
            [-1...1] unitless       
   [9] "tGravityAccX_mean" (numeric) 
            [-1...1] unitless   
  [10] "tGravityAccX_std" (numeric) 
            [-1...1] unitless    
  [11] "tGravityAccY_mean" (numeric) 
            [-1...1] unitless   
  [12] "tGravityAccY_std" (numeric) 
            [-1...1] unitless    
  [13] "tGravityAccZ_mean" (numeric) 
            [-1...1] unitless   
  [14] "tGravityAccZ_std" (numeric) 
            [-1...1] unitless    
  [15] "tBodyAccJerkX_mean" (numeric) 
            [-1...1] unitless  
  [16] "tBodyAccJerkX_std" (numeric) 
            [-1...1] unitless   
  [17] "tBodyAccJerkY_mean" (numeric) 
            [-1...1] unitless  
  [18] "tBodyAccJerkY_std" (numeric) 
            [-1...1] unitless   
  [19] "tBodyAccJerkZ_mean" (numeric) 
            [-1...1] unitless  
  [20] "tBodyAccJerkZ_std" (numeric) 
            [-1...1] unitless   
  [21] "tBodyGyroX_mean" (numeric) 
            [-1...1] unitless     
  [22] "tBodyGyroX_std" (numeric) 
            [-1...1] unitless      
  [23] "tBodyGyroY_mean" (numeric) 
            [-1...1] unitless     
  [24] "tBodyGyroY_std" (numeric) 
            [-1...1] unitless      
  [25] "tBodyGyroZ_mean" (numeric) 
            [-1...1] unitless     
  [26] "tBodyGyroZ_std" (numeric) 
            [-1...1] unitless      
  [27] "tBodyGyroJerkX_mean" (numeric) 
            [-1...1] unitless 
  [28] "tBodyGyroJerkX_std" (numeric) 
            [-1...1] unitless  
  [29] "tBodyGyroJerkY_mean" (numeric) 
            [-1...1] unitless 
  [30] "tBodyGyroJerkY_std" (numeric) 
            [-1...1] unitless  
  [31] "tBodyGyroJerkZ_mean" (numeric) 
            [-1...1] unitless 
  [32] "tBodyGyroJerkZ_std" (numeric) 
            [-1...1] unitless  
  [33] "tBodyAccMag_mean" (numeric) 
            [-1...1] unitless    
  [34] "tBodyAccMag_std" (numeric) 
            [-1...1] unitless     
  [35] "tGravityAccMag_mean" (numeric) 
            [-1...1] unitless 
  [36] "tGravityAccMag_std" (numeric) 
            [-1...1] unitless  
  [37] "tBodyAccJerkMag_mean" (numeric) 
            [-1...1] unitless
  [38] "tBodyAccJerkMag_std" (numeric) 
            [-1...1] unitless 
  [39] "tBodyGyroMag_mean" (numeric) 
            [-1...1] unitless   
  [40] "tBodyGyroMag_std" (numeric) 
            [-1...1] unitless    
  [41] "tBodyGyroJerkMag_mean" (numeric) 
            [-1...1] unitless
  [42] "tBodyGyroJerkMag_std" (numeric) 
            [-1...1] unitless
  [43] "fBodyAccX_mean" (numeric) 
            [-1...1] unitless      
  [44] "fBodyAccX_std" (numeric) 
            [-1...1] unitless       
  [45] "fBodyAccY_mean" (numeric) 
            [-1...1] unitless      
  [46] "fBodyAccY_std" (numeric) 
            [-1...1] unitless       
  [47] "fBodyAccZ_mean" (numeric) 
            [-1...1] unitless      
  [48] "fBodyAccZ_std" (numeric) 
            [-1...1] unitless       
  [49] "fBodyAccJerkX_mean" (numeric) 
            [-1...1] unitless  
  [50] "fBodyAccJerkX_std" (numeric) 
            [-1...1] unitless   
  [51] "fBodyAccJerkY_mean" (numeric) 
            [-1...1] unitless  
  [52] "fBodyAccJerkY_std" (numeric) 
            [-1...1] unitless   
  [53] "fBodyAccJerkZ_mean" (numeric) 
            [-1...1] unitless  
  [54] "fBodyAccJerkZ_std" (numeric) 
            [-1...1] unitless   
  [55] "fBodyGyroX_mean" (numeric) 
            [-1...1] unitless     
  [56] "fBodyGyroX_std" (numeric) 
            [-1...1] unitless      
  [57] "fBodyGyroY_mean" (numeric) 
            [-1...1] unitless     
  [58] "fBodyGyroY_std" (numeric) 
            [-1...1] unitless      
  [59] "fBodyGyroZ_mean" (numeric) 
            [-1...1] unitless     
  [60] "fBodyGyroZ_std" (numeric) 
            [-1...1] unitless      
  [61] "fBodyAccMag_mean" (numeric) 
            [-1...1] unitless    
  [62] "fBodyAccMag_std" (numeric) 
            [-1...1] unitless     
  [63] "fBodyAccJerkMag_mean" (numeric) 
            [-1...1] unitless
  [64] "fBodyAccJerkMag_std" (numeric) 
            [-1...1] unitless 
  [65] "fBodyGyroMag_mean" (numeric) 
            [-1...1] unitless   
  [66] "fBodyGyroMag_std" (numeric) 
            [-1...1] unitless    
  [67] "fBodyGyroJerkMag_mean" (numeric) 
            [-1...1] unitless
  [68] "fBodyGyroJerkMag_std" (numeric) 
            [-1...1] unitless
```
