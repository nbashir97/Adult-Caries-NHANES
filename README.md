# US Adult Caries Epidemiology
Code for the paper on the prevalence of caries in US adults for the period 2017 to 2020.

#### Authors
Nasir Zeeshan Bashir

#### Links
[Published paper](https://jada.ada.org/article/S0002-8177(21)00581-X/fulltext) (doi: 10.1016/j.adaj.2021.09.004)

[Survey methods and analytical guidelines](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?Cycle=2017-2020)  \
[NHANES data](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?Cycle=2017-2020)                               \
[US 2000 Census weights](https://seer.cancer.gov/stdpopulations/)                                                           

### Background
This Stata code documents the analyses carried out in order to estimate the prevalence of untreated caries in the US adult population, for the period 2017 through 2020.
In order to do so, the NHANES 2017-2020 cohort was analysed; a complex, multistage, cross-sectional study, designed to take a representative sample of the noninstitutionalised US population.

### Data 
For this analysis, the Demographics (DEMO), Health Insurance (HIQ), Body Measures (BMX), and Oral Examination (OHXDEN) files were used. \
The raw SAS XPT files from the CDC website are located in /Stata/XPT                                                                    \
The dta files converted from the SAS XPT files are located in /Stata/DTA                                                                \
The single, unified dta file is located in /Stata/NHANES2020.dta

### Analysis
The Stata do-file to execute the analyses is located in /Stata/NHANES_2020_Adult_Caries.do                                                                            \
Note that the complex survey design of NHANES is accounted for by passing the sample weights, primary sampling units, and strata ID to the svyset function in Stata.  \
Age-standardised estimates were derived using the US 2000 Census data.                                                                                                \
The calculated weights are located in /Weights/Census.xlsx                                                                                                            \
Note that under Section 3: Data Analysis, I did not create a single for loop to simultaneously execute all of the analyses, as I wanted to view the outputs of each analysis, one at a time.

### Figures
All of the figures were produced in R, using ggplot2.                                                                                                                 \
The code used to produce the figures is located in /Figures/NHANES_2020_Adult_Figures.R                                                                               \
The csv files files used to produce the figures are located in /Figures/CSV                                                                                           \
There are separate csv files for each socio-demographic characteristic, containing data on prevalence and 95% CIs. These were exported from Stata during the analysis.\
The prevalence values are stratified by socio-demographic subgroup, and then by type of caries, in order to produce the figures as required.                          \
It is easy to see what each strata number in the csv files corresponds to by looking at the R code.

### Other Software
All of these analyses are also easily executable in R using the svy package, and in Python using the pyreadstat module. \
I chose to use Stata as I have previously worked with NHANES in Stata and have code which I know to be stable.          

### Research Impact
The results were published in The Journal of the American Dental Association.        
At the time of publication, this paper provided the most contemporary statistics on untreated caries for any country in the world, not just the US.

##### Research conducted whilst at: School of Dentistry, University of Birmingham (BDS5 Student)
##### Research published whilst at: School of Oral and Dental Sciences, University of Bristol (Research Fellow)
##### Collaborators: None

##### Stata v16.0
##### R v4.0.5
