#=============================================================
# VISUALIZING DIFFERENT REGRESSION
#=============================================================

# Loading the happiness score  table from the clean data files
mainTable <- read.csv(paste(path.data.clean,
                            'countries.happinessscore.cleaned.csv',
                            sep = ''))

#*****************************************
#------------------Simple Linear Regression---------------------

# Plotting a happinessScore vs GDPPerCapita graph where happiness 
# score is a response variable and GDP per capita is an explanatory 
# variable Also, creating a line to fit our linear model.

# creating a pdf
pdf(paste(path.fig , 'HappinessScore VS GDPPerCapita.pdf', sep =""))
# plotting the graph
incomeHappinessGraph <- ggplot(mainTable, aes(x=GDP.Per.Capita, 
                                    y=Happiness.Score)) +
  geom_point()
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

# creating a pdf
pdf(paste(path.fig , 'HappinessScore VS LifeExpectancy.pdf', sep =""))
# plotting the graph
leHappinessGraph <- ggplot(mainTable, aes(x=Life.Expectancy, 
                                              y=Happiness.Score)) +
  geom_point()
# creating a linear model and a line to fit the linear model
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
#---------------------------------------------------------------------


#******************************************************
#----------------------Multiple Regression------------------------

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


# Comparing the response variable with explanatory variable in the same
# graph. The range of the x-values of all the graphs are same
pdf(paste(path.fig, 'Comparing all regression.pdf', sep =""))
par(mfrow = c(3, 1))
plot(Happiness.Score ~ Life.Expectancy + GDP.Per.Capita + Corruption, 
     data = mainTable, xlim = c(0.0, 1.8))
par(mfrow = c(1, 1))
dev.off


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
  
#-----------------------------------------------------------------  