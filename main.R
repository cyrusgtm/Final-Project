#=============================================================================
#TITLE: Final Project- DATA MINING AND ITS TECHNIQUES 
#AUTHORS: CYRUS RAJ GAUTAM,
#=============================================================================
#
#
# show which version of R we are using for reproducibility
R.version.string
#  we used : "R version 4.0.3 (2020-10-10)"
#
#-----------------------------------------------------------------------------
# NOTES
# • 
# • where we got the data from
# • title, authors, date of the last update
#
#
#-----------------------------------------------------------------------------


#Installing various packages to use in our program.
install.packages("rstudioapi")
install.packages("broom")
install.packages("ggpubr")
install.packages('party')
install.packages('ggplot2')
install.packages('dplyr')
install.packages('rpart')
install.packages('rpart.plot')
install.packages('randomForest')
install.packages('fpc')
install.packages('cluster')


library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)
library(party)
library(rpart)
library(rpart.plot)
library(randomForest)
library(fpc)
library(cluster)
library(rstudioapi) 
#-----------------------------------------------------------------------------
# Setting your working directory correctly
#-----------------------------------------------------------------------------

# the following line is for getting the path of your current open file
current_path <- getActiveDocumentContext()$path 
current_path
# The next line set the working directory to the relevant one:
setwd(dirname(current_path ))
# you can make sure you are in the right directory
wk.dir <- getwd() 
wk.dir
#-----------------------------------------------------------------------------
# --- folder management ---

# names of project folders ("figures", "data.raw","data.clean","results")
# store names of the folders in an object
folder.names <- c("1.data.raw","2.data.clean", "3.results",
                  "4.figures")

# and make the folders if they don't exit yet. No need to understand this now
for(i in 1:length(folder.names)){ 
  if(file.exists(folder.names[i]) == FALSE){
    dir.create(folder.names[i])
  } 
}

# you need to store in an object the file path to these folders so we can 
# read from them and write to them.
#the raw.data folder should already have the data sets in it
path.data.raw <- paste(wk.dir, "/", folder.names[1], "/", sep = "")
path.data.clean <- paste(wk.dir, "/", folder.names[2], "/", sep = "")
path.results <- paste(wk.dir, "/", folder.names[3], "/", sep = "")
path.fig <- paste(wk.dir, "/", folder.names[4], "/", sep = "")
#-----------------------------------------------------------------------------
# --- run scripts ---

# This source saves graphs of different types of regression: Multiple linear
# and Simple Linear. 
source(paste (wk.dir, "/", 
              "visualizing,regression.R", 
              sep = ""))

# This source saves graph of the decision made using the penguin dataset.
source(paste (wk.dir, "/", 
              "visualizing.decisiontree.R", 
              sep = ""))

# This source saves graphs of the error graph, random forest graph and different
# table of prediction
source(paste (wk.dir, "/", 
              "visualizing.randomforest.R",
              sep = ""))

# This source saves graphs of different clustering techniques
source(paste (wk.dir, "/", 
              "visualizing.clusteringdata.R",
              sep = ""))

#-----------------------------------------------------------------------------


