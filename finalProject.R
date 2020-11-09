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
#retrieves everything from the dataset for the rows similar to the number 
#retrieve from above
iris[idx, ]

#Gives the overall summary of the iris data set with mean, median etc
summary(iris)

quantile(iris$Sepal.Length)
