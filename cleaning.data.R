#=============================================================================
#Cleaning Happiness Score data 
#=============================================================================

# loading the countries data
countries <- read.csv(paste (path.data.raw, 'countries 2017.csv',
                             sep = ''))

# checking the column names of the table
names(countries)

# creating a table by extracting columns relavent for the 
# analysis and visualization of our response variable happiness score
mainTable <- data.frame(countries$Country, countries$Happiness.Score,
                        countries$Economy..GDP.per.Capita., 
                        countries$Health..Life.Expectancy., 
                        countries$Trust..Government.Corruption.)

# assigning names to the columns
colnames(mainTable) <- c('Countries', 'Happiness.Score', 
                         'GDP.Per.Capita', 'Life.Expectancy', 
                         'Corruption') 

# Ommiting all the rows containing NA values
mainTable <- na.omit(mainTable)

# Creating a csv file containing the cleaned data set. 
write.csv(mainTable, paste(path.data.clean, 
                'countries.happinessscore.cleaned.csv',
                sep = ""), row.names = FALSE)

# checking the last items from the main table
tail(mainTable)
tail(mainTable$GDP.Per.Capita)




#============================================================================
# Cleaning penguins data
#============================================================================
# Loading penguins data
penguins = read.csv(paste(path.data.raw, 'penguins.raw.csv', 
                          sep = ''))

# Creating a table with important column names
mainPenguinsTable <- data.frame(penguins$Species, 
                                penguins$Culmen.Length..mm.,
                                penguins$Culmen.Depth..mm., 
                                penguins$Flipper.Length..mm., 
                                penguins$Body.Mass..g., penguins$Sex)

# Giving names to the column name
colnames(mainPenguinsTable) <- c('Species', 'Culmin.Length.mm',
                                 'Culmin.Depth.mm','Flipper.Length.mm',
                                 'Body.Mass.g', 'Sex')

# Ommiting the rows with NA values in it
mainPenguinsTable <- na.omit(mainPenguinsTable)

# Creating a clean file and saving it in the clean data file
write.csv(mainPenguinsTable, paste(path.data.clean, 
                                   'clean.penguin.table.csv',
                                   sep = ''), row.names = FALSE)

#===============================================================================
