# Load library 
library(glmtoolbox)   
library(ggplot2)      
library(readr)        
library(dplyr)        

df <- read_csv("r_input_predictions.csv")

# Buat model logistic regression dari data
model <- glm(true_default ~ default_proba, data = df, family = "binomial")

hl <- hltest(model, g = 10)

# show result
print(hl)

sink("hl_test_output.txt")
print(hl)
sink()

# Buat 10 kelompok 
df_plot <- df %>%
  mutate(score_bin = ntile(default_proba, 10)) %>%
  group_by(score_bin) %>%
  summarise(
    mean_pred = mean(default_proba),
    mean_actual = mean(true_default)
  )

# Plot kalibrasi
library(ggplot2)

cal_plot <- ggplot(df_plot, aes(x = mean_pred, y = mean_actual)) +
  geom_point(color = "blue", size = 3) +
  geom_line(color = "blue") +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray") +
  labs(
    title = "Calibration Curve",
    x = "Predicted Probability",
    y = "Observed Default Rate"
  ) +
  theme_minimal()

print(cal_plot)

ggsave("calibration_curve.png", cal_plot, dpi = 300, width = 6, height = 4)
