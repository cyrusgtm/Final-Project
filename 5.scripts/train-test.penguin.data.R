penguins <- read.csv(paste(path.data.clean, 'clean.penguin.table.csv',
                           sep = ''))

head(penguins)
# You can use the number inside the bracklet to replicate
# my result.
set.seed(123)

#Splitting the penguin data into 1s and 2s to later seperate
# it into training and testing data
# In this sepration I have divided the 100 % of my data randomly into 
# 70% and 30% using the prob function. That means 70% of the 
# penguin data will be labeled 1 and the other will be labeled
# 2.
penguinSeperation <- sample(2, nrow(penguins), replace = TRUE,
                            prob = c(0.7, 0.3))

# Setting training data. Training data extracts all the columns from
# the penguin data that were labeled 1 in the above seperation
trainData <- penguins[penguinSeperation ==1, ]

# Setting testing data. Testing data extracts all the columns from
# the penguin data that were labeled 2 in the penguinSeperation
testData <- penguins[penguinSeperation == 2, ]
testData
