setwd("~/datasciencecoursera/GettingAndCleaningData/CleaningDataProject")
labels <- read.table("activity_labels.txt", sep = " ", col.names = c("activity", "label"), stringsAsFactors = FALSE)
features <- read.table("features.txt", sep = "", col.names = c("feature", "description"), 
                       stringsAsFactors = FALSE, colClasses = "character")
meansd <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 
            253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)
featureDat <- data.table(features[meansd, ])
subjectTest <- read.table("subject_test.txt", sep = "", col.names = "subject")
subjectTest$group <- apply(subjectTest, 1, function(row) 1)
subjectTrain <- read.table("subject_train.txt", sep = "", col.names = "subject")
subjectTrain$group <- apply(subjectTrain, 1, function(row) 2)
xTest <- read.table("X_test.txt", sep = "", col.names = features$description)
xTrain <- read.table("X_train.txt", sep = "", col.names = features$description)
yTest <- read.table("Y_test.txt", sep = "", col.names = "activity")
yTrain <- read.table("Y_train.txt", sep = "", col.names = "activity")
data <- rbind(xTest[meansd], xTrain[meansd])
activityID <- rbind(yTest, yTrain)
subjectID <- rbind(subjectTest, subjectTrain)
work <- cbind(subjectID, activityID, data)
analysis <- merge(labels, work, by.x = "activity", by.y = "activity", all = TRUE)

form <- melt(analysis, id = c("subject", "label"))
motion <- dcast(form, subject + label ~ variable, mean)