
* convert id lists to DTA format 

local dataDir : env PROJECT_DATA

* some incorrect visit id's in the original data that need fixing so they match the id's in the CGM data
* this generated dta file is used is csvToDta.do

insheet using "`dataDir'/original/visitid-corrections.txt", comma names
save "`dataDir'/original/visitid-corrections.dta", replace

insheet using "`dataDir'/original/visitid-corrections-in-cgm.txt", clear comma names
save "`dataDir'/original/visitid-corrections-in-cgm.dta", replace

* one participant with has a second pregnancy, we remove this one in loaddata.do

insheet using "`dataDir'/original/second-pregnancy.txt", clear comma names
save "`dataDir'/original/second-pregnancy.dta", replace



