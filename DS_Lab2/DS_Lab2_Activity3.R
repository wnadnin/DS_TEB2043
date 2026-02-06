# Get name and phone number from user
name <- readline(prompt = "Enter your name: ")
phone <- readline(prompt = "Enter your phone number: ")

# Convert name to uppercase
name_upper <- toupper(name)

# Extract phone number parts
first3 <- substr(phone, 1, 3)
last4 <- substr(phone, nchar(phone) - 3, nchar(phone))

# Display result
cat("Hi,", name_upper,
    ". A verification code has been sent to",
    first3, "-xxxxx", last4, "\n")
