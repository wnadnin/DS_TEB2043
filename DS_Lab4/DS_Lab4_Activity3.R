Array1 <- array(1:24, dim = c(2,4,3))
print(Array1)

Array2 <- array(25:54, dim = c(3,2,5))
print(Array2)

cat("Second row of second matrix of Array1:\n")
print(Array1[2, , 2])

cat("Element in 3rd row and 2nd column of 1st matrix of Array2:\n")
print(Array2[3, 2, 1])

