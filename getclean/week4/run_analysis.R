library(data.table)

## PRELIMINARIES

# Set the path to the directory with the data
dataPath = "./Dataset"
# Set the path to the final output
fOut = "./result.txt"
# Path to nested directories
# They should not be changed
testPath = file.path(dataPath, "test")
trainPath = file.path(dataPath, "train")


# PART I

# Load training set
trainDT = fread(
    file.path(trainPath, "X_train.txt"),
    header=FALSE,
    sep=" "
)
# Load test set
testDT = fread(
    file.path(testPath, "X_test.txt"),
    header=FALSE,
    sep=" "
)
# Load the feature names
featDT = fread(
    file.path(dataPath, "features.txt"),
    sep=" ",
    header=FALSE,
    select=c(2),
    col.names=c("featurename")
)
# Rename column of the train/test sets
names(trainDT) = featDT$featurename
names(testDT) = featDT$featurename
# Merge them in a single data set
mergedDT = rbind(trainDT, testDT)


## PART II

# Find rows that have "std" or "mean" operation
ok = grep("[Ss]td|[Mm]ean", featDT$featurename)
# extract them
extractedDT = mergedDT[, ok, with=FALSE]


## PART III

# Load labels for the training set
trainLabels = fread(
    file.path(trainPath, "y_train.txt"),
    header=FALSE
)
# Load labels for the test set
testLabels = fread(
    file.path(testPath, "y_test.txt"),
    header=FALSE
)
# stack them together
allLabels = rbind(trainLabels, testLabels)
# Read the activity labels
activityLabels = fread(
    file.path(dataPath, "activity_labels.txt"),
    header=FALSE
)
# Create named labels by mapping the indexes with the name
map = function(x) activityLabels[[2]][x]
namedLabels = lapply(allLabels[[1]], map)


## PART IV

# Add one more column with the descriptive activity names
extractedDT$activity = as.character(namedLabels)


## PART V

# Load the training subject index
trainSubj = fread(
    file.path(trainPath, "subject_train.txt"),
    header=FALSE
)
# Load the test subject index
testSubj = fread(
    file.path(testPath, "subject_test.txt"),
    header=FALSE
)
# stack them together
allSubj = rbind(trainSubj, testSubj)
# Add one more column with the subject index
extractedDT$subject = allSubj
# Use data.table power:
tidy = extractedDT[, # all rows
            lapply(.SD, mean), # apply mean on every column
            by=.(activity, subject) # grouping by the pair(activity, subject)
       ]

# Write data to file as required by the submission process
write.table(tidy, fOut, row.names=FALSE)
