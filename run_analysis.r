##Getting data, project R-code
## read the training data

## read features, remove those symbols

folder <- paste(getwd(), "/UCI HAR Dataset", sep = "")
Variables <- read.table(paste(folder, "/features.txt", sep = ""))
Var <- Variables$V2
Var <- gsub("-", "", Var)
Var <- gsub("[(]", "", Var)
Var <- gsub("[)]", "", Var)

## read training set data, rename data

trainx <- read.table(paste(folder, "/train/X_train.txt", sep = ""))
names(trainx) <- Var

trainy <- read.table(paste(folder, "/train/y_train.txt", sep = ""))
names(trainy) <- "activity"


trainsub <- read.table(paste(folder, "/train/subject_train.txt", sep = ""))
names(trainsub) <- "subject"

## combine data 

train <- cbind(trainsub, trainy, trainx)

## test set
testx <- read.table(paste(folder, "/test/X_test.txt", sep = ""))
names(testx) <- Var
testy <- read.table(paste(folder, "/test/y_test.txt", sep = ""))
names(testy) <- "activity"
testsub <- read.table(paste(folder, "/test/subject_test.txt", sep = ""))
names(testsub) <- "subject"
test <- cbind(testsub, testy, testx)

##2947  563


all <- rbind(test, train) ##10299 563
names <- names(all)
all1 <- all[, grep("mean", (names))]
meandata <- select(all1, -contains("Freq"))
stddata <- all[, grep("std", (names))]  ##10299, 33

new_data <- cbind(all[,c(1,2)], meandata, stddata)  ##10299, 68

##Get activity_labels
actlab <- read.table(paste(folder, "/activity_labels.txt", sep=""))

##Replace the number with activity_labels
new2 <- data.frame()
new2 <- NULL
for (i in 1:nrow(actlab)) {act <- filter(new_data, activity == actlab$V1[i])
                           act <- mutate(act, activity = actlab$V2[i])
                           new2 <- rbind(new2, act)} 


##new2 is the activity named data

##Step 4, calculate mean of each variables by each subject and each activity.

##Get a new data frame

new_set <- data.frame(NULL)

## loop through all 30 subjects. 
##There must be many better ways to do this. 
##Given my knowledge and time limitation, this is something I can do to finish it by deadline. 

for (i in 1:30) {
  
## Get data set by each subject
  sub1 <- filter(new2, subject == i)
 
  ## calculate mean data by each activity
  md <-data.frame(NULL)
  ## 6 activities
  for (j in 1:6) {sub1act <- filter(sub1, activity == actlab$V2[j])
                  md <- rbind(md, apply(sub1act[,c(3:68)], 2, mean))
  }
  ## combine the data of each subject and add names
  sub1new <- cbind(i, actlab$V2, md)
  names(sub1new) <- names(new2)
  ## add data to new tidy data set
  new_set <- rbind(new_set, sub1new)
}


##write.table() using row.name=FALSE 
write.table(new_set, "tidydata_set.txt", row.name=FALSE)
## dim(new_set) is 180, 68
