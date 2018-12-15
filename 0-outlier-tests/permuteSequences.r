source('incrementDay.r')

set.seed(1234)

datadir=Sys.getenv('PROJECT_DATA')
indir=paste(datadir, '/derived/cgm/sequences/', sep='')
outdir=paste(datadir, '/derived/cgm/sequences-permuted/', sep='')

nightstart = strptime('23:00', format='%H:%M')

timeFormat ="%d/%m/%y %H:%M:%S"


files = list.files(indir, pattern="data_export-.*\\..*")

for (f in files) {

	print(f)

	rawData <- read.table(paste(indir,f,sep=""), sep="\t", header=1)

	colname="Sensor.Glucose..mmol.L."
	idxSGReading = which(names(rawData) == colname)
	names(rawData)[idxSGReading]="sgReading"

	rawData$time = rawData$Timestamp
	rawData$time = strptime(rawData$time, format=timeFormat)

	nightstartX = nightstart
	library(data.table)

	## first time to consider is the first recorded sensor glucose reading (so we have a complete trajectory - i.e. we cannot interpolate before if no previous SG values)
	idxStart=1
	timestart = rawData$time[idxStart]
	timeend = rawData$time[nrow(rawData)]

	##
	## get day and night start time for this day, assuming night-to-day transition is the day after the day-to-night transition

	# month is zero-based
	t1str = paste(timestart$mday, "/", timestart$mon+1, "/" , year(timestart), " ", nightstart$hour, ":", nightstart$min, sep="")
	thisDayToNight = strptime(t1str, format='%d/%m/%Y %H:%M')


	# if cgm doesn't start until after day-to-night threshold then update thresholds to next day
	if (rawData$time[idxStart]>thisDayToNight) {
		thisDayToNight = incrementDay(thisDayToNight)
	}


	## get all times on current day
	## then move to next day

	ixStart=0

	while(thisDayToNight<timeend) {

		####
		#### get indexes of current day

		ixx = which(rawData$time<=thisDayToNight)

		# get only those that aren't in previous days
		ix = ixx[which(ixx>ixStart)]

		ixxx = which(!is.na(rawData$sgReading[ix]))
		ix = ix[ixxx]

		if (length(ix) >=2) {

			#### do permutation
			####

			rand1 = runif(1, 1, length(ix))
			rand2 =	runif(1, 1, length(ix))	
			sg1 = rawData$sgReading[ix[rand1]]
			sg2 = rawData$sgReading[ix[rand2]]

			# resample until the two sg readings we are swapping are sufficiently different
			count=1
			while (abs(sg1 - sg2) < 1) {

				if (count>100) {
					print('BREAK')
					break
				}

				rand1 =	runif(1, 1, length(ix))
		                rand2 = runif(1, 1, length(ix))
				sg1 = rawData$sgReading[ix[rand1]]
		                sg2 = rawData$sgReading[ix[rand2]]

				count=count+1
			}

			rawData$sgReading[ix[rand1]] = sg2
			rawData$sgReading[ix[rand2]] = sg1

		}

		####
		#### move to next day

                thisDayToNight = incrementDay(thisDayToNight)

		if (length(ix)>0) {
	                ixStart = max(ix)
		}
	}

	# change back sgReading column name
	names(rawData)[idxSGReading]=colname

	# remove time column we made
	rawData$time = NULL

	write.table(rawData, paste(outdir,f,sep=""), sep="\t", row.names=FALSE, quote=FALSE)

}




