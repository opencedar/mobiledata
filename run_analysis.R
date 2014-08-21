#if you'd like to download the data directly, start here.

#set your wd (to whatever you'd like)
setwd("c:/Users/Andy/Desktop/Coursera/Getting_data")
#create a temporary file to hold the .ZIP archive
temp <- tempfile()
#download the file to the temporary area
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
#unzip the file to your working directory
unzip(temp)

#If you already have the data, start here

#the below script reads in all of the data we need from the unzipped directory.

temp <- read.table("UCI HAR Dataset/features.txt")
features <- temp[,2]
temp <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels <- temp[,2]
temp <- read.table("UCI HAR Dataset/train/y_train.txt")
training_y <- temp[,1]
temp <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_subject <- temp[,1]
training_x <- read.table("UCI HAR Dataset/train/X_train.txt")
temp <- read.table("UCI HAR Dataset/test/y_test.txt")
test_y <- temp[,1]
temp <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_subject <- temp[,1]
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
rm(temp)


#merge training and test sets
master_df <- rbind(training_x, test_x)
#add the colnames (features vector)
colnames(master_df) <- features

#look for the strings you want in the colnames (features)
#first create a text vector of the features you desire

string_search <- c("mean()", "std()")

#then loop through it finding the positions and creating an index vector
positions <- vector()

for(i in 1:length(string_search)) {
  positions <- c(positions, grep(string_search[i], colnames(master_df)))
  
}

#Now filter out the columns you don't want, and save as a new dataframe, sub_df

sub_df <- master_df[,positions]

#create activity vector, label it
activity <- factor(c(training_y, test_y), labels = activity_labels)
#create subject vector
subject <- factor(c(train_subject, test_subject))
#bind these to the master data set
sub_df <- cbind(subject, activity, sub_df)

#now aggregate the remaining columns by subject and activity, and use mean() as the aggregation function. Name the new dataframe agg_df.

agg_df <- aggregate(. ~ subject + activity, FUN = mean, data=sub_df)

#writes the aggregated table out into the wd
write.table(agg_df, row.names = FALSE, "aggregated_data.txt")

