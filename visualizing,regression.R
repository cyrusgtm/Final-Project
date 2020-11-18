#=============================================================================
# VISUALIZING DIFFERENT REGRESSION
#=============================================================================

# Loading the happiness score  table from the clean data files
mainTable <- read.csv(paste(path.data.clean,
                            'countries.happinessscore.cleaned.csv',
                            sep = ''))
mainTable$Happiness.Score
# Creating histogram of happiness score to confirm happiness score
# is normally distributed
pdf(paste(path.fig, 'Normally distribution check happinessScore.pdf', 
          sep = ''))
hist(mainTable$Happiness.Score, main = 'Happiness Score Normality Check',
     xlab = 'Happiness Score')
dev.off()

#-----------------------------------------------------------------------------
#Simple Linear Regression
#-----------------------------------------------------------------------------

# Plotting a happinessScore vs GDPPerCapita graph where happiness 
# score is a response variable and GDP per capita is an explanatory 
# variable Also, creating a line to fit our linear model.


# plotting the graph
incomeHappinessGraph <- ggplot(mainTable, aes(x=GDP.Per.Capita, 
                                    y=Happiness.Score)) +
  geom_point()
# creating a pdf
pdf(paste(path.fig , 'HappinessScore VS GDP.Per.Capita.pdf', sep =""))
# creating a linear model and a line to fit the model
incomeHappinessLinearModel <- incomeHappinessGraph  + 
  geom_smooth(method="lm",col="black")
# Adding the linear equation fitting the line 
incomeHappinessLinearModel <- incomeHappinessLinearModel +
  stat_regline_equation() + theme_bw() + 
  theme(
    plot.background = element_blank(),  #making the backround blank
    panel.grid.major = element_blank(), #Making the grid blank
    panel.grid.minor = element_blank(),
    panel.border = element_blank()      #Making the border blank
  ) + 
  theme(axis.line = element_line(color = 'black')) #Creating axis line
incomeHappinessLinearModel
dev.off()


# Plotting a happinessScore vs Life Expectancy graph where happiness 
# score is a response variable and Life Expectancy is an explanatory 
# variable Also, creating a line to fit our linear model.


# plotting the graph
leHappinessGraph <- ggplot(mainTable, aes(x=Life.Expectancy, 
                                              y=Happiness.Score)) +
  geom_point()
leHappinessGraph
# creating a linear model and a line to fit the linear model
# creating a pdf
pdf(paste(path.fig , 'HappinessScore VS LifeExpectancy.pdf', sep =""))
leHappinessLinearModel <- leHappinessGraph  + 
  geom_smooth(method="lm",col="black")
# creating equation of the line fitting the linear model
leHappinessLinearModel <- leHappinessLinearModel +
  stat_regline_equation() + theme_bw() + 
  theme(
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  ) + 
  theme(axis.line = element_line(color = 'black'))
leHappinessLinearModel
dev.off()


# Plotting a happinessScore vs Corruption graph where happiness 
# score is a response variable and Corruption is an explanatory 
# variable Also, creating a line to fit our linear model.

# creating a pdf
pdf(paste(path.fig , 'HappinessScore VS Corruption.pdf', sep ="")) 
# plotting the graph
corruptHappinessGraph <- ggplot(mainTable, aes(x=Corruption, 
                                          y=Happiness.Score)) +
  geom_point()
# creating a linear model
corruptHappinessLinearModel <- corruptHappinessGraph  + 
  geom_smooth(method="lm",col="black")
# creating equation of the line fitting the linear model
corruptHappinessLinearModel <- corruptHappinessLinearModel +
  stat_regline_equation() + theme_bw() + 
  theme(
    plot.background = element_blank(),  #making the backround blank
    panel.grid.major = element_blank(), #Making the grid blank
    panel.grid.minor = element_blank(),
    panel.border = element_blank()      #Making the border blank
  ) + 
  theme(axis.line = element_line(color = 'black')) #Creating axis line
corruptHappinessLinearModel
dev.off()
#-----------------------------------------------------------------------------


#-----------------------------------------------------------------------------
#Multiple Linear Regression
#-----------------------------------------------------------------------------

# Creating multiple regression graph.
hapinessMultiRegression <- lm(Happiness.Score ~ GDP.Per.Capita + 
                                Life.Expectancy + Corruption, 
                              data = mainTable)

# Creating pdf for the mutiple regression plot.
pdf(paste(path.fig, 'Multiple Regression plot.pdf', sep = ''))
par(mfrow = c(2, 2))
plot(hapinessMultiRegression)
par(mfrow = c(1, 1))
dev.off()


# Showing the result of the multiple regression. It describes  which variable
# are more important for the regression, calculates the min, median, 
# calculates the standard Error, t value etc using the provided data.
summary(hapinessMultiRegression)

# Finding the correlation between different variables
cor(mainTable$Happiness.Score, mainTable$GDP.Per.Capita)
cor(mainTable$Happiness.Score, mainTable$Corruption)
cor(mainTable$Happiness.Score, mainTable$Life.Expectancy)


# Creating pdf
pdf(paste(path.fig, 'Correlation between all variables.pdf', sep =""))
# Plotting the graph showing the correlation of all the variable
# from the main table with each other
plot(mainTable)
dev.off()



# creating pdf
pdf(paste(path.fig, 'Comparing HappinessScore and GDP with high-low Corruption.pdf', 
          sep =""))
# Creating a graph comparing the GDP.per.Capita and Happiness Score along with
# visualizing how high and low corruption influence both of these variables.
mainTable %>%
  mutate(highCorruption = ifelse(Corruption > median(mainTable$Corruption), 
                                 'Yes', 'No')) %>%
  ggplot(aes(x = GDP.Per.Capita, y = Happiness.Score, color = highCorruption))+
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)
dev.off()


#creating pdf
pdf(paste(path.fig, 'Comparing HappinessScore and GDP with high-low LifeExpectancy.pdf', 
          sep =""))
# Creating a graph comparing the GDP.per.Capita and Happiness Score along with
# visualizing how high and low Life Expectancy influence both of these variables.
mainTable %>%
  mutate(highLifeExpectancy = ifelse(Life.Expectancy > median(mainTable$Life.Expectancy), 'Yes', 'No')) %>%
  ggplot(aes(x = GDP.Per.Capita, y = Happiness.Score, color = highLifeExpectancy))+
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)
dev.off()
  
#-----------------------------------------------------------------------------

