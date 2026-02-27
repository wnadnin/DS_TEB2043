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
