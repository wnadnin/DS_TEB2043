install.packages("dplyr")
library(dplyr)

getwd()

setwd("C:/Users/wnadn/Documents/DS_TEB2043/DS_Lab8")

list.files()

titanic <- read.csv("titanic.csv")
View(titanic)

sum(is.na(titanic))
which(is.na(titanic))
sapply(titanic, function(x) sum(is.na(x)))

titanic_cleaned <- na.omit(titanic)

dim(titanic)
dim(titanic_cleaned)

gender_survival <- titanic_cleaned %>%
  group_by(Sex) %>%
  summarise(
    Total = n(),
    Survived = sum(Survived),
    Survival_Rate = round((sum(Survived) / n()) * 100, 2)
  )

print(gender_survival)

barplot(gender_survival$Survival_Rate,
        names.arg = gender_survival$Sex,
        col = c("pink", "lightblue"),
        main = "Survival Rate by Gender",
        xlab = "Gender",
        ylab = "Survival Rate (%)",
        border = "black")

fare_survival <- titanic_cleaned %>%
  group_by(Survived) %>%
  summarise(
    Average_Fare = round(mean(Fare), 2),
    Passengers = n()
  )

print(fare_survival)

boxplot(Fare ~ Survived,
        data = titanic_cleaned,
        col = c("orange", "lightgreen"),
        names = c("Did Not Survive", "Survived"),
        main = "Fare Distribution by Survival Status",
        xlab = "Survival Status",
        ylab = "Fare")

boxplot(Fare ~ Survived,
        data = titanic_cleaned,
        col = c("orange", "lightgreen"),
        names = c("Did Not Survive", "Survived"),
        main = "Fare Distribution by Survival Status",
        xlab = "Survival Status",
        ylab = "Fare",
        outline = FALSE)