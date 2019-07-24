# Usage example for the GLU tool

[GLU](https://github.com/MRCIEU/GLU) is a tool for analysing continuous glucose monitoring (CGM) data in epidemiology.

This repository contains the code for the usage example described in the paper:

Millard, LAC, et al. GLU: A tool for analysing continuously measured glucose in epidemiology, bioRxiv, 2018

## Environment details

I use Stata v15 and R version 3.3.1-ATLAS.

The code uses some environment variables that need to be set in your linux environment.

I set the results, project data and GLU directories temporarily with:

```bash
export RES_DIR="${HOME}/2016-alspac-new-measures/results"
export PROJECT_DATA="${HOME}/2016-alspac-new-measures/data"
export GLU="${HOME}/2016-alspac-new-measures/code/GLU"
```



## Medtronic data files pre-processing


```bash
cd $GLU
sh mainConvertFileFormat.sh ${PROJECT_DATA}/original/cgm/ ${PROJECT_DATA}/derived/cgm/
```

## Generating variables with GLU

Generate variables using complete days approach - run jobs in the `1-run-glu` directory.

```bash
qsub jobmain-preg.sh
qsub jobmain-nopreg.sh
```

Generate variables using approximally imputed approach - run jobs in the `2-run-glu-impute` directory.

```bash
qsub jobimpute-preg.sh
qsub jobimpute-nopreg.sh
```


## Example analysis with BMI

See `3-analysis` directory.


## Example plots and summaries

In `4-examples` directory, run:

```bash
sh runGLUforday.sh
```


