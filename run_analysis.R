#####################################
## Coursera - Get and Clean Data   ##
## Aaron Williams                  ##
## Week 3 - Course Project         ##
#####################################


library(plyr)

######################################
# Step 1 - Merge the training and the test sets to create one data set

## Read in 3x training data sets
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Read in 3x test data sets
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")

# combine 2 'x' data sets
xdata <- rbind(xtrain, xtest)

# combine 2 'y' data sets
ydata <- rbind(ytrain, ytest)

# combine 2 'subject' data sets
subjectdata <- rbind(subjecttrain, subjecttest)

######################################
# Step 2 - Extract only the measurements on the mean and standard deviation for each measurement

# Read in the "features" data st
features <- read.table("UCI HAR Dataset/features.txt")

# List column numbers relating to mean and deviation
meanstdfeatures <- grep("-(mean|std)\\(\\)", features[, 2])

# Subset data based on list of column numbers
xdata <- xdata[, meanstdfeatures]

# correct the column names
names(xdata) <- features[meanstdfeatures, 2]

######################################
# Step 3 - Use descriptive activity names to name the activities in the data set

# Read in names data from activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Correct values to show activity
ydata[, 1] <- activities[ydata[, 1], 2]

# Apply activity to names
names(ydata) <- "activity"

######################################
# Step 4 - Appropriately label the data set with descriptive variable names

# Apply descriptive column name
names(subjectdata) <- "subject"

# Combine all the data into 1 data frame
alldata <- cbind(xdata, ydata, subjectdata)

######################################
# Step 5 - Create a second, independent tidy data set with the 
# average of each variable for each activity and each subject

# Create data frame of the average for each subject by activity
averages <- ddply(alldata, .(subject, activity), function(x) colMeans(x[, 1:66]))

# Write averages from previous step to text file
write.table(averages, "avgdata.txt", row.name=FALSE)