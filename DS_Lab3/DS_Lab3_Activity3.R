# Create list with Chemistry and Physics scores
student_records <- list(
  Chemistry = c(
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
  ),
  
  Physics = c(
    Robert = 89,
    Hemsworth = 86,
    Scarlett = 65,
    Evans = 52,
    Pratt = 60,
    Larson = 67,
    Holland = 40,
    Paul = 77,
    Simu = 90,
    Renner = 61
  )
)

fail_chemistry <- sum(student_records$Chemistry <= 49)
fail_physics <- sum(student_records$Physics <= 49)

highest_chemistry <- max(student_records$Chemistry)
highest_physics <- max(student_records$Physics)

best_chemistry <- names(student_records$Chemistry[
  student_records$Chemistry == highest_chemistry
])

best_physics <- names(student_records$Physics[
  student_records$Physics == highest_physics
])

cat("Number of students failed Chemistry:", fail_chemistry, "\n")
cat("Number of students failed Physics:", fail_physics, "\n")

cat("Highest Chemistry score:", highest_chemistry, "\n")
cat("Student(s) with highest Chemistry score:", best_chemistry, "\n")

cat("Highest Physics score:", highest_physics, "\n")
cat("Student(s) with highest Physics score:", best_physics, "\n")

