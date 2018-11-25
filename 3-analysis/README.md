



## Make combined GLU dataset

Combine the pregnancy / no pregnancy and 'complete days' / 'approximally imputed' versions of the derived data.

```bash
Rscript makeGLUDerivedDataset.r
```



## Time point summary (supplementary table 3)

Summarise the number of participants with each combination of time points.

```bash
stata -b timepointSummaryAll.do
```



## Variable summaries (supplementary table 5)

Summarise the GLU summary variables across the four timepoints.

```bash
stata -b variableSummariesAll.do
```



## Example analysis

We first convert our phenotype file (containing BMI and confounders) from a CSV to a Stata DTA file.

```bash
stata -b csvToDta.do
```

We then run our analysis, generating the results of associations with BMI (for supplementary table 6).

This script also generates the correlations for supplementary table 4 (see log file).

```bash
stata -b basicAnalysisAll.do
```

Then we plot the results (figure 2 in the main paper).

```bash
matlab -r plotResultsAll
```











