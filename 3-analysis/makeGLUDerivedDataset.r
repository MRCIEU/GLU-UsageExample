
####
#### This script combines all the GLU derived variables into a single CSV

dataDir=Sys.getenv('PROJECT_DATA')

cgmderivedir=paste(dataDir, '/derived/cgm/', sep='')

##
## files containing each version of GLU derived data we generate

mainPregFile=paste(cgmderivedir, 'main-preg/cgmSummaryVerbose.csv', sep='')
mainNoPregFile=paste(cgmderivedir, 'main-nopreg/cgmSummaryVerbose.csv', sep='')

imputedPregFile=paste(cgmderivedir, 'imputed-preg/cgmSummaryVerbose-impute-approximal.csv', sep='')
imputedNoPregFile=paste(cgmderivedir, 'imputed-nopreg/cgmSummaryVerbose-impute-approximal.csv', sep='')

imputedOtherPregFile=paste(cgmderivedir, 'imputedother-preg/cgmSummaryVerbose-impute-other.csv', sep='')
imputedOtherNoPregFile=paste(cgmderivedir, 'imputedother-nopreg/cgmSummaryVerbose-impute-other.csv', sep='')

##
## read in each version of derived data

mp = read.table(mainPregFile, header=1, sep=',')
mp$test='MAIN-PREG'

mnp = read.table(mainNoPregFile, header=1, sep=',')
mnp$test='MAIN-NOPREG'

ip = read.table(imputedPregFile, header=1, sep=',')
ip$test='IMPUTED-APPROX-PREG'

inp = read.table(imputedNoPregFile, header=1, sep=',')
inp$test='IMPUTED-APPROX-NOPREG'


iop = read.table(imputedOtherPregFile, header=1, sep=',')
iop$test='IMPUTED-OTHER-PREG'

ionp = read.table(imputedOtherNoPregFile, header=1, sep=',')
ionp$test='IMPUTED-OTHER-NOPREG'




##
## combine into a single data file

allDerived = rbind(mp, mnp, ip, inp, iop, ionp)

outfile=paste(cgmderivedir, 'glu-derived-all.csv', sep='')
write.table(allDerived, outfile, row.names=FALSE, sep=',')





