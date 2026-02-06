# Create list of student exam scores
student_scores <- list(
  Robert = 59,
  Hemsworth = 71,
  Scarlett = 83,
  Evans = 68,
  Pratt = 65,
  Larson = 57,
  Holland = 62,
  Paul = 92,
  Simu = 92,
  Renner = 59
)

scores <- unlist(student_scores)

highest_score <- max(scores)
lowest_score <- min(scores)
average_score <- mean(scores)

student_highest <- names(scores[scores == highest_score])
student_lowest <- names(scores[scores == lowest_score])

cat("Highest score:", highest_score, "\n")
cat("Lowest score:", lowest_score, "\n")
cat("Average score:", average_score, "\n")
cat("Student with highest score:", student_highest, "\n")
cat("Student with lowest score:", student_lowest, "\n")
