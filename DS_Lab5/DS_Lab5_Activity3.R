#user input
num_input <- readline(prompt = "Input an integer: ")

#convert to numeric
num <- suppressWarnings(as.numeric(num_input))

#validate input
if (is.na(num)) {
  
  print("Please input numbers only.")
  
} else if (num != as.integer(num) || num < 0) {
  
  print("Please input a positive integer only.")
  
} else {
  
  num <- as.integer(num)
  original_num <- num
  
  #convert number to digits
  digits <- strsplit(as.character(num), "")[[1]]
  digits <- as.numeric(digits)
  
  #count number of digits
  n <- length(digits)
  
  #compute Armstrong sum
  armstrong_sum <- sum(digits^n)
  
  #result
  if (armstrong_sum == original_num) {
    print(paste(original_num, "is an Armstrong number."))
  } else {
    print(paste(original_num, "is not an Armstrong number."))
  }
}
