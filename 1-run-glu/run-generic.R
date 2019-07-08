


args = commandArgs(trailingOnly=TRUE)

print(args[1])
print(args[2])

datadir=Sys.getenv('PROJECT_DATA')


## install glu from GitHub
#library(devtools)
#install_github("MRCIEU/GLU")


# load GLU
library('GLU')


# run GLU
indirx=paste0(datadir, '/original/cgm/')


if (args[1] == 'main') {
	if (args[2] == 'preg') {
		outdirx=paste0(datadir, '/derived/cgm/main-preg/')
		runGLUForDirectory(indir=indirx, outdir=outdirx, save=TRUE, pregnancy=TRUE)
	}
	else {
		outdirx=paste0(datadir, '/derived/cgm/main-nopreg/')
		runGLUForDirectory(indir=indirx, outdir=outdirx, save=TRUE, pregnancy=FALSE)
	}
} else if (args[1] == 'imputeother') {
	if (args[2] == 'preg') {
		outdirx=paste0(datadir, '/derived/cgm/imputedother-preg/')
		runGLUForDirectory(indir=indirx, outdir=outdirx, save=TRUE, pregnancy=TRUE, imputeOther=TRUE)
	}
	else {
		outdirx=paste0(datadir, '/derived/cgm/imputedother-nopreg/')
		runGLUForDirectory(indir=indirx, outdir=outdirx, save=TRUE, pregnancy=FALSE, imputeOther=TRUE)
	}
} else {
	if (args[2] == 'preg') {
		outdirx=paste0(datadir, '/derived/cgm/imputed-preg/')
		runGLUForDirectory(indir=indirx, outdir=outdirx, save=TRUE, pregnancy=TRUE, imputeApproximal=TRUE)
	}
	else {
		outdirx=paste0(datadir, '/derived/cgm/imputed-nopreg/')
		runGLUForDirectory(indir=indirx, outdir=outdirx, save=TRUE, pregnancy=FALSE, imputeApproximal=TRUE)
	}
}

