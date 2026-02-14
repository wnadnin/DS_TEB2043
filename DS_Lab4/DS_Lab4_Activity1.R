age <- c(55,57,56,52,51,59,58,53,59,55,60,60,60,60,52,55,56,51,60,
         52,54,56,52,57,54,56,58,53,53,50,55,51,57,60,57,55,51,50,57,58)

age_factor <- factor(age)
print(age_factor)
levels(age_factor)

# Count staff per age
age_count <- table(age_factor)
print(age_count)

age_range <- cut(age,
                 breaks = c(50, 52, 54, 56, 58, 60),
                 include.lowest = TRUE,
                 right = TRUE)

range_count <- table(age_range)
print(range_count)

# Staff Age vs Total number of staff
age_table <- data.frame(
  Staff_Age = names(age_count),
  Total_Staff = as.vector(age_count)
)
print(age_table)

# Age Range vs Total number of staff
range_table <- data.frame(
  Age_Range = names(range_count),
  Total_Staff = as.vector(range_count)
)
print(range_table)

