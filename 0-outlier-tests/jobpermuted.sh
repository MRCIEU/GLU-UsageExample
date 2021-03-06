#!/bin/bash
#PBS -l walltime=4:00:00,nodes=1:ppn=1
#PBS -o output-perm5sd.file
#---------------------------------------------

date

module add languages/R-3.3.3-ATLAS

export GLU="${HOME}/2016-alspac-new-measures/code/GLU/R"
export PROJECT_DATA="${HOME}/2016-alspac-new-measures/data"

cd $GLU

Rscript runGLU.R --indir=$PROJECT_DATA/derived/cgm/sequences-permuted2/ --pregnancy --outdir=$PROJECT_DATA/derived/cgm/glu-out-permuted5sd2/ --save

date

