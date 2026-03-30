data(mtcars)

# choose numeric column
mydata <- mtcars$mpg
print(mydata)

scaled_data1 <- log(mydata)
print(scaled_data1)

scaled_data2 <- as.data.frame(scale(mydata))
print(scaled_data2)

install.packages("caret")
library(caret)

minmax <- preProcess(as.data.frame(mydata), method = c("range"))
scaled_data3 <- predict(minmax, as.data.frame(mydata))

print(scaled_data3)