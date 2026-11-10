# Survival Analysis of Acute Myeloid Leukemia Patients

## Project Overview

This project applies **survival analysis methods** to investigate the association between maintenance chemotherapy and survival outcomes in patients with **acute myeloid leukemia (AML)**.

The analysis is conducted in R using the `aml` dataset from the `survival` package, containing 23 patients divided into two treatment groups: Maintained and Nonmaintained.

The main objectives are to estimate survival probabilities, compare survival outcomes between treatment groups, and evaluate the association between maintenance chemotherapy and the hazard of death.

## Dataset

The dataset is available directly through the R package `survival`, so no external data files are required.

| Variable | Description |
|---|---|
| `time` | Follow-up time in weeks |
| `status` | Event indicator (1 = death, 0 = censored) |
| `x` | Treatment group (Maintained / Nonmaintained) |

### Sample Characteristics

| Characteristic | Value |
|---|---:|
| Total patients | 23 |
| Maintained group | 11 |
| Nonmaintained group | 12 |
| Observed deaths | 18 |
| Censored observations | 5 |

## Statistical Methods

The analysis includes:

1. **Exploratory Data Analysis (EDA):** Descriptive statistics for survival time, event status, and treatment groups.
2. **Kaplan–Meier Estimation:** Estimation of overall and treatment-specific survival functions, including confidence intervals.
3. **Log-rank Test:** Comparison of survival distributions between treatment groups.
4. **Cox Proportional Hazards Regression:** Estimation of the hazard ratio associated with maintenance chemotherapy, including a 95% confidence interval.
5. **Model Diagnostics:** Assessment of the proportional hazards assumption using Schoenfeld residuals.

## Main Results

### Kaplan–Meier Survival Analysis

| Group | Patients | Median Survival |
|---|---:|---:|
| Overall | 23 | 27 weeks |
| Maintained | 11 | 31 weeks |
| Nonmaintained | 12 | 23 weeks |

The Kaplan–Meier estimates suggest longer survival among patients receiving maintenance chemotherapy.

However, the difference between the treatment groups was not statistically significant at the 5% significance level.

### Log-rank Test and Cox Regression

| Analysis | Result |
|---|---|
| Log-rank test | p = 0.065 |
| Cox hazard ratio (Nonmaintained vs Maintained) | 2.50 |
| 95% confidence interval | 0.92–6.81 |
| Cox regression p-value | 0.074 |
| Proportional hazards test | p = 0.93 |

The Cox regression model estimated a hazard of death approximately 2.5 times higher in the Nonmaintained group compared with the Maintained group.

Nevertheless, the 95% confidence interval includes 1, indicating that the association is not statistically significant at the 5% level.

The proportional hazards diagnostic did not identify evidence of a violation of the proportional hazards assumption.

## Interpretation and Limitations

The results suggest a potential association between maintenance chemotherapy and improved survival outcomes in patients with acute myeloid leukemia.

However, the findings should be interpreted cautiously because of several limitations:

- **Small sample size:** The dataset contains only 23 patients.
- **Limited statistical power:** The analysis may not have sufficient power to detect clinically meaningful differences.
- **Single explanatory variable:** The Cox model does not account for potential confounding factors.
- **Statistical uncertainty:** The estimated hazard ratio has a relatively wide confidence interval.
- **No causal inference:** The observed association does not establish a causal effect of treatment.

Further research using larger datasets and additional clinical variables would be necessary to strengthen these findings.

## Requirements

The analysis was developed using **R** and the following packages:

- `survival`
- `survminer`
- `ggplot2`

Install the packages using:

```r
install.packages(c("survival", "survminer", "ggplot2"))
```

## How to Run

1. Download or clone this repository.
2. Open `Leukemia_Survival_Analysis.R` in RStudio.
3. Install the required packages if necessary.
4. Run the script to reproduce the statistical analyses and visualizations.

The dataset is loaded directly from the `survival` package. All statistical results and figures are generated in RStudio.

## Tools and Technologies

R | Survival Analysis | Kaplan–Meier Estimation | Log-rank Test | Cox Regression | Statistical Modeling
