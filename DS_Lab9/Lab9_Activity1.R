data(ToothGrowth)
View(ToothGrowth)
head(ToothGrowth)

cor(ToothGrowth[, c("len", "dose")])
cor.test(ToothGrowth$len, ToothGrowth$dose, method = "pearson")

install.packages("reshape2")
install.packages("ggplot2")

library(reshape2)
library(ggplot2)

corr_mat <- round(cor(ToothGrowth[, c("len", "dose")]), 2)
print(corr_mat)

melted_corr_mat <- melt(corr_mat)
print(melted_corr_mat)

ggplot(data = melted_corr_mat, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = value), color = "white", size = 5) +
  ggtitle("Correlation Heatmap for ToothGrowth Dataset")
