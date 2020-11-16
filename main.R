#=============================================================================
#TITLE: Final Project- Regression
#AUTHORS: CYRUS RAJ GAUTAM,
#=============================================================================
#
#
# show which version of R we are using for reproducibility
R.version.string
#  we used : "R version 4.0.3 (2020-10-10)"
#
# =============================================================================
# NOTES
# • 
# • where we got the data from
# • title, authors, date of the last update
#
#
# =============================================================================
# --- global variables ---
# we indicate variable that is static and should remain the same throughout the
# project

setwd('C:/Users/F.R.I.E.N.D.S/Desktop/Data Analysis course/Data Analysis/Final Project')
wk.dir <- getwd()

#load the datasets that we will use:
#Loading the data of Obesity rate and Fast Foood Restaurant

# =============================================================================


#===============================================================================
#Installing various packages to use in our program.
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

#=============================================================================
# --- folder management ---

# names of project folders ("figures", "data.raw","data.clean","results")
# store names of the folders in an object
folder.names <- c("1.data.raw","2.data.clean", "3.results",
                  "4.figures","5.scripts")

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
path.scripts <- paste(wk.dir, "/", folder.names[5], "/", sep = "")
# ==============================================================================
# --- run scripts ---


source(paste(wk.dir,  "/" ,"5.scripts", "/", "cleaning.data.R",
             sep = ""))


source(paste (wk.dir, "/", "5.scripts", "/", 
              "visualizing,regression.R", 
              sep = ""))


source(paste (wk.dir, "/", "5.scripts", "/", 
              "visualizing.decisiontree.R", 
              sep = ""))


source(paste (wk.dir, "/", "5.scripts", "/", 
              "visualizing.randomforest.R",
              sep = ""))

source(paste (wk.dir, "/", "5.scripts", "/", 
              "visualizing.clusteringdata.R",
              sep = ""))

# ==== end =====================================================================
#===============================================================================
#===============================================================================

