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
head(bodyfat)
bodyfat
attributes(bodyfat)



set.seed(1234)
ind <- sample(2 , nrow(bodyfat), replace = TRUE, prob = c(0.7, 0.3))
bodyfat.train <- bodyfat[ind==1, ]
bodyfat.test <- bodyfat[ind==2,]
# Using different library to make decision tree
library(rpart)
library(rpart.plot)
# Create a formula for DEXfat. In this formula we say that age, waistcirc, hipcirc, elbowbreadth and kneebreadth
# is our independent variable and DEXfat is our target variable.
myFormula <- DEXfat ~age + waistcirc + hipcirc + elbowbreadth + kneebreadth
myFormula

# Using the rpart function to creat a deciion tree. In this rpart function
# the formula is fed and the formula is ran through the our training data
# using that training data it forms the tree.
bodyfat_rpart <- rpart(myFormula, data = bodyfat.train)
attributes(bodyfat_rpart)
#Plotting the decision tree that we made.
plot(bodyfat_rpart)
# Plotting the above decision tree more clearly
rpart.plot(bodyfat_rpart)
#Adding text to that tree
text(bodyfat_rpart)


#--------------------Still to learn--------------
# Same process as above done in a f

opt <- which.min(bodyfat_rpart$cptable[,'xerror'])
cp <- bodyfat_rpart$cptable[opt, 'CP']
bodyfat_prune <- prune(bodyfat_rpart, cp = cp)
plot(bodyfat_prune)
text(bodyfat_prune)
rpart.plot(bodyfat_prune)

DEXfat_pred <- predict(bodyfat_prune, newdata = bodyfat.test)
DEXfat_pred
xlim <- range(bodyfat$DEXfat)
plot(DEXfat_pred ~ DEXfat, data = bodyfat.test, xlab = 'Observed', ylab = 'Predicted', ylim = xlim, xlim = xlim)
#-------------------------------------------------

#-------------------------------------------------

# Divide iris data into 70, 30
ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.7, 0.3))
#seperate training data
trainData <- iris[ind == 1,]
# seperate testing data
testData <- iris[ind == 2,]
trainData
testData
install.packages('randomForest')
library(randomForest)
#Use the random Forest data and apply the formula Species~. to the training data
rf <- randomForest(Species~., data = trainData, ntree = 100, proximity = TRUE)
#Gives you the summary of the how the training data was utilized.
#or the result of the random forest
rf
attributes(rf)
#Plots the decrease in the error rate in our calculation
plot(rf)
#graph indicating which variable was more important for the test
importance(rf)

#Using the testing method from our the
irisPred <- predict(rf, newdata = testData)
irisPred
table(irisPred, testData$Species)
plot(margin(rf, testData$Species))
#---------------------Regression----------------------------
#create a year list from 2008 to 2010 and repeat it 4 times each
year <- rep(2008:2010, each = 4)
#Create a quarter list from 1 to 4 and repeat it  3 time
quarter <- rep(1:4, each = 3)

#Create a response variable with certain values
cpi <- c(162.2, 164.6, 166.5, 166.0, 166.2, 167.0, 168.6, 169.5, 
         171.0, 172.1, 173.3, 174.0)
#Plot the Cpi value 
plot(cpi, xaxt = 'n', ylab= 'CPI', xlab='')
#Create a x axis by assigning the year and quarter in the x axis as they
# are independent variable
axis(1, label = paste(year, quarter, sep = 'Q'), at = 1:12, las = 3)
# Find the correlation between the response and independet variable
cor(year, cpi)
cor(quarter, cpi)

#USe the linear model function to   
fit <- lm(cpi ~year+quarter)
#difference between observed values and fitted values 
fit$residuals

#With the model CPI is calculated as c0 + c1 *year + c2 *quarter
(cpi2011 <- fit $coefficients[[1]] + fit$coefficients[[2]]*2011+ fit$coefficients[[3]]*(1:4))

summary(fit)
plot(fit)

