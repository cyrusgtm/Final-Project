install.packages('TH.data')
library(TH.data)
TH.data::bodyfat
install.packages('xlsx')

#Load the iris library
library(xlsx)

#Create a frequency table of different iris Species
table(iris$Species)
iris

#Create a table for just the setosa species
setosa <- subset(iris, Species == 'setosa')
setosa

#Checking the dimension of the iris table. It returns the no, of rows and col.
dim(iris)

#Returns the column name
names(iris)

#Displays three column(column 1 to 3)
iris[1:3]

#First few rows of the table
head(iris)
#Last few rows of the table
tail(iris)

#draws a 5 random numbers from 1 to the number of rows in iris datset
idx <- sample(1:nrow(iris), 5)
idx
#retrieves everything from the dataset for the rows similar to the number 
#retrieve from above
iris[idx, ]

#Gives the overall summary of the iris data set with mean, median etc
summary(iris)

quantile(iris$Sepal.Length)


str(iris)
set.seed(1234)

#---------------------Creating a decision tree----------------------
# Splitting the iris data into training and testing data
# 70% is used for training and 30% is used for testing
# Sample variable assigns which row to test and which one to train
ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.7, 0.3 ))
ind


# Extracting the training data assigned from above
trainData <- iris[ind == 1, ]
trainData

# Extracting the testing data assigned from above
testData <- iris [ind == 2, ]
testData

install.packages('party')
library(party)
# Specifying Species as a target variable and all the others as independent 
# variables.
myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

# Building a decision tree to find out different the target variable usign the independent
# ones. 
iris_ctree <- ctree(myFormula, data = trainData)
iris_ctree
# Visualizing the decision tree.
plot(iris_ctree)

# Using the decision tree it printed out the prediction for different varuables
predict(iris_ctree)
table(predict(iris_ctree), trainData$Species)

testPred <- predict(iris_ctree, newdata = testData) 
table(testPred, testData$Species)


#---------------------New package
a <- data('bodyfat', package = 'TH.data')
dim(bodyfat)
bodyfat
attributes(bodyfat)
