


* associations with maternal BMI for data collected in pregnancy only

**
** complete days analysis

do basicAnalysis.do "MAIN-PREG" 0
do basicAnalysis.do "MAIN-PREG" 1

**
** impute approximal analysis

do basicAnalysis.do "IMPUTED-APPROX-PREG" 0
do basicAnalysis.do "IMPUTED-APPROX-PREG" 1

**
** impute other day analysis

do basicAnalysis.do "IMPUTED-OTHER-PREG" 0
do basicAnalysis.do "IMPUTED-OTHER-PREG" 1




