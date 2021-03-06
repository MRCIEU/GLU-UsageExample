
* convert phenotype data (containing BMI and confounders) from CSV to DTA format

local dataDir : env PROJECT_DATA

insheet using "`dataDir'/original/CGM_additional_variables_20180903.csv"

gen personID = substr(visitid, 4, 6)
gen noqletID = substr(visitid, 1, 9)


* some incorrect visitids

merge 1:1 visitid using "`dataDir'/original/visitid-corrections.dta"
replace visitid = changeto if changeto!=""
drop changeto _merge


* one person had an incorrect timepoint (2 rather than 1)

replace timepoint1 = 1 if gestation!=. & gestation<28 & timepoint1==2 & timepoint2==.

save "`dataDir'/original/CGM_additional_variables_20180903.dta", replace




