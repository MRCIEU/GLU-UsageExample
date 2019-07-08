* apps/stata14


***
*** This script generates the summaries of each GLU derived variable.
*** Shown in Supplementary table 5 of GLU paper.
***


*
** basic setup

clear
local testx="`1'"
local resDir : env RES_DIR
local dataDir : env PROJECT_DATA
log using "`resDir'/var-summaries-log-`testx'.txt", text replace

*
** import data

do loaddata "`dataDir'" "`testx'"

*list
summ

**
** plot hist of the number of valid days across participants

hist numvaliddays, name("vd") freq
graph export "`resDir'/hist-vd-`testx'.pdf", replace
graph drop _all


**
** variable summary - median and IQR

tempname memhold
postfile `memhold' str60 variable timepoint N median iqrL iqrU using "`resDir'/variable-summary-`testx'.dta" , replace

forvalues i=1/4 {

	summ meanaucperday if mytimepoint == `i', detail
	post `memhold' ("meanaucperday") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanaucperday_dt if mytimepoint == `i', detail
        post `memhold' ("meanaucperday_dt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')
	
	summ meanaucperday_nt if mytimepoint == `i', detail
        post `memhold' ("meanaucperday_nt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')
	
	summ meanmadperday if mytimepoint == `i', detail
	post `memhold' ("meanmadperday") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanmadperday_dt if mytimepoint == `i', detail
        post `memhold' ("meanmadperday_dt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ  meanmadperday_nt if mytimepoint == `i', detail
        post `memhold' ("meanmadperday_nt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meansgvpperday if mytimepoint == `i', detail
	post `memhold' ("meansgvpperday") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meansgvpperday_dt if mytimepoint == `i', detail
        post `memhold' ("meansgvpperday_dt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meansgvpperday_nt if mytimepoint == `i', detail
        post `memhold' ("meansgvpperday_nt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionlowperday if mytimepoint == `i', detail
        post `memhold' ("propLow") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionlowperday_dt if mytimepoint == `i', detail
        post `memhold' ("propLow_dt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionlowperday_nt if mytimepoint == `i', detail
        post `memhold' ("propLow_nt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionnormalperday if mytimepoint == `i', detail
        post `memhold' ("propNorm") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionnormalperday_dt if mytimepoint == `i', detail
        post `memhold' ("propNorm_dt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionnormalperday_nt if mytimepoint == `i', detail
        post `memhold' ("propNorm_nt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionhighperday if mytimepoint == `i', detail
        post `memhold' ("propHigh") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionhighperday_dt if mytimepoint == `i', detail
        post `memhold' ("propHigh_dt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanproportionhighperday_nt if mytimepoint == `i', detail
        post `memhold' ("propHigh_nt") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ meanfastingproxyperday if mytimepoint == `i', detail
        post `memhold' ("meanfastingproxyperday") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ mean_meal_timetopeak if mytimepoint == `i', detail
	post `memhold' ("mean_meal_timetopeak") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ mean_meal_pp1 if mytimepoint == `i', detail
	post `memhold' ("mean_meal_pp1") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

	summ mean_meal_pp2 if mytimepoint == `i', detail
	post `memhold' ("mean_meal_pp2") (`i') (`r(N)') (`r(p50)') (`r(p25)') (`r(p75)')

}


log close


postclose `memhold'


* results dta to csv
use "`resDir'/variable-summary-`testx'.dta", replace



* format numbers nicely and change to string
format median iqrL iqrU %5.3f
tostring median iqrL iqrU, replace usedisplayformat force

* format the estimate and ci into single string variable
gen result = median + " (" + iqrL + ", " + iqrU + ")"


outsheet using "`resDir'/variable-summary-`testx'.csv", replace


