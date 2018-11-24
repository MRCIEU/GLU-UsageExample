#!/bin/bash
#PBS -l walltime=4:00:00,nodes=1:ppn=1
#PBS -o output-imp-nopreg.file
#---------------------------------------------

date

module add languages/R-3.3.3-ATLAS

export GLU="${HOME}/2016-alspac-new-measures/code/GLU/R"
export PROJECT_DATA="${HOME}/2016-alspac-new-measures/data"

cd $GLU

Rscript runGLU.R --indir=$PROJECT_DATA/derived/cgm/sequences/ --outdir=$PROJECT_DATA/derived/cgm/imputed-nopreg/ --impute --save

date

