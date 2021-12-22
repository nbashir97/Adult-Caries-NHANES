**************************************************
*** NHANES 2017 - 2020 Adult Untreated Caries ****
**************************************************

*** This do-file contains the Stata code for epidemiological analysis for the prevalence of untreated caries in the NHANES 2017-2020 cohort ***
*** Primary outcomes are: (1) to present data on the probability weighted disease prevalence across the population, (2) to assess associations between socio-demographics and disease presence ***

use "{User Directory}\NHANES2020.dta", clear

****************************************************************************************************

*** Section 1: Cleaning Dataset ***
** New variables are defined for each socio-demographic characteristic **

** Age

generate age = 1 if(ridageyr >= 20 & ridageyr < 30 & ridageyr != .)
replace age = 2 if(ridageyr >= 30 & ridageyr < 40 & ridageyr != .)
replace age = 3 if(ridageyr >= 40 & ridageyr < 50 & ridageyr != .)
replace age = 4 if(ridageyr >= 50 & ridageyr < 60 & ridageyr != .)
replace age = 5 if(ridageyr >= 60 & ridageyr < 70 & ridageyr != .)
replace age = 6 if(ridageyr >= 70 & ridageyr != .)

label define age_lab 1 "20-29" 2 "30-39" 3 "40-49" 4 "50-59" 5 "60-69" 6 "70+"
label values age age_lab

** Sex

generate sex = 0 if(riagendr == 1)
replace sex = 1 if(riagendr == 2)

label define sex_lab 0 "Male" 1 "Female"
label values sex sex_lab

** Ethnicity

generate ethnicity = 1 if(ridreth3 == 3)
replace ethnicity = 2 if(ridreth3 == 4)
replace ethnicity = 3 if(ridreth3 == 1 | ridreth3 == 2)
replace ethnicity = 4 if(ridreth3 == 6)
replace ethnicity = 5 if(ridreth3 == 7)

label define eth_lab 1 "NHwhite" 2 "NHblack" 3 "Hispanic" 4 "NHasian" 5 "Other"
label values ethnicity eth_lab

** Income to Poverty Ratio

generate fpl = 0 if(indfmpir < 0.5 & indfmpir != .)
replace fpl = 1 if(indfmpir >= 0.5 & indfmpir < 1.0 & indfmpir != .)
replace fpl = 2 if(indfmpir >= 1.0 & indfmpir < 2.5 & indfmpir !=. )
replace fpl = 3 if(indfmpir >= 2.5 & indfmpir < 4.0 & indfmpir !=. )
replace fpl = 4 if(indfmpir >= 4.0 & indfmpir !=. )

label define fpl_lab 0 "<0.5" 1 "0.5" 2 "1.0" 3 "2.5" 4 "4.0"
label values fpl fpl_lab

** Education

generate education = 1 if(dmdeduc2 == 1 | dmdeduc2 == 2)
replace education = 2 if(dmdeduc2 == 3)
replace education = 3 if(dmdeduc2 == 4 | dmdeduc2 == 5)

label define edu_lab 1 "BelowHigh" 2 "HighSchool" 3 "AboveHigh"
label values education edu_lab

** Insurance

generate insurance = 0 if(hiq011 == 1)
replace insurance = 1 if(hiq011 == 2)

label define insu_lab 0 "Insured" 1 "Uninsured"
label values insurance insu_lab

** BMI

generate bmi = 1 if(bmxbmi < 18.5 & bmxbmi != .)
replace bmi = 2 if(bmxbmi >= 18.5 & bmxbmi < 25 & bmxbmi != .)
replace bmi = 3 if(bmxbmi >= 25 & bmxbmi < 30 & bmxbmi != .)
replace bmi = 4 if(bmxbmi >= 30 & bmxbmi != .)

label define bmi_lab 1 "Underweight" 2 "Normal" 3 "Overweight" 4 "Obese"
label values bmi bmi_lab

****************************************************************************************************

*** Section 2: Oral Health ***
** New variables are defined according to various aspects of the oral health examination **

** Complete exam
* Those who have received a complete examination are identified

generate examined = 1 if(ohdexsts == 1)
recode examined(. = 0)

** Teeth present
* The number of teeth present are calculated

forvalues i = 02/31 {
	if inlist(`i', 16, 17) continue
	local I : di %02.0f `i'
	foreach var of varlist ohx`I'tc {
			generate ohx`I'pres = 1 if(`var' == 1 | `var' == 2)
			recode ohx`I'pres(. = 0)
	}
}

egen teeth = rowtotal(ohx02pres-ohx31pres)

** Coronal caries
* The presence of coronal caries is identified

