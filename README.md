# Survival Analysis of Acute Myeloid Leukemia Patients

## Project Overview
This project applies survival analysis methods to investigate the association between maintenance chemotherapy and survival outcomes in patients with acute myeloid leukemia (AML).
The analysis was conducted in R using the 'leukemia' dataset, available in the 'survival' package. The dataset includes 23 patients divided into two treatment groups: Maintained and Nonmaintained.
The main objective is to estimate survival probabilities, compare survival outcomes between treatment groups, and evaluate the association between treatment and the hazard of death.

## Statistical Methods
The analysis includes:
1. **Exploratory Data Analysis (EDA):** Descriptive statistics for survival time, event status, and treatment groups.
2. **Kaplan–Meier Estimation:** Estimation of overall and treatment-specific survival functions, including confidence intervals.
3. **Log-rank Test:** Comparison of survival distributions between the two treatment groups.
4. **Cox Proportional Hazards Regression:** Estimation of the hazard ratio associated with maintenance chemotherapy.
5. **Model Diagnostics:** Assessment of the proportional hazards assumption using Schoenfeld residuals.

## Dataset
The dataset is included in the R package 'survival', so no external data files are required.

| Variable | Description |
| 'time' | Follow-up time in weeks |
| 'status' | Event indicator (1 = death, 0 = censored) |
| 'x' | Treatment group (Maintained / Nonmaintained) |

## Requirements
The analysis was developed in R using the following packages:
- 'survival'
- 'survminer'
- 'ggplot2'
Install them using: install.packages(c("survival", "survminer", "ggplot2"))

## How to Run
1. Download or clone this repository.
2. Open 'Leukemia_Survival_Analysis.R' in RStudio.
3. Install the required packages if necessary.
4. Run the script to reproduce the statistical analyses and visualizations.
All figures and statistical results are generated directly in R.

## Main Findings
The analysis suggests a higher estimated hazard of death among patients in the Nonmaintained group compared with the Maintained group (HR ≈ 2.50).
However, the association was not statistically significant at the 5% significance level (95% CI: 0.92–6.81).
The log-rank test also did not detect a statistically significant difference between the survival curves (p ≈ 0.065).
These results should be interpreted with caution because of the small sample size and the uncertainty surrounding the estimates.

## Limitations
- Small sample size (23 patients).
- Analysis limited to a single explanatory variable.
- Limited statistical power to detect differences between treatment groups.
- Results do not establish a causal effect of treatment.

## Tools and Technologies
R | Survival Analysis | Kaplan–Meier | Cox Regression | Statistical Modeling