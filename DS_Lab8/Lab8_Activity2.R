data(mtcars)
head(mtcars, 10)
View(mtcars)

colnames(mtcars)

boxplot(mpg ~ cyl,
        data = mtcars,
        xlab = "Number of Cylinders",
        ylab = "Miles Per Gallon (mpg)",
        main = "Fuel Efficiency by Number of Cylinders",
        col = c("lightgreen", "lightblue", "lightpink"))

plot(x = mtcars$wt,
     y = mtcars$mpg,
     xlab = "Weight",
     ylab = "Miles Per Gallon (mpg)",
     main = "Relationship Between Car Weight and Mileage",
     pch = 19,
     col = "blue")

abline(lm(mpg ~ wt, data = mtcars), col = "red", lwd = 2)