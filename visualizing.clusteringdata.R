#=============================================================================
# CREATING AND VISUALIZING CLUSTERS
#=============================================================================

# Load clean penguins data
penguins <- read.csv(paste(path.data.clean, 'clean.penguin.table.csv',
                           sep = ''))

# Creating new variable
penguinsWithNoSpecies <- penguins

# Removing the Species from the table
penguinsWithNoSpecies$Species <- NULL

# Removing the Sex column from the table
penguinsWithNoSpecies$Sex <- NULL

# Abbreviating penguins species name by deleting everything
# after the first word in Species column
penguins$Species <- gsub(' .*', '', penguins$Species)


#-----------------------------------------------------------------------------
# k means clustering
#-----------------------------------------------------------------------------

# Using the kmeans clustering method to distribute
# all the data into 3 different categories. 
clustering <- kmeans(penguinsWithNoSpecies, 3)
# checking the cluster
clustering
# Comparing the cluster with the real data
table(clustering$cluster, penguins$Species)

#Creating a pdf 
pdf(paste(path.fig, 'Clustering Penguins Kmeans graph.pdf',
          sep = ''))

# Plotting all the clusters with respect to 
# the dependence to different variable
plot(penguinsWithNoSpecies[c('Culmin.Length.mm', 'Culmin.Depth.mm', 
                             'Flipper.Length.mm', 'Body.Mass.g')], 
     col = clustering$cluster)
dev.off()


#-----------------------------------------------------------------------------
#PAM method of clustering
#-----------------------------------------------------------------------------

# Another way of clustering data. It also clusters the data
# for into 3 categorizes.
pam.result <- pam(penguinsWithNoSpecies, 3)

# Checking the result of the cluster.
table(pam.result$clustering, penguins$Species)

#creating a pdf
pdf(paste(path.fig, 'Clustering Penguins PAM graph.pdf',
          sep = ''))
#Plotting the graph showing the visualization of different
# categories and how they were categorized.
layout(matrix(c(1, 2), 1, 2))
plot(pam.result)
dev.off()
#-----------------------------------------------------------------------------
