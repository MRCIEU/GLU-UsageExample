
####
#### This script combines all the GLU derived variables into a single CSV

dataDir=Sys.getenv('PROJECT_DATA')

cgmderivedir=paste(dataDir, '/derived/cgm/', sep='')

##
## files containing each version of GLU derived data we generate

mainPregFile=paste(cgmderivedir, 'main-preg/cgmSummaryVerbose.csv', sep='')
mainNoPregFile=paste(cgmderivedir, 'main-nopreg/cgmSummaryVerbose.csv', sep='')
imputedPregFile=paste(cgmderivedir, 'imputed-preg/cgmSummaryVerbose-imputed.csv', sep='')
imputedNoPregFile=paste(cgmderivedir, 'imputed-nopreg/cgmSummaryVerbose-imputed.csv', sep='')


##
## read in each version of derived data

mp = read.table(mainPregFile, header=1, sep=',')
mp$test='MAIN-PREG'

mnp = read.table(mainNoPregFile, header=1, sep=',')
mnp$test='MAIN-NOPREG'

ip = read.table(imputedPregFile, header=1, sep=',')
ip$test='IMPUTED-PREG'

inp = read.table(imputedNoPregFile, header=1, sep=',')
inp$test='IMPUTED-NOPREG'


##
## combine into a single data file

allDerived = rbind(mp, mnp, ip, inp)

outfile=paste(cgmderivedir, 'glu-derived-all.csv', sep='')
write.table(allDerived, outfile, row.names=FALSE, sep=',')



