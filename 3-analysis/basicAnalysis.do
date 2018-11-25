* apps/stata14

***
*** This script estimates the relationship between each GLU derived variable and maternal BMI.
*** Shown in Figure 2 and Supplementary table 6 of GLU paper.
***


*
** paths to results and data directories


local analysis="`1'"
local sensitivity="`2'"


global resDir : env RES_DIR
local dataDir : env PROJECT_DATA

log using "$resDir/log-`analysis'.txt", text replace

*
** import data

do loaddata "`dataDir'" "`analysis'"


summ

**
** plot hist of the number of valid days across participants

hist numvaliddays, name("vd") freq
graph export "$resDir/hist-vd-`analysis'.pdf", replace
graph drop _all



**
** transform some of the CGM characteristics

gen meanmadperdayLog = log(meanmadperday)
gen meanmadperday_dtLog = log(meanmadperday_dt)
gen meanmadperday_ntLog = log(meanmadperday_nt)

gen meansgvpperdayLog = log(meansgvpperday)
gen meansgvpperday_dtLog = log(meansgvpperday_dt)
gen meansgvpperday_ntLog = log(meansgvpperday_nt)

gen mean_meal_timetopeakLog = log(mean_meal_timetopeak)


* scale to the number of minutes in the time period
replace meanproportionnormalperday = meanproportionnormalperday*1440
replace meanproportionnormalperday_dt = meanproportionnormalperday_dt*990
replace meanproportionnormalperday_nt = meanproportionnormalperday_nt*450
replace meanproportionlowperday = meanproportionlowperday*1440
replace meanproportionlowperday_dt = meanproportionlowperday_dt*990
replace meanproportionlowperday_nt = meanproportionlowperday_nt*450
replace meanproportionhighperday = meanproportionhighperday*1440
replace meanproportionhighperday_dt = meanproportionhighperday_dt*990
replace meanproportionhighperday_nt = meanproportionhighperday_nt*450


summ 


**
** keep only participants with pregnancy time points

keep if mytimepoint == 1 | mytimepoint == 2

summ


**
** keep first timepoint of each participant if they have both pregnancy timepoints

sort personID mytimepoint
quietly by personID:  gen dup = cond(_N==1,0,_n)

tab dup

* main analysis keep early timepoint, sensitivity keep later timepoint
if "`sensitivity'"=="0" {
	drop if dup==1
} 
else { 
	drop if dup==2
}


summ


*
** correlations for supplement
pwcorr meanaucperday meanmadperday meansgvpperday meanproportionlowperday meanproportionnormalperday meanproportionhighperday meanfastingproxyperday mean_meal_timetopeak mean_meal_pp1 mean_meal_pp2, sig
*pwcorr meannumpeaksperday meanaucperday meanmadperday meangvpperday meansgvpperday meanproportionlowperday meanproportionnormalperday meanproportionhighperday meanfastingproxyperday mean_meal_timetopeak mean_meal_pp1 mean_meal_pp2, sig


* checking flipping of correlations for gvp vs sgvp
*regress meanfastingproxyperday meangvpperday
*regress meanfastingproxyperday meangvpperday meanmadperday
*regress meanfastingproxyperday meansgvpperday

* plotting num peaks vs MAD
*graph twoway scatter meanmadperday meannumpeaksperday
*graph export "scatter-mad-numpeaks-`analysis'.pdf", replace
*graph drop _all



*
** plot histograms to check distributions

local outcomes "meanmadperday meanmadperdayLog meanmadperday_dtLog meanmadperday_ntLog meanproportionlowperday meanproportionnormalperday meanproportionhighperday meanaucperday meansgvpperday age parity meansgvpperdayLog meanfastingproxy mean_meal_timetopeak mean_meal_timetopeakLog mean_meal_pp1 mean_meal_pp2"

foreach myvar in `outcomes' {
	di "`myvar'"
        hist `myvar', name("myhist") bin(7)
        graph export "$resDir/hist-`myvar'-`analysis'-`sensitivity'.pdf", replace
        graph drop _all
}



tempname memhold
postfile `memhold' str60 field str60 test n estimate lower upper  using "$resDir/res-`analysis'-`sensitivity'.dta" , replace



*
** bmi analysis


* AUC - normally distributed
do doLinearRegression "meanaucperday" "`analysis'" "`memhold'" 0
do doLinearRegression "meanaucperday_dt" "`analysis'" "`memhold'" 0
do doLinearRegression "meanaucperday_nt" "`analysis'" "`memhold'" 0

* meanfastingproxy
do doLinearRegression "meanfastingproxy" "`analysis'" "`memhold'" 0


* time in hypo- normo- and hyper- glycemia

do doNBreg "meanproportionlowperday" "`analysis'" "`memhold'"
do doNBreg "meanproportionlowperday_dt" "`analysis'" "`memhold'"
do doNBreg "meanproportionlowperday_nt" "`analysis'" "`memhold'"
do doNBreg "meanproportionnormalperday" "`analysis'" "`memhold'"
do doNBreg "meanproportionnormalperday_dt" "`analysis'" "`memhold'"
do doNBreg "meanproportionnormalperday_nt" "`analysis'" "`memhold'"
do doNBreg "meanproportionhighperday" "`analysis'" "`memhold'"
do doNBreg "meanproportionhighperday_dt" "`analysis'" "`memhold'"
do doNBreg "meanproportionhighperday_nt" "`analysis'" "`memhold'"



* MAD - right skewed
do doLinearRegression "meanmadperdayLog" "`analysis'" "`memhold'" 1
do doLinearRegression "meanmadperday_dtLog" "`analysis'" "`memhold'" 1
do doLinearRegression "meanmadperday_ntLog" "`analysis'" "`memhold'" 1

* try without log transforming and check residuals
*do doLinearRegression "meanmadperday" "`analysis'" "`memhold'"



* sGVP
do doLinearRegression "meansgvpperdayLog" "`analysis'" "`memhold'" 1
do doLinearRegression "meansgvpperday_dtLog" "`analysis'" "`memhold'" 1
do doLinearRegression "meansgvpperday_ntLog" "`analysis'" "`memhold'" 1

* try without log transforming and check residuals
*do doLinearRegression "meansgvpperday" "`analysis'" "`memhold'"



* Postprandial time to peak
do doLinearRegression "mean_meal_timetopeakLog" "`analysis'" "`memhold'" 1


* Postprandial 1 and 2 hour AUC
do doLinearRegression "mean_meal_pp1" "`analysis'" "`memhold'" 0
do doLinearRegression "mean_meal_pp2" "`analysis'" "`memhold'" 0





log close
postclose `memhold' 




*****
***** formatting the results into a CSV

* read in dta of results
use $resDir/res-`analysis'-`sensitivity'.dta, clear

desc


* create a variable denoting if the result is unadjusted versus adjusted
tab test
gen jj=0
replace jj=1 if substr(test,length(test)-3, length(test))=="-adj"

list field jj test

* format numbers nicely and change to string
format estimate lower upper %5.3f
tostring estimate lower upper, replace usedisplayformat force
list estimate lower upper in 1/10

* format the estimate and ci into single string variable
gen result = estimate + " [" + lower + ", " + upper + "]"
*drop estimate lower upper

* reshape so estimates for unadjusted and adjusted are side by side for each GLU variable
reshape wide n test result estimate lower upper, i(field) j(jj)

rename result0 resultUnadj
rename result1 resultAdj

outsheet field test0 test1 n0 n1 estimate0 lower0 upper0 estimate1 lower1 upper1 resultUnadj resultAdj using $resDir/res-`analysis'-`sensitivity'.csv, replace noquote

