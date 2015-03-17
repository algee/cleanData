# This script is submitted in fullfillment of the "Getting and Cleaning Data" course project

# run_analysis.R that does the following: 
# 
#   (1) Merges the training and the test sets to create one data set.
#   (2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#   (3) Uses descriptive activity names to name the activities in the data set
#   (4) Appropriately labels the data set with descriptive variable names. 
#   (5) From the data set in step 4, creates a second, independent tidy data set 
#       with the average of each variable for each activity and each subject.



################## part(1) ##################
#
# read raw input files and combine the training and test data sets
#
#     1) read map between enumerated activity and activity label
#     2) read variable names
#     3) read training and test data
#            test data is appended to training data
#     4) perform consistency check between files           

activityMap <- read.table("../data/UCI HAR Dataset/activity_labels.txt", sep = "")   # [6 x 1]
featureName <- read.table("../data/UCI HAR Dataset/features.txt", sep = "")          # [561 x 1]

a <- read.table("../data/UCI HAR Dataset/train/y_train.txt", sep = "")
b <- read.table("../data/UCI HAR Dataset/test/y_test.txt", sep = "")
activityEnum <- rbind(a,b)   # [10299 x 1]

a <- read.table("../data/UCI HAR Dataset/train/subject_train.txt", sep = "")
b <- read.table("../data/UCI HAR Dataset/test/subject_test.txt", sep = "")
subjectID <- rbind(a,b)      # [10299 x 1]

a <- read.table("../data/UCI HAR Dataset/train/X_train.txt", sep = "")
b <- read.table("../data/UCI HAR Dataset/test/X_test.txt", sep = "")
rawData <- rbind(a,b)        # [10299 x 561]

# check for data size consistency
if ( (nrow(rawData) != nrow(subjectID)) || (nrow(rawData) != nrow(activityEnum)) ) {
  print("size error: number of subjects mismatch")
}
if ( (ncol(rawData) != nrow(featureName)) ) {
  print("size error: number of features mismatch")
}
if ( !all(unique(activityEnum)$V1 %in% activityMap$V1) ) {
  print("size error: number of activities mismatch")
}

################## part(3) ##################
#
# replace activity enumerations with activity labels (factors)
#
#     special note: The activity label "WALKING" is replaced with 
#                   the more descriptive activity label "WALKING_LEVEL".

levels(activityMap$V2)[levels(activityMap$V2) == "WALKING"] <- "WALKING_LEVEL"
activityLabel <- (activityMap$V2[activityEnum$V1])

################## part(2) ##################
#
# extract measurements of mean() and std() only (at this point, the desired datasets are identified only)
#
#     note: This restriction is interpreted as keeping only the measurements
#           that have been produced from the functions mean() or std().
#           In particular, the function meanFreq() is excluded.
#

# find only features formed from mean() or std()
Nfeature <- nrow(featureName)
matchIndex <- grepl("mean[(][)]",featureName$V2) | grepl("std[(][)]",featureName$V2)
matchFeature <- featureName[matchIndex,]  # 66 cases, 33 mean() + 33 std()

################## part(4) ##################
#
# label the measurements with descriptive variable names
#
#     The original variable names (from the features.txt file) are already 
#     quite descriptive and don't require modification
#
#     However, some slight improvements can be made:
#        1) combine the variable prefix and suffix, instead of splitting them apart with the 
#           applied function identifier
#           ex: "tBodyAcc-mean()-X" ==> "tBodyAccX-mean()"
#        2) replace variables with redundant "Body" with a single "Body"
#           ex: "fBodyBodyAccJerkMag-std() => "fBodyAccJerkMag-std()"
#        3) replace "()" with ""
#           ex: "fBodyBodyAccJerkMag-std() => "fBodyAccJerkMag-std"
#        4) replace "-" with "_"
#           ex: "fBodyBodyAccJerkMag-std => "fBodyAccJerkMag_std"
#   

index <- grepl("-mean[()][)]-[XYZ]$",matchFeature$V2)
varDesc <- sub("-mean[(][)]-","",matchFeature$V2)
varDesc[index] <- paste(varDesc[index],"-mean()", sep="")
  
index <- grepl("-std[()][)]-[XYZ]$",matchFeature$V2)
varDesc <- sub("-std[(][)]-","",varDesc)
varDesc[index] <- paste(varDesc[index],"-std()", sep="")

varDesc <- sub("BodyBody","Body",varDesc)
varDesc <- sub("[(][)]$","",varDesc)
varDesc <- gsub("-","_",varDesc)

################## general tidying ##################
#
# The data is sorted along rows and columns
#
#     1) the rows are sorted 1st by the strenuous level of the activity, and 2nd by the subject ID
#             activity level sort order: 
#                 "LAYING"             
#                 "SITTING"            
#                 "STANDING"           
#                 "WALKING_LEVEL"      
#                 "WALKING_DOWNSTAIRS"
#                 "WALKING_UPSTAIRS"
#     2) the cols are kept in their original order with the exception that the mean and std of the same
#        variable are kept adjacent (to easily assess the quality of the measurement)
#
# The input conditions are prepended (in the col dimension) to the data measurements

# pair up the mean variables and their respective std variables
Ndesc = length(varDesc)
v <- 1:Ndesc
cindex <- vector(mode = "integer", Ndesc)
cindex[seq(from = 1, to = Ndesc, by = 2)] <- v[grepl("_mean$",varDesc)]
cindex[seq(from = 2, to = Ndesc, by = 2)] <- v[grepl("_std$",varDesc)]

varDesc <- varDesc[cindex]
v <- 1:Nfeature
rawIndex <- v[matchIndex]
rawIndex <- rawIndex[cindex]

# contruct the "tidy" dataset, prepend input conditions, sort according to (mean,std) pairing
tidyData1 <- cbind(activityLabel, subjectID, rawData[,rawIndex])

Nr <- nrow(tidyData1)
Nc <- ncol(tidyData1)

colnames(tidyData1) <- c("activity","subjectID",varDesc)   # set the col variable names

# sort according (1st) by strenuousness of activity (2nd) by subjectID
sortIndex <- order(tidyData1$activity, tidyData1$subjectID)
tidyData1 <- tidyData1[sortIndex,]

rownames(tidyData1) <- 1:Nr                                # set the row variable names

################## part(5) ##################
#
# compute mean for each activity and each subject
#
# write the data frame out to a text file
#
#    although the file is hard to read with the large number of displayed digits, it
#    was deemed preferable to keep full precision since this is an input file for 
#    downstream processing
#

# unique (activity,subject) pairs
uniqueRow <- unique(tidyData1[,1:2])
Nu <- nrow(uniqueRow)

# compute mean for the unique cases (I would have liked to use summarize() but didn't find a way to automatically list all the variables)
meanOut <- matrix(0,nrow = Nu, ncol = Nc-2)
for (n in 1:Nu) {
  meanOut[n,] <- colMeans( tidyData1[(tidyData1$activity == uniqueRow$activity[n]) & (tidyData1$subjectID == uniqueRow$subjectID[n]),3:Nc] )
}

# prepend input conditions to the data
tidyData2 = cbind(uniqueRow,meanOut)

# set variable names
colnames(tidyData2) <- colnames(tidyData1)
rownames(tidyData2) <- 1:Nu

# write out the data frame
# data can be read back into r with the command: read.table("tidyData.txt",header = TRUE)
write.table(tidyData2,"tidyDataSummary.txt",row.names = FALSE)

# b<-as.matrix(colnames(tidyData2))


