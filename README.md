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
In order to do so, the NHANES 2017-2020 cohort was analysed: a cross-sectional study designed to take a representative sample of the US population. The findings were published in The Journal of the American Dental Association.

### Abstract
**Background:** Untreated caries is a prevalent disease that is associated with a substantial health and economic burden. Many past efforts have assessed the epidemiology of untreated caries, and this study provides the most up-to-date figures on the distribution and determinants of the disease in the adult US population for the period 2017 through 2020. \
**Methods:** Using data from the 2017-2020 National Health and Nutrition Examination Survey, the author derived estimates for untreated caries prevalence in the adult US population. The author conducted subgroup analyses to assess how the epidemiology differed between coronal and root caries and how the disease was distributed among population subgroups. \
**Results:** On the basis of a weighted sample representative of 193.5 million adults, the prevalence of untreated caries was found to be 21.3%. Specific prevalence of coronal and root caries were 17.9% and 10.1%, respectively. Caries was most prevalent in those aged 30 through 39 years (25.2%) and 40 through 49 years (22.3%), men (23.5%), those of other (36.5%) or non-Hispanic Black (35.6%) race or ethnicity, those with family income to poverty ratio of 0.5 through 1.0 (46.2%) or less than 0.5 (37.3%), those with educational attainment less than high school graduation (39.6%), those who did not have health insurance (42.1%), and those who were underweight (25.1%) or obese (23.5%). \
**Conclusions:** Untreated caries is present in more than 1 in 5 adults within the US population and is disproportionately distributed among those of lower socioeconomic status.

### Analysis
The Stata do-file to execute the analyses is located in /Stata/NHANES_2020_Adult_Caries.do; note that I did not create a single for-loop to simultaneously execute all of the analyses, as I wanted to view the outputs of each analysis, one at a time.

**R v4.0.5** \
**Stata v16.0**
