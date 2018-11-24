
export EXAMPLE_DATA="${HOME}/2016-alspac-new-measures/code/GLU_UsageExample/4-examples/data"

cd $GLU/R


##
## examples for supplmementary figure 6, demonstrating summary variables derived by GLU

Rscript runGLU.R --indir=$EXAMPLE_DATA/in/ --pregnancy --outdir=$EXAMPLE_DATA/out/ --save --filename=data_export-999998-day2.csv

# impute example
Rscript runGLU.R --indir=$EXAMPLE_DATA/in/ --pregnancy --outdir=$EXAMPLE_DATA/out/ --save --filename=data_export-9999981-day1-impute.csv --impute

##
## example for supplementary figure 1, with missing values to demonstrate preprocessing and approximal imputation

Rscript runGLU.R --indir=$EXAMPLE_DATA/in/ --pregnancy --outdir=$EXAMPLE_DATA/out/ --save --filename=data_export-9999981-day1-impute-preprocess-example.csv --impute
