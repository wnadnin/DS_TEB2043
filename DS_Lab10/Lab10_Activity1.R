data(Theoph)
head(Theoph)
str(Theoph)
View(Theoph)

# linear regression model
model_theoph <- lm(Dose ~ Wt, data = Theoph)
print(model_theoph)
summary(model_theoph)

plot(Theoph$Wt, Theoph$Dose,
     main = "Linear Regression of Dose vs Weight (Theoph Dataset)",
     xlab = "Weight (kg)",
     ylab = "Dose (mg/kg)",
     pch = 16,
     col = "blue")

abline(model_theoph, col = "red", lwd = 2)

# prediction
new_weight <- data.frame(Wt = c(90, 95, 100))
predicted_dose <- predict(model_theoph, newdata = new_weight)

print(new_weight)
print(predicted_dose)

