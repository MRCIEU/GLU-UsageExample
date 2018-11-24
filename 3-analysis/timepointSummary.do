* apps/stata14

*
** paths to results and data directories

local resDir : env RES_DIR
local dataDir : env PROJECT_DATA

*
** import data


* get data - we use only 1 version 

local testx="`1'"

do loaddata "`dataDir'" "`testx'"
replace timepoint1 = mytimepoint


log using "`resDir'/timepointSummary`testx'.txt", text replace

tempname memhold
postfile `memhold' str60 timepoints freq  using "`resDir'/timepoint-summary-`testx'.dta" , replace


****
**** count number of participants at each time point

count if timepoint1 == 1
count if timepoint1 == 2
count if timepoint1 == 3
count if timepoint1 == 4




****
**** count number of participants with each combination of time point

sort personID timepoint1
by personID: gen dup=_N


* only 1 time point
count if dup == 1
post `memhold' ("1 timepoint") (`r(N)')

count if dup == 1 & timepoint1 == 1
post `memhold' ("timepoint 1 only") (`r(N)') 
count if dup == 1 & timepoint1 == 2
post `memhold' ("timepoint 2 only") (`r(N)')
count if dup == 1 & timepoint1 == 3
post `memhold' ("timepoint 3 only") (`r(N)')
count if dup == 1 & timepoint1 == 4
post `memhold' ("timepoint 4 only") (`r(N)')

* 2 time points
qui:count if dup == 2
local num2 = `r(N)'/2
di "Number of participants with	2 timepoints: `num2'"
post `memhold' ("2 timepoints") (`num2')


* 3 time points
qui:count if dup == 3
local num3 = `r(N)'/3
di "Number of participants with 3 timepoints: `num3'"
post `memhold' ("3 timepoints") (`num3')

list visitid timepoint* dup
count if timepoint1==2 & dup==1
count if timepoint1==2 & dup==2
count if timepoint1==2 & dup==3
count if timepoint1==2 & dup==4


* how many of each combination of 2 timepoints

by personID: gen dupx= cond(_N==1,0,_n)

keep if dup == 2
keep timepoint1 personID dupx

reshape wide timepoint1, i(personID) j(dupx)
list

count if timepoint11 == 1 & timepoint12 == 2
post `memhold' ("timepoints 1 and 2 only") (`r(N)')
count if timepoint11 == 1 & timepoint12 == 3
post `memhold' ("timepoints 1 and 3 only") (`r(N)')
count if timepoint11 == 1 & timepoint12 == 4
post `memhold' ("timepoints 1 and 4 only") (`r(N)')
count if timepoint11 == 2 & timepoint12 == 3
post `memhold' ("timepoints 2 and 3 only") (`r(N)')
count if timepoint11 == 2 & timepoint12 == 4
post `memhold' ("timepoints 2 and 4 only") (`r(N)')
count if timepoint11 == 3 & timepoint12 == 4
post `memhold' ("timepoints 3 and 4 only") (`r(N)')



log close
postclose `memhold'


* results dta to csv
use "`resDir'/timepoint-summary-`testx'.dta", replace
outsheet using "`resDir'/timepoint-summary-`testx'.csv", replace
