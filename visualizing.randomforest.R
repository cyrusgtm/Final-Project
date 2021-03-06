#=============================================================================
# CREATING AND VISUALIZING RANDOM FOREST
#=============================================================================
# Loading Penguins data
penguins <- read.csv(paste(path.data.clean, 'clean.penguin.table.csv',
                           sep = ''))

#Creating new table with different columnnames
newPenguins <- data.frame(Species = penguins$Species, 
                          Culmin.Length = penguins$Culmin.Length.mm,
                          Culmin.Depth = penguins$Culmin.Depth.mm,
                          Flipper.Length = penguins$Flipper.Length.mm,
                          Body.Mass = penguins$Body.Mass.g)

# Shortening the species name
newPenguins$Species <- gsub(' .*', '', newPenguins$Species)
head(newPenguins)
# You can use the number inside the bracklet to replicate
# my result.
set.seed(123)

#-----------------------------------------------------------------------------
# Splitting data
#-----------------------------------------------------------------------------

#Splitting the penguin data into 1s and 2s to later seperate
# it into training and testing data
# In this sepration I have divided the 100 % of my data randomly into 
# 70% and 30% using the prob function. That means 70% of the 
# penguin data will be labeled 1 and the other will be labeled
# 2.
penguinSeperation <- sample(2, nrow(newPenguins), replace = TRUE,
                            prob = c(0.7, 0.3))

# Setting training data. Training data extracts all the columns from
# the penguin data that were labeled 1 in the above seperation
randomTrainData <- newPenguins[penguinSeperation == 1, ]
length(randomTrainData$Species)
# Setting testing data. Testing data extracts all the columns from
# the penguin data that were labeled 2 in the penguinSeperation
randomTestData <- newPenguins[penguinSeperation == 2, ]
randomTestData


#-----------------------------------------------------------------------------
#Creating random forest
#-----------------------------------------------------------------------------

#----------------For training data-------
# Creating a formula with response and explanatory variable
myFormula <- factor(Species)~Culmin.Length + Culmin.Depth + Flipper.Length + Body.Mass
# Using the fomula to create a random forest
randomForestAlgorithm <- randomForest(myFormula, data = randomTrainData, 
                  ntree = 100, proximity = TRUE)

# Checking how the accuracy of the random forest algorithm
randomForestPredictTrainingdata <- randomForestAlgorithm$confusion
# The accuracy is given as:
#          Adelie Chinstrap  Gentoo class.error
#Adelie       104         2      0  0.01886792
#Chinstrap      3        51      0  0.0537037004
#Gentoo         0         1     83  0.01190476

write.csv(randomForestPredictTrainingdata, paste(path.results, 'Random Forest Train Data Prediction.csv', sep = ''))

# This table infers that 102 Adelie species were correctly
# categorized as Adelie, but 3 Chinstraps were categorized
# as Adelie using the Random forest algorithm. Similarly, 
# 51 chinstraps were correctly categorized whereas 2 adelie
# was categorized incorrectly as Chinstrap and lastly 83  
# gentoo were categorized correctly and 1 incorrectly.
# All these errors were calculted in the class.error column.

# Creating pdf for the error graph
pdf(paste (path.fig, 'Error Random Forest.pdf', sep= ''))
# Dividing the graph into different rows and column and
# setting the width
layout(matrix(c(1,2),nrow=1),
       width=c(4,1)) 
par(mar=c(5,4,4,0)) #No margin on the right side
# Plotting out the random forest which gives us graph of 
# how the error rate decreased while classifying different
# penguins into different categories using the explanatory
# variables. 
plot(randomForestAlgorithm)
par(mar=c(5,0,4,2)) #No margin on the left side
plot(c(0,1),type="n", axes=F, xlab="", ylab="")
# Creating a legend in the graph
legend("top", colnames(randomForestAlgorithm$err.rate),col=1:4,cex=0.6,fill=1:4)
dev.off()

# Finding out which variable was the most important while
# categorizing the penguins.
importance(randomForestAlgorithm)
#-----------------------------------------------------


#-----------------------------------For test data----------
# Using the training data and the random forest algorithm
# from above to predict the species of our testing data.
predictTestData <- predict(randomForestAlgorithm, randomTestData,
                           ntree = 100, replace = TRUE)
# Checking the prediction
predictTestData

# Analysing the prediction by comparing the prediction with
# the real category.
randomForestPredictTestdata <- table(predictTestData, randomTestData$Species)
write.csv(randomForestPredictTestdata,  paste(path.results, 'Prediction Random Forest Testdata.csv',
                sep = ''))
#predict     Adelie Chinstrap Gentoo
#Adelie        44         1      0
#Chinstrap      1        13      0
#Gentoo         0         0     39

# From the above table we can see our algrithm successfully
# categorized 44 Adelie correctly whereas it categorized
# 1 Chinstrap incorrectly. 13 chinstrap were correctly categorized
# and 1 Adelie was wrongly categorized. All the Gentoo was
# correctly categorized.
par(mfrow = c(1,1))

# Plotting the graph showing the result of out randomforest
# algorithm
plot(margin(randomForestAlgorithm, randomTestData$Species))
#--------------------------------------------------------------------
