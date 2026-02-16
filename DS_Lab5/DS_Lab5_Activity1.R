#enter year
year_input <- readline(prompt = "Enter year: ")

#convert to numeric
year <- suppressWarnings(as.numeric(year_input))

#check if input is numeric
if (is.na(year)) {
  print("Please input numbers only.")
  
} else if (year != as.integer(year)) {
  print("Please input integer values only.")
  
} else {
  
  year <- as.integer(year)
  
  #leap year conditions
  if ((year %% 4 == 0 & year %% 100 != 0) | (year %% 400 == 0)) {
    print(paste(year, "is a leap year."))
  } else {
    print(paste(year, "is not a leap year."))
  }
}

