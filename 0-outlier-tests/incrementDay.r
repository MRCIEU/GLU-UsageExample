incrementDay <- function(time) {

        timeNew = as.POSIXlt(time + 60*60*24)

        ## hour changes if the clocks change
        if (timeNew$hour!=time$hour) {
                # mon+1 because retrieved zero based but set 1-based
                t2str = paste(timeNew$mday, "/", timeNew$mon+1, "/" , year(timeNew), " ", time$hour, ":", timeNew$min, sep="")
                timeNew = strptime(t2str, format='%d/%m/%Y %H:%M')
        }

        return(timeNew)
}


