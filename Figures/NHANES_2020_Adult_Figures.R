#############################################
### NHANES 2017-2020 Adult Caries Figures ###
#############################################

# Packages
library(ggplot2)
library(gridExtra)

### Figure 1 ###
## This figure will contain charts for age, sex, and ethnicity ##

# Importing data
age <- read.csv("{User Directory}\\Age.csv")
sex <- read.csv("{User Directory}\\Sex.csv")
ethnicity <- read.csv("{User Directory}\\Ethnicity.csv")

# Age
plot1 <- 
  ggplot(age, aes(x = factor(type), y = prevalence, fill = factor(age))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .25, color = "black", position = position_dodge(0.8)) +
  scale_y_continuous("Weighted prevalence (%)", limits = c(0, 30), breaks = seq(0, 30, 5)) +
  scale_x_discrete(name = NULL, labels = c("1" = "Any caries", "2" = "Coronal caries", "3" = "Root caries")) +
  scale_fill_discrete(name = "Age (years)", label = c("20 - 29", "30 - 39", "40 - 49", "50 - 59", "60 - 69", "\u2265 70"))

plot1 <- plot1 + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
# Sex
plot2 <- 
  ggplot(sex, aes(x = factor(type), y = prevalence, fill = factor(sex))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .25, color = "black", position = position_dodge(0.8)) +
  scale_y_continuous("Weighted prevalence (%)", limits = c(0, 30), breaks = seq(0, 30, 5)) +
  scale_x_discrete(name = NULL, labels = c("1" = "Any caries", "2" = "Coronal caries", "3" = "Root caries")) +
  scale_fill_discrete(name = "Sex", label = c("Men", "Women"))

plot2 <- plot2 + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
# Ethnicity
plot3 <- 
  ggplot(ethnicity, aes(x = factor(type), y = prevalence, fill = factor(ethnicity))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .25, color = "black", position = position_dodge(0.8)) +
  scale_y_continuous("Weighted prevalence (%)", limits = c(0, 50), breaks = seq(0, 50, 10)) +
  scale_x_discrete(name = NULL, labels = c("1" = "Any caries", "2" = "Coronal caries", "3" = "Root caries")) +
  scale_fill_discrete(name = "Race / Ethnicity", label = c("NH White", "NH Black", "Hispanic", "NH Asian", "Other"))

plot3 <- plot3 + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

# Combined plot
# Export at 2000 x 600 dimensions
fig1 <- grid.arrange(plot1, plot2, plot3,
                     nrow = 1)

### Figure 2 ###
## This figure will contain charts for income, education, insurance, BMI ##

# Importing data
income <- read.csv("{User Directory}\\Fpl.csv")
education <- read.csv("{User Directory}\\Educ.csv")
insurance <- read.csv("{User Directory}\\Insurance.csv")
bmi <- read.csv("{User Directory}\\BMI.csv")

# Income
plot4 <- 
  ggplot(income, aes(x = factor(type), y = prevalence, fill = factor(fpl))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .25, color = "black", position = position_dodge(0.8)) +
  scale_y_continuous("Weighted prevalence (%)", limits = c(0, 55), breaks = seq(0, 55, 10)) +
  scale_x_discrete(name = NULL, labels = c("1" = "Any caries", "2" = "Coronal caries", "3" = "Root caries")) +
  scale_fill_discrete(name = "Income-to-poverty Ratio", label = c("< 0.5", "0.5 - 1.0", "1.0 - 2.5", "2.5 - 4.0", "\u2265 4.0"))

plot4 <- plot4 + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

# Education
plot5 <- 
  ggplot(education, aes(x = factor(type), y = prevalence, fill = factor(educ))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .25, color = "black", position = position_dodge(0.8)) +
  scale_y_continuous("Weighted prevalence (%)", limits = c(0, 50), breaks = seq(0, 50, 10)) +
  scale_x_discrete(name = NULL, labels = c("1" = "Any caries", "2" = "Coronal caries", "3" = "Root caries")) +
  scale_fill_discrete(name = "Educational Attainment", label = c("Less than high school", "High school graduate", "More than high school"))

plot5 <- plot5 + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

# Insurance
plot6 <- 
  ggplot(insurance, aes(x = factor(type), y = prevalence, fill = factor(insu))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .25, color = "black", position = position_dodge(0.8)) +
  scale_y_continuous("Weighted prevalence (%)", limits = c(0, 50), breaks = seq(0, 50, 10)) +
  scale_x_discrete(name = NULL, labels = c("1" = "Any caries", "2" = "Coronal caries", "3" = "Root caries")) +
  scale_fill_discrete(name = "Health Insurance", label = c("Insured", "Uninsured"))

plot6 <- plot6 + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

# BMI
plot7 <- 
  ggplot(bmi, aes(x = factor(type), y = prevalence, fill = factor(bmi))) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_errorbar(aes(ymin = min, ymax = max), width = .25, color = "black", position = position_dodge(0.8)) +
  scale_y_continuous("Weighted prevalence (%)", limits = c(0, 40), breaks = seq(0, 40, 5)) +
  scale_x_discrete(name = NULL, labels = c("1" = "Any caries", "2" = "Coronal caries", "3" = "Root caries")) +
  scale_fill_discrete(name = "BMI", label = c("Underweight", "Normal weight", "Overweight", "Obese"))

plot7 <- plot7 + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                    panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

# Combined plot
# Export at 1800 x 1200 dimensions
fig2 <- grid.arrange(plot4, plot6, plot5, plot7,
                     nrow = 2)