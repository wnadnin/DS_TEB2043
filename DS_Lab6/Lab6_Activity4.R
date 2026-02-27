#Activity1
table1 <- data.frame(
  name = c("Anastasia", "Dima", "Michael", "Matthew", "Laura", "Kevin", "Jonas"),
  score = c(12.5, 9.0, 16.5, 12.0, 9.0, 8.0, 19.0),
  attempts = c(1, 3, 2, 3, 2, 1, 2)
)

print(table1)


#Activity2
table1$qualify <- c("yes","no", "yes", "no", "no", "no", "yes")

print(table1)


#Activity3
table1.newdata <- data.frame(
  name = c("Emily"),
  score = c(14.5),
  attempts = c(1),
  qualify = c("yes")
)

table1.finaldata <- rbind(table1,table1.newdata)
print(table1.finaldata)


#Activity4

# structure
str(table1.finaldata)

# summary
summary(table1.finaldata)

# number of rows and columns
nrow(table1.finaldata)
ncol(table1.finaldata)
dim(table1.finaldata)


# convert qualify column to factor to get frequency summary
table1.finaldata$qualify <- as.factor(table1.finaldata$qualify)

# summary after conversion
summary(table1.finaldata)

#Observation / Insight:

# The dataset contains 8 students and 4 variables (name, score, attempts, qualify).
# The average score is around 12–13.
# The highest score is 19.0 (Jonas).
# The lowest score is 8.0 (Kevin).
# After converting qualify into factor, it is observed that:
# 4 students qualified (yes)
# 4 students did not qualify (no).
# Students attempted between 1 to 3 times.
# Students with higher scores (above 14) tend to qualify.