# Name: Wan Nur Adnin Binti Wan Mohd Suhaimi
# ID: 24006589 

#===============================================================================

# 1) SET WORKING DIRECTORY
# setwd("C:/Users/wnadn/Documents/DS_TEB2043/DataCleaning_Assignment")
#-------------------------------------------------------------------------------

# 2) READ RAW FILE AS TEXT (file has mixed formatting) 
lines <- readLines("raw_data/Unclean Dataset.csv",
                   warn = FALSE,
                   encoding = "latin1")

#-------------------------------------------------------------------------------

# 3) REMOVE COMPLETELY EMPTY LINES
lines <- lines[nzchar(trimws(lines))]

#-------------------------------------------------------------------------------

# 4) SPLIT EACH LINE INTO EXACTLY 8 COLUMNS
split_line <- function(x) {
  
  # Try pipe split first
  parts <- strsplit(x, "\\|")[[1]]
  parts <- trimws(parts)
  
  # If pipe split doesn't give enough columns, try comma split
  if (length(parts) < 8) {
    parts <- strsplit(x, ",")[[1]]
    parts <- trimws(parts)
    
    # If more than 8 parts (payment contains commas), merge extras into col 8
    if (length(parts) > 8) {
      parts <- c(parts[1:7], paste(parts[8:length(parts)], collapse = ","))
    }
  }
  
  # If pipe split gives MORE than 8 parts (trailing separators), merge extras into col 8
  if (length(parts) > 8) {
    parts <- c(parts[1:7], paste(parts[8:length(parts)], collapse = ""))
  }
  
  # If fewer than 8, pad with NA
  if (length(parts) < 8) {
    parts <- c(parts, rep(NA, 8 - length(parts)))
  }
  
  return(parts)
}

# Apply split_line to all rows
data_list <- lapply(lines, split_line)

#-------------------------------------------------------------------------------

# 5) CONVERT TO DATAFRAME
raw_data <- as.data.frame(do.call(rbind, data_list), stringsAsFactors = FALSE)

#-------------------------------------------------------------------------------

# 6) ASSIGN CORRECT COLUMN NAMES
colnames(raw_data) <- c("Student_ID", "First_Name", "Last_Name", "Age",
                        "Gender", "Course", "Enrollment_Date", "Total_Payments")

# 6.1) Remove header row that appears as data
raw_data <- raw_data[raw_data$Student_ID != "Student_ID", ]

# 6.2) Remove rows where Student_ID is missing/blank (if any)
raw_data$Student_ID <- trimws(raw_data$Student_ID)
raw_data <- raw_data[raw_data$Student_ID != "" & !is.na(raw_data$Student_ID), ]

# 6.3) Mark non-numeric Student_ID as NA (column-shift cases)
raw_data$Student_ID[!grepl("^[0-9]+$", raw_data$Student_ID)] <- NA

# Check
head(raw_data)
nrow(raw_data)

#-------------------------------------------------------------------------------

# 7) CLEAN AGE
# Fix misaligned age/gender (Some rows have Age = "M" or "F" and Gender = "M 25" / "F 24")
raw_data$Age <- trimws(raw_data$Age)
raw_data$Gender <- trimws(raw_data$Gender)

# 7.1) Gender contains both gender and age (e.g., "M 25", "F24")
rows_gender_has_age <- grepl("^[MFmf]\\s*[0-9]+$", raw_data$Gender)

extracted_age <- as.numeric(sub("^[MFmf]\\s*", "", raw_data$Gender[rows_gender_has_age]))
extracted_gender <- toupper(sub("^([MFmf]).*$", "\\1", raw_data$Gender[rows_gender_has_age]))

age_needs_fix <- rows_gender_has_age & (is.na(raw_data$Age) | raw_data$Age == "" | grepl("^[MFmf]$", raw_data$Age))
raw_data$Age[age_needs_fix] <- extracted_age[which(age_needs_fix[rows_gender_has_age])]
raw_data$Gender[rows_gender_has_age] <- extracted_gender

# 7.2) Age is "M"/"F" and Gender is missing -> move Age into Gender
rows_age_is_gender <- grepl("^[MFmf]$", raw_data$Age) & (is.na(raw_data$Gender) | raw_data$Gender == "")
raw_data$Gender[rows_age_is_gender] <- toupper(raw_data$Age[rows_age_is_gender])
raw_data$Age[rows_age_is_gender] <- NA

# 7.3) Age and Gender are swapped (e.g., Age="F", Gender="18")
rows_swapped <- grepl("^[MFmf]$", raw_data$Age) & grepl("^[0-9]+$", raw_data$Gender)
temp_age <- raw_data$Gender[rows_swapped]
raw_data$Gender[rows_swapped] <- toupper(raw_data$Age[rows_swapped])
raw_data$Age[rows_swapped] <- temp_age

# Convert Age to numeric
raw_data$Age <- as.numeric(gsub("[^0-9]", "", raw_data$Age))

# Replace unrealistic ages with NA (university dataset)
raw_data$Age[raw_data$Age < 16] <- NA

# Check
summary(raw_data$Age)
sum(is.na(raw_data$Age))

#-------------------------------------------------------------------------------

# 8) CLEAN GENDER (standardize to "M" or "F")
raw_data$Gender <- toupper(trimws(raw_data$Gender))

# Replace empty strings with NA
raw_data$Gender[raw_data$Gender == ""] <- NA

# Keep only M or F, others become NA
raw_data$Gender[!raw_data$Gender %in% c("M", "F")] <- NA

# Check
table(raw_data$Gender, useNA = "ifany")

#-------------------------------------------------------------------------------

