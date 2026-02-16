#enter integer
num_input <- readline(prompt = "Input an integer: ")

#convert to numeric
num <- suppressWarnings(as.numeric(num_input))

#check if input is numeric
if (is.na(num)) {
  
  print("Please input numbers only.")
  
} else if (num != as.integer(num) || num <= 0) {
  
  print("Please input a positive integer only.")
  
} else {
  
  num <- as.integer(num)
  
  #cube calculation
  for (i in 1:num) {
    cube <- i^3
    print(paste("Number is:", i, 
                "and cube of the", i, 
                "is:", cube))
  }
}
