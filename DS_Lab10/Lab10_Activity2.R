data(ChickWeight)
head(ChickWeight)
str(ChickWeight)
summary(ChickWeight)

library(caTools)
library(class)

# Make sure Diet is treated as a factor
ChickWeight$Diet <- as.factor(ChickWeight$Diet)

# Select only relevant columns
cw_data <- ChickWeight[, c("Time", "weight", "Diet")]
head(cw_data)

# split training and testing
set.seed(123)

split <- sample.split(cw_data$Diet, SplitRatio = 0.7)
train_data <- subset(cw_data, split == TRUE)
test_data  <- subset(cw_data, split == FALSE)

nrow(train_data)
nrow(test_data)

# feature scaling
train_x <- scale(train_data[, c("Time", "weight")])
test_x  <- scale(test_data[, c("Time", "weight")])

train_y <- train_data$Diet
test_y  <- test_data$Diet

head(train_x)
head(test_x)
head(train_y)
head(test_y)

# testing different K values
k_values <- c(1, 3, 5, 7, 9, 11, 13, 15)
accuracy_results <- data.frame(K = integer(), Accuracy = numeric())
prediction_list <- list()

for (k in k_values) {
  pred_k <- knn(train = train_x,
                test = test_x,
                cl = train_y,
                k = k)
  
  acc <- mean(pred_k == test_y)
  
  accuracy_results <- rbind(accuracy_results,
                            data.frame(K = k, Accuracy = acc))
  
  prediction_list[[as.character(k)]] <- pred_k
}

print(accuracy_results)

# final KNN model with optimal K
best_k <- accuracy_results$K[which.max(accuracy_results$Accuracy)]
final_pred <- prediction_list[[as.character(best_k)]]

cm <- table(Actual = test_y, Predicted = final_pred)
print(cm)

final_accuracy <- mean(final_pred == test_y)
print(final_accuracy)