library(dplyr)
library(data.table)
train <- read.table ("./train/X_train.txt")
var <- as.list( read.table( "./features.txt"))
var <- var$V2
var <- as.character (var)
train1 <- setnames (train, var)
train_label = read.table ("./train/y_train.txt")
subj_train = read.table("./train/subject_train.txt")
train1 <- data.frame(train,train_label, subj_train)

test <- read.table ("./test/X_test.txt")
var <- as.list( read.table( "./features.txt"))
var <- var$V2
var <- as.character (var)
test1 <- setnames (test, var)
test_label = read.table("./test/Y_test.txt")
subj_test = read.table ("./test/subject_test.txt")
test1 <- data.frame(test,test_label, subj_test) 
# test_label = "V1.1" , subj_test = "V1.2"
#this code will merge the training and the test dataset
mydata <- rbind (train1, test1)

# Uses descriptive activity names to name the activities in the data set
act <- as.list(read.table( "./activity_labels.txt"))
act <- act$V2
act <- as.character (act)
act_label <- factor(mydata$V1.1, levels = c(1,2,3,4,5,6),labels = as.list(act))
mydata <- mutate (mydata, V1.1 = act_label)
#rename activity and subject variables
col <- setnames(mydata, "V1.1", "activity")
mydata <- setnames(col, "V1", "subject")
samsungdata <- select(mydata,contains("activity"),contains("subject"),  contains("mean"), contains("std"))
samsungdata <- arrange (samsungdata, activity, subject)
