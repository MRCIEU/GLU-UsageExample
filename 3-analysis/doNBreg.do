local outcome="`1'"
local analysis="`2'"
local memhold="`3'"


* unadjusted model

*capture {
nbreg `outcome' bmi, irr
local beta _b[bmi]
local ciL _b[bmi] - 1.96 * _se[bmi]
local ciU _b[bmi] + 1.96 * _se[bmi]
local beta = 100*(exp(`beta')-1)
local ciL = 100*(exp(`ciL')-1)
local ciU = 100*(exp(`ciU')-1)
post `memhold' ("`outcome'") ("`analysis'") (`e(N)') (`beta') (`ciL') (`ciU')

*}

* adjusted model

*capture {
nbreg `outcome' bmi gestation age parity, irr
local beta _b[bmi]
local ciL _b[bmi] - 1.96 * _se[bmi]
local ciU _b[bmi] + 1.96 * _se[bmi]
local beta = 100*(exp(`beta')-1)
local ciL = 100*(exp(`ciL')-1)
local ciU = 100*(exp(`ciU')-1)
post `memhold' ("`outcome'") ("`analysis'-adj") (`e(N)') (`beta') (`ciL') (`ciU')
*}

