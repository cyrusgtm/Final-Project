countries <- read.csv(paste (path.data.raw, 'countries 2017.csv', sep = ''))
countries
mainTable <- data.frame(countries$Country, countries$Happiness.Score, countries$Economy..GDP.per.Capita., countries$Health..Life.Expectancy.)
colnames(mainTable) <- c('Countries', 'Happiness.Score', 'GDP.Per.Capita', 'Life.Expectancy') 

# Ommiting all the rows containing NA
mainTable <- na.omit(mainTable)

tail(mainTable)
tail(mainTable$GDP.Per.Capita)
summary(countries)
hist(mainTable$Happiness.Score)

pdf(paste(path.fig , 'HappinessScore VS GDPPerCapita.pdf', sep =""))
plot(Happiness.Score ~ GDP.Per.Capita, data = mainTable)
incomeHappinessLinearModel <- lm(Happiness.Score ~ GDP.Per.Capita , data = mainTable)
abline(incomeHappinessLinearModel)
dev.off()

plot(Happiness.Score ~ Life.Expectancy, data = mainTable)
leHappinessLinearModel <- lm(Happiness.Score ~ Life.Expectancy, data = mainTable)
abline(leHappinessLinearModel)

hapinessMultiRegression <- lm(Happiness.Score ~ GDP.Per.Capita + Life.Expectancy, data = mainTable)
par(mfrow = c(2, 2))
plot(hapinessMultiRegression)
par(mfrow = c(1, 1))

par(mfrow = c(2, 2))
plot(leHappinessLinearModel)
par(mfrow = c(1, 1))
