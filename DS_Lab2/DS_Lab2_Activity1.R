# Input weight (kg) and height (m)
weight <- as.numeric(readline(prompt = "Enter your weight (kg): "))
height <- as.numeric(readline(prompt = "Enter your height (m): "))

# Calculate BMI
bmi <- weight / (height^2)

# Logical conditions
underweight <- bmi <= 18.4
normal <- bmi >= 18.5 & bmi <= 24.9
overweight <- bmi >= 25.0 & bmi <= 39.9
obese <- bmi >= 40.0

# Display output
cat("Underweight:", underweight, "\n")
cat("Normal:", normal, "\n")
cat("Overweight:", overweight, "\n")
cat("Obese:", obese, "\n")

