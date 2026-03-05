install.packages("readxl") 
any(grepl("readxl",installed.packages())) 
library(readxl) 

getwd() 
setwd('C:/Users/wnadn/Documents/DS_TEB2043/DS_Lab7')
list.files()

titanic <- read.csv("titanic.csv") 
View(titanic) 

sum(is.na(titanic)) 
which(is.na(titanic))

print(sapply(titanic, function(x) sum(is.na(x)))) 

dim(titanic) 
titanic_cleaned = na.omit(titanic)
dim(titanic_cleaned)

install.packages("dplyr")
library(dplyr)

colnames(titanic_cleaned)

print(filter(titanic_cleaned,Sex == 'female')) 
print(filter(titanic_cleaned,Fare > 500))

titanic_cleaned %>% filter(Sex == 'female', Fare > 500)

# Sort by ascending order 
titanic_sortbyfare = arrange(titanic_cleaned, Fare) 
# Sort by descending order 
titanic_sortbyfare = arrange(titanic_cleaned, desc(Fare)) 

write.csv(titanic_sortbyfare, "titanic_sortbyfare.csv") 