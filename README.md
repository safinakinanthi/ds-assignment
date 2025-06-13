
## 📊 Summary

This submission covers three main parts:

- **A. SQL Analysis**  
  Performed RFM segmentation and identified repeat purchase behavior.

- **B. Python Modeling**  
  Built a credit scoring model using multiple algorithms. Final model selected is XGBoost with scale_pos_weight handling, with a credit score conversion (300–850) and SHAP interpretation.

- **C. R Statistical Check**  
  Calibration curve and Hosmer-Lemeshow test (p = 0.4). Final cut-off score of **823** ensures expected default rate ≤ 5%.

## ⚙️ Tools Used
- Python (Pandas, Sklearn, XGBoost, SHAP)
- SQL (DuckDB)
- R (glmtoolbox, ggplot2, dplyr)

---
