#!/bin/bash
#PBS -l walltime=4:00:00,nodes=1:ppn=1
#PBS -o output.file
#---------------------------------------------

date

module add languages/R-3.4.1-ATLAS

cd $PBS_O_WORKDIR

export PROJECT_DATA="${HOME}/2016-alspac-new-measures/data"

Rscript run-generic.R main nopreg

date