forvalues i = 02/31 {
	if inlist(`i', 16, 17) continue
	local I : di %02.0f `i'
	foreach var of varlist ohx`I'ctc {
			generate ohx`I'car = 1 if(`var' == "K" | `var' == "Z")
			recode ohx`I'car(. = 0)
	}
}

generate coronal = 0

forvalues i = 02/31 {
	if inlist(`i', 16, 17) continue
	local I : di %02.0f `i'
	foreach var of varlist ohx`I'car {
			replace coronal = 1 if(`var' == 1)
	}
}

** Root caries
* The presence of root caries is identified

generate root = 1 if(ohxrcar == 1)
replace root = 0 if(ohxrcar == 2)

label define diagnosis 0 "None" 1 "Caries"
label values root diagnosis

** Overall caries
* The presence of any caries is identified

generate caries = 1 if(coronal == 1 | root == 1)
replace caries = 0 if(coronal == 0 & root == 0)

label values caries diagnosis

****************************************************************************************************

*** Section 3: Data Analysis ***
** This section documents the formal statistical analyses **

** Weights
* Probability sampling weights, primary sampling units, and strata are provided

svyset [w=wtmecprp], psu(sdmvpsu) strata(sdmvstra)

** Age standardisation (US 2000 Census)
* Probability weights to allow for age-standardisation are provided

generate std_weight = 0.18370 if(age == 1)
replace std_weight = 0.21287 if(age == 2)
replace std_weight = 0.21590 if(age == 3)
replace std_weight = 0.15589 if(age == 4)
replace std_weight = 0.10245 if(age == 5)
replace std_weight = 0.12918 if(age == 6)

** Specifying cohort
* Those with no missing socio-demographic data, a full examination, and at least one tooth present are identified

generate inAnalysis = 1

foreach var of varlist age-bmi teeth caries coronal root {
	replace inAnalysis = 0 if(`var' == .)
}

replace inAnalysis = 0 if(examined != 1)
replace inAnalysis = 0 if teeth < 1

** Unweighted counts
* These are the raw counts of included parcipants

foreach var of varlist age-bmi {
	tabulate `var' inAnalysis
}

** Weighted counts
* These are the probability weighted counts of included participants

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): tabulate `var', count format(%11.3g)
}

** Weighted counts by any caries
* These are the probability weighted counts, grouped by the presence of any caries

svy, subpop(if inAnalysis == 1): tabulate caries, count se format(%11.3g)

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): tabulate `var' caries, count se format(%11.3g)
}

** Weighted counts by coronal caries
* These are the probability weighted counts, grouped by the presence of coronal caries

svy, subpop(if inAnalysis == 1): tabulate coronal, count se format(%11.3g)

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): tabulate `var' coronal, count se format(%11.3g)
}

** Weighted counts by root caries
* These are the probability weighted counts, grouped by the presence of root caries

svy, subpop(if inAnalysis == 1): tabulate root, count se format(%11.3g)

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): tabulate `var' root, count se format(%11.3g)
}

** Crude prevalence

** Any
* This is the non-standardised, probability weighted prevalence of any caries

svy, subpop(if inAnalysis == 1): proportion caries

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): proportion caries, over(`var')
}

** Coronal
* This is the non-standardised, probability weighted prevalence of coronal caries

svy, subpop(if inAnalysis == 1): proportion coronal

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): proportion coronal, over(`var')
}

** Root
* This is the non-standardised, probability weighted prevalence of root caries

svy, subpop(if inAnalysis == 1): proportion root

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): proportion root, over(`var')
}

** Standardised prevalence

** Any
* This is the age-standardised, probability weighted prevalence of any caries

svy, subpop(if inAnalysis == 1): proportion caries, stdize(age) stdweight(std_weight)

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): proportion caries, stdize(age) stdweight(std_weight) over(`var')
}

** Coronal
* This is the age-standardised, probability weighted prevalence of coronal caries

svy, subpop(if inAnalysis == 1): proportion coronal, stdize(age) stdweight(std_weight)

foreach var of varlist age-bmii {
	svy, subpop(if inAnalysis == 1): proportion coronal, stdize(age) stdweight(std_weight) over(`var')
}

** Root
* This is the age-standardised, probability weighted prevalence of root caries

svy, subpop(if inAnalysis == 1): proportion root, stdize(age) stdweight(std_weight)

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): proportion root, stdize(age) stdweight(std_weight) over(`var')
}

** Chi squared tests

** Any 
* This is the probability weighted chi squared test on socio-demographics against presence of any caries

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): tabulate caries `var', pearson
}

** Coronal
* This is the probability weighted chi squared test on socio-demographics against presence of coronal caries

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): tabulate coronal `var', pearson
}

** Root
* This is the probability weighted chi squared test on socio-demographics against presence of any root caries

foreach var of varlist age-bmi {
	svy, subpop(if inAnalysis == 1): tabulate root `var', pearson
}

