V1 <- c(2,3,1,5,4,6,8,7,9)

Matrix1 <- matrix(V1, nrow = 3, ncol = 3)
print(Matrix1)

rownames(Matrix1) <- c("R1","R2","R3")
colnames(Matrix1) <- c("C1","C2","C3")

print(Matrix1)

Matrix2 <- t(Matrix1)
print(Matrix2)

#addition
result_add <- Matrix1 + Matrix2
cat("Addition Result\n")
print(result_add)

#subtraction
result_sub <- Matrix1 - Matrix2
cat("Subtraction Result\n")
print(result_sub)

#multiplication
result_mul <- Matrix1 * Matrix2
cat("Multiplication Result\n")
print(result_mul)

#division
result_div <- Matrix1 / Matrix2
cat("Division Result\n")
print(result_div)

