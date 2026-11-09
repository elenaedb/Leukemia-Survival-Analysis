# SURVIVAL ANALYSIS OF LEUKEMIA PATIENTS
# Comparison of maintenance and non-maintenance chemotherapy
library(survival)
library(ggplot2)
library(survminer)

# DATASET
# time: follow-up time in weeks
# status: 1 = event (death), 0 = right-censored
# x: Maintained / Nonmaintained chemotherapy
# Objective: describe survival and compare the two treatment groups.
leukemia = survival::aml

head(leukemia)
dim(leukemia)
str(leukemia)
summary(leukemia)
colSums(is.na(leukemia))

# Set the treatment reference group explicitly.
leukemia$x = factor(leukemia$x, levels = c("Maintained", "Nonmaintained"))

# GRAPHIC SETTINGS
# Same palette and minimal theme for all final plots.
colors = c("Maintained" = "#2864A0", "Nonmaintained" = "#E18B45")
theme_set(theme_classic(base_size = 12))

# UNIVARIATE EXPLORATORY ANALYSIS
Surv(leukemia$time, leukemia$status)

# Events and censored observations.
table(leukemia$status)
prop.table(table(leukemia$status))

# Patients by treatment.
table(leukemia$x)
prop.table(table(leukemia$x))

# Summary of follow-up times by treatment (not median survival).
aggregate(time ~ x, data = leukemia, FUN = summary)

# Overall Kaplan-Meier estimation: S(t) = P(T > t).
fit0 = survfit(Surv(time, status) ~ 1, data = leukemia)
fit0
summary(fit0)
quantile(fit0)

plot0 = ggsurvplot(fit0, data = leukemia,
                   conf.int = TRUE, conf.int.alpha = 0.16,
                   risk.table = TRUE, risk.table.height = 0.20,
                   censor = TRUE, censor.shape = 124, censor.size = 3,
                   palette = "#2864A0", legend = "none",
                   xlim = c(0, 50), break.time.by = 10,
                   xlab = "Time (weeks)",
                   ylab = "Survival probability",
                   title = "Overall survival",
                   ggtheme = theme_classic(base_size = 12),
                   tables.theme = theme_cleantable())
print(plot0)

# BIVARIATE ANALYSIS
# Event counts by group; follow-up time is ignored in this table.
table(leukemia$status, leukemia$x)

# Descriptive table by group (patients, events, censored).
table_treatment = table(leukemia$x, leukemia$status)
colnames(table_treatment) = c("Censored", "Events")
table_treatment

# Fisher test is supplementary only, not a survival comparison.
fisher.test(table(leukemia$status, leukemia$x))

# Kaplan-Meier estimation by treatment.
fit1 = survfit(Surv(time, status) ~ x, data = leukemia)
fit1
summary(fit1)

# Estimated survival at 12 and 24 weeks; use confidence intervals.
summary(fit1, times = c(12, 24), extend = FALSE)

# Kaplan-Meier curves: confidence bands, censoring marks and risk table.
plot1 = ggsurvplot(fit1, data = leukemia,
                   conf.int = TRUE, conf.int.alpha = 0.16,
                   risk.table = TRUE, risk.table.height = 0.25,
                   risk.table.col = "strata",
                   pval = TRUE, pval.coord = c(5, 0.20),
                   censor = TRUE, censor.shape = 124, censor.size = 3,
                   palette = unname(colors), legend = "top",
                   xlim = c(0, 50), break.time.by = 10,
                   xlab = "Time (weeks)",
                   ylab = "Survival probability",
                   title = "Survival by treatment group",
                   legend.title = "Treatment",
                   legend.labs = levels(leukemia$x),
                   ggtheme = theme_classic(base_size = 12),
                   tables.theme = theme_cleantable())
print(plot1)

# Complementary log-log curves: an exploratory PH diagnostic.
# Their appearance alone does not establish proportional hazards.
plot(fit1, fun = "cloglog", col = unname(colors), lty = 1:2, lwd = 2,
     xlab = "Time (weeks)", ylab = "log(-log(S(t)))", 
     main = "Complementary log-log survival curves", las = 1, bty = "l")

legend("topleft", legend = levels(leukemia$x), col = unname(colors), 
       lty = 1:2, lwd = 2, bty = "n")

# LOG-RANK TEST
# H0: no difference between survival curves.
logrank = survdiff(Surv(time, status) ~ x, data = leukemia)
logrank
pvalue_logrank = pchisq(logrank$chisq, df = length(logrank$n) - 1, lower.tail = F)
pvalue_logrank

# COX PROPORTIONAL HAZARDS MODEL
# h(t | x) = h0(t) * exp(beta*x)
# HR is Nonmaintained vs Maintained.
levels(leukemia$x)
mod = coxph(Surv(time, status) ~ x, data = leukemia)
mod
summary(mod)

# Hazard ratio and 95% confidence interval.
exp(coef(mod))
exp(confint(mod))

# Simple forest plot for the single treatment coefficient.
hr = exp(coef(mod))
hr_ci = exp(confint(mod))

hr_data = data.frame(treatment = "Nonmaintained vs Maintained",
  HR = as.numeric(hr), lower = hr_ci[1, 1], upper = hr_ci[1, 2])

# Label with hazard ratio and confidence interval.
hr_data$label = sprintf("HR = %.2f (95%% CI: %.2f–%.2f)",
                        hr_data$HR, hr_data$lower, hr_data$upper)

plot_hr = ggplot(hr_data, aes(x = treatment, y = HR)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "grey55") +
  geom_pointrange(aes(ymin = lower, ymax = upper), color = "#2864A0", 
                  linewidth = 0.8) +
  coord_flip() +
  scale_y_log10(limits = c(0.5, 12), breaks = c(0.5, 1, 2, 5, 10)) +
  labs(title = "Cox model: treatment hazard ratio", subtitle = hr_data$label,
       x = NULL, y = "Hazard ratio (log scale), 95% CI") +
  theme_classic(base_size = 12) + 
  theme(plot.title = element_text(face = "bold"),
        plot.subtitle = element_text(size = 10),
        axis.text.y = element_text(size = 10))
print(plot_hr)

# PROPORTIONAL HAZARDS ASSUMPTION
# Schoenfeld residual test (H0: proportional hazards).
ph_test = cox.zph(mod)
ph_test
plot(ph_test, col = "#2864A0", lwd = 2,
     main = "Schoenfeld residual diagnostic")

# CONCLUSIONS
# The analysis included 23 patients, with 18 observed deaths and 
# 5 censored observations.
# Overall median survival was 27 weeks (95% CI: 18-45 weeks).

# Median survival was 31 weeks in the Maintained group and
# 23 weeks in the Nonmaintained group.

# The log-rank test did not detect a statistically significant
# difference between the two survival curves (p = 0.0653).

# The Cox model estimated a higher hazard of death in the
# Nonmaintained group compared with the Maintained group
# (HR = 2.50, 95% CI: 0.92-6.81, Wald p = 0.0737).

# The proportional hazards test did not provide evidence against
# the PH assumption (p = 0.93).

# Although the results suggest a potential survival benefit
# associated with maintenance chemotherapy, the differences
# were not statistically significant at the 5% level.

# Results should be interpreted cautiously due to the small
# sample size, wide confidence intervals and limited statistical power.
# No causal conclusions or treatment equivalence can be established.