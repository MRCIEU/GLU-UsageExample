local outcome="`1'"
local analysis="`2'"
local memhold="`3'"
local logged="`4'"



* unadjusted model

regress `outcome' bmi, vce(robust)
local beta _b[bmi]
local ciL _b[bmi] - 1.96 * _se[bmi]
local ciU _b[bmi] + 1.96 * _se[bmi]


if "`logged'"=="1" {

	local beta = 100*(exp(`beta')-1)
	local ciL = 100*(exp(`ciL')-1)
	local ciU = 100*(exp(`ciU')-1)
	post `memhold' ("`outcome'LOG") ("`analysis'") (`e(N)') (`beta') (`ciL') (`ciU')
}
else {
	post `memhold' ("`outcome'") ("`analysis'") (`e(N)') (`beta') (`ciL') (`ciU')
}

predict double resid, residuals
hist resid, name("resid") bin(10)
graph export "$resDir/hist-`outcome'-`analysis'-residuals.pdf", replace
graph drop _all
drop resid


* adjusted model

regress `outcome' bmi gestation age parity, vce(robust)
local beta _b[bmi]
local ciL _b[bmi] - 1.96 * _se[bmi]
local ciU _b[bmi] + 1.96 * _se[bmi]

if "`logged'"=="1" {

        local beta = 100*(exp(`beta')-1)
        local ciL = 100*(exp(`ciL')-1)
        local ciU = 100*(exp(`ciU')-1)
        post `memhold' ("`outcome'LOG") ("`analysis'-adj") (`e(N)') (`beta') (`ciL') (`ciU')
}
else {
	post `memhold' ("`outcome'") ("`analysis'-adj") (`e(N)') (`beta') (`ciL') (`ciU')
}

predict double resid, residuals
hist resid, name("resid") bin(10)
graph export "$resDir/hist-`outcome'-`analysis'-adj-residuals.pdf", replace
graph drop _all
drop resid
