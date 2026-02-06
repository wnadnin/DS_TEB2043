# Input vector of exam scores
scores <- c(33, 24, 54, 94, 16, 89, 60, 6, 77, 61,
            13, 44, 26, 24, 73, 73, 90, 39, 90, 54)

A <- sum(scores >= 90 & scores <= 100)
B <- sum(scores >= 80 & scores <= 89)
C <- sum(scores >= 70 & scores <= 79)
D <- sum(scores >= 60 & scores <= 69)
E <- sum(scores >= 50 & scores <= 59)
F <- sum(scores <= 49)

cat("Score  Grade  Number of students\n")
cat("90-100   A     ", A, "\n")
cat("80-89    B     ", B, "\n")
cat("70-79    C     ", C, "\n")
cat("60-69    D     ", D, "\n")
cat("50-59    E     ", E, "\n")
cat("<=49     F     ", F, "\n")

pass_status <- scores > 49
pass_status
