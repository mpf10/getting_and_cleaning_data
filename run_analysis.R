##### 1 Merge training and test data set

##reading the dataset from the working directory
#for column names
features <- read.table("features.txt",header=FALSE); 
activity <- read.table("activity_labels.txt",header=TRUE,col.names=c('id','activity')); 

#train data
xtrain <- read.table("train/X_train.txt",header=TRUE,col.names=features[,2])
ytrain <- read.table("train/y_train.txt",header=TRUE,col.names='activityid')
subj_train <- read.table("train/subject_train.txt",header=TRUE,col.names='subjectid')

##merging train data
train <- cbind(subj_train,ytrain,xtrain)

#test data
xtest <- read.table("test/X_test.txt",header=TRUE,col.names=features[,2])
ytest <- read.table("test/y_test.txt",header=TRUE,col.names='activityid')
subj_test <- read.table("test/subject_test.txt",header=TRUE,col.names='subjectid')

##merging test data
test <- cbind(subj_test,ytest,xtest)

##merging train and test data
finaldata <- rbind(train,test)

##### 2 Extracts only the measurements on the mean and standard deviation for each measurement
mu_sd <- finaldata[, grepl("mean",names(finaldata))|grepl("std",names(finaldata))]
mean_sd <- cbind(finaldata[,1:2] , mu_sd)

##### 3 Uses descriptive activity names to name the activities in the data set
act <- merge(mean_sd,activity,by.x='activityid',by.y='id')

#re-arranging columns and removing the activityid
act2 <- act[, c(2,82, 3:81)]

##### 4 Appropriately labels the data set with descriptive variable names.
colname <- names(act2)
for (i in 1:length(colname)) 
{
  colname[i] = gsub("\()","",colname[i])
}
names(act2) <- colname
names(act2)

##### 5 From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject

library(plyr)
tidy_data <- ddply(act2, c('subjectid', 'activity'), numcolwise(mean))

#exporting the file
write.table(tidy_data, "tidy.txt", row.names = FALSE)