# 9) CLEAN COURSE (fix typos/truncation)
raw_data$Course <- trimws(raw_data$Course)

# Fix common truncations / typos
raw_data$Course <- gsub("^Machine Learnin$", "Machine Learning", raw_data$Course)
raw_data$Course <- gsub("^Web Developmen$", "Web Development", raw_data$Course)
raw_data$Course <- gsub("^Web Developmet$", "Web Development", raw_data$Course)
raw_data$Course <- gsub("^Web Develpment$", "Web Development", raw_data$Course)

# Replace blank with NA
raw_data$Course[raw_data$Course == ""] <- NA

# Remove/mark invalid course values
raw_data$Course[raw_data$Course %in% c("4")] <- NA

# Check
sort(unique(raw_data$Course))

#-------------------------------------------------------------------------------

# 10) CLEAN ENROLLMENT DATE (convert to Date with multiple formats)
raw_data$Enrollment_Date <- trimws(raw_data$Enrollment_Date)

# Convert common "missing" text to real NA
raw_data$Enrollment_Date[raw_data$Enrollment_Date %in% c("", "<NA>")] <- NA

# Parse dates using multiple possible formats
Enrollment_Date_clean <- as.Date(raw_data$Enrollment_Date, format = "%Y-%m-%d")
missing_dates <- is.na(Enrollment_Date_clean)

Enrollment_Date_clean[missing_dates] <- as.Date(raw_data$Enrollment_Date[missing_dates], format = "%d-%b-%y")
missing_dates <- is.na(Enrollment_Date_clean)

Enrollment_Date_clean[missing_dates] <- as.Date(raw_data$Enrollment_Date[missing_dates], format = "%d-%m-%y")

raw_data$Enrollment_Date <- Enrollment_Date_clean
rm(Enrollment_Date_clean, missing_dates)

# Fix incorrect years (e.g., 0005-01-20 caused by two-digit year parsing)
bad_years <- !is.na(raw_data$Enrollment_Date) &
  as.numeric(format(raw_data$Enrollment_Date, "%Y")) < 1900

fixed_str <- paste0(
  "20", format(raw_data$Enrollment_Date[bad_years], "%y"), "-",
  format(raw_data$Enrollment_Date[bad_years], "%m"), "-",
  format(raw_data$Enrollment_Date[bad_years], "%d")
)

raw_data$Enrollment_Date[bad_years] <- as.Date(fixed_str, format = "%Y-%m-%d")

# Check
summary(raw_data$Enrollment_Date)
sum(is.na(raw_data$Enrollment_Date))

#-------------------------------------------------------------------------------

# 11) CLEAN Total_Payments PROPERLY 
raw_data$Total_Payments <- trimws(raw_data$Total_Payments)

# Convert common missing-value text to NA
raw_data$Total_Payments[raw_data$Total_Payments %in% c("", "<NA>")] <- NA

# Keep only digits, commas, and decimal points (remove currency symbols)
raw_data$Total_Payments <- gsub("[^0-9.,]", "", raw_data$Total_Payments)

# Remove thousand separators
raw_data$Total_Payments <- gsub(",", "", raw_data$Total_Payments)

# Convert to numeric
raw_data$Total_Payments <- as.numeric(raw_data$Total_Payments)

# 11.1) payment value glued with an ID (dataset-specific issue)
too_large <- !is.na(raw_data$Total_Payments) & raw_data$Total_Payments > 1000000
raw_data$Total_Payments[too_large] <- as.numeric(
  substr(as.character(raw_data$Total_Payments[too_large]), 1, 4)
)

# 11.2) decimal-shifted values (e.g., 1.20 interpreted as 1.2 instead of 1200)
small_payments <- !is.na(raw_data$Total_Payments) & raw_data$Total_Payments < 100
raw_data$Total_Payments[small_payments] <- raw_data$Total_Payments[small_payments] * 1000

# Fix trailing digit corruption (9001 -> 900)
fix_tail1 <- !is.na(raw_data$Total_Payments) &
  raw_data$Total_Payments %% 10 == 1 &
  (raw_data$Total_Payments %/% 10) >= 500 &
  (raw_data$Total_Payments %/% 10) <= 2000

raw_data$Total_Payments[fix_tail1] <- raw_data$Total_Payments[fix_tail1] %/% 10

# Check 
head(raw_data$Total_Payments)
str(raw_data$Total_Payments)
sum(is.na(raw_data$Total_Payments))

#-------------------------------------------------------------------------------

# 12) REMOVE EXACT DUPLICATED ROWS
# Remove duplicates based on core attributes (ignore Student_ID and Name)
raw_data <- raw_data[!duplicated(
  raw_data[, c("Age","Gender","Course","Enrollment_Date","Total_Payments")]
), ]

# Check number of rows after removing duplicates
nrow(raw_data)

#-------------------------------------------------------------------------------

#13) VALIDATIONS
raw_data[is.na(raw_data$Age), ]
raw_data[is.na(raw_data$Gender), ]
raw_data[is.na(raw_data$Course), ]
raw_data[is.na(raw_data$Enrollment_Date), ]
raw_data[is.na(raw_data$Total_Payments), ]
colSums(is.na(raw_data))

# Remove fully empty rows
raw_data <- raw_data[rowSums(is.na(raw_data)) != ncol(raw_data), ]

#-------------------------------------------------------------------------------

#14) EXPORT CLEANED DATA
if (!dir.exists("cleaned_data")) dir.create("cleaned_data")
write.csv(raw_data, "cleaned_data/Unclean_Dataset_CLEANED.csv", row.names = FALSE)
