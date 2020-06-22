
library(diets)
library(dplyr)

content <- nutrientContent(continent="", redpalmoil=0.5, orangesweetpot=0.2)
unique(content$tag)
table(content$unit)

#fortify works 
fort <- readRDS(system.file("ex/fortification.rds", package="diets"))
#fcontent <- fortify(content, fort)

consumption <- readRDS("C:/Users/jccaro/diets/FBS.rds")

consumption <- consumption[consumption$Element == "Food supply (kcal/capita/day)", c("ISO3", "Year", "Item", "Value")]
colnames(consumption) <- c("country", "year", "group", "value")

intake_total <- as.data.frame(array(NA, dim=c(0,10)))
colnames(intake_total) <- c(names(intake),"country","year")
consumption$ISO3num <- as.numeric(as.factor(consumption$country))

countries <- unique(consumption$ISO3num)
years <- unique(consumption$year)
for (i in countries){
  for (j in years) {
  FBS <- consumption[consumption$year == j & consumption$ISO3num == i, c("group", "value")]
  intake <- nutrientIntake(FBS, content)
  intake$country <- unique(consumption$country[consumption$year == j & consumption$ISO3num == i])
  intake$year <- unique(consumption$year[consumption$year == j & consumption$ISO3num == i])
  intake_total <- rbind(intake_total, intake, after = length(intake_total))
  }
}

