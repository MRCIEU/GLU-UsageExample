
local testx = "`2'"
local dataDir = "`1'"


****
* load the GLU summary variables, either:
* MAIN-PREG: complete days approach + pregnancy arg
* MAIN-NOPREG: complete days approach + no pregnancy arg    
* IMPUTED-PREG: approximal imputation approach + pregnancy arg  
* IMPUTED-NOPREG: approximal imputation approach + no pregnancy arg    

insheet using "`dataDir'/derived/cgm/glu-derived-all.csv", clear
rename userid visitid

* one incorrect visitids (it's early not last pregnancy)
merge m:1 visitid using "`dataDir'/original/visitid-corrections-in-cgm.dta"
replace visitid = changeto if changeto!=""
drop changeto _merge

**
** get number of women with CGM data, for paper text

gen personID = substr(visitid, 4, 6)
sort personID
by personID: gen dupx= cond(_N==1,0,_n)
di "Number of people with CGM samples"
count if dupx==1
di "`r(N)'"
drop dupx personID



keep if test == "`testx'"


****
* load additional variables needed for analyses

*rename userid visitid
merge 1:1 visitid using "`dataDir'/original/CGM_additional_variables_20180903.dta"

****
* reduce to valid sample and summarise numbers

count
di "Total number of CGM samples: `r(N)'"

** number of days across all participants
total numvaliddays
di "Total number of days across all participants: `e(N)'"

* remove with no valid days
drop if _merge ==2
count

* remove with no pheno data
drop if _merge ==1
drop _merge

* remove with no BMI value
drop if bmi == .


**** remove 1 sample from a second pregnancy
merge 1:1 visitid using "`dataDir'/original/second-pregnancy.dta"
* drop visit if has second pregnancy (i.e it's in this list)
drop if _merge == 3
drop _merge



* numbers for our final dataset
count
di "Number of CGM sequences in our dataset: `r(N)'"

by personID, sort: gen nvals = _n == 1
count if nvals
di "Number of people in our dataset: `r(N)'"

total numvaliddays
di "Total number of days across	all participants in our dataset: `e(N)'"



****
* recode some variables

replace mean_meal_timetopeak = "" if mean_meal_timetopeak == "NA"
destring mean_meal_timetopeak, replace
replace	mean_meal_pp1 = "" if mean_meal_pp1 == "NA"
destring mean_meal_pp1, replace
replace mean_meal_pp2 = "" if mean_meal_pp2 == "NA"
destring mean_meal_pp2, replace



****
* derive timepoint from visit ID
* time points are determined by first 3 digits of visit ID

gen mytimepoint = .
replace mytimepoint = 1 if strpos(visitid, "272") == 1
replace mytimepoint = 2 if strpos(visitid, "273") == 1
replace mytimepoint = 3 if strpos(visitid, "278") == 1
replace mytimepoint = 4 if strpos(visitid, "279") == 1

* odd time point where VisitID isn't in right format
list timepoint1 if mytimepoint ==.
replace mytimepoint = timepoint1 if mytimepoint ==.

tab mytimepoint




****
* fix format of some variables

recast float meanproportionhighperday
recast float ageyears
recast float bmi
recast float parity



****
* summarise our final dataset

summ

