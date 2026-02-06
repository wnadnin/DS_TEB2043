# Get two strings from user
str1 <- readline(prompt = "Enter string 1: ")
str2 <- readline(prompt = "Enter string 2: ")

# Convert both strings to the same case
str1_lower <- tolower(str1)
str2_lower <- tolower(str2)

# Compare strings
result <- str1_lower == str2_lower

# Display result
cat("This program compare 2 strings. Both inputs are similar:", result, "\n")



