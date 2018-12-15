
# Tests to determine best threshold for outlier detection


## Create artificial outlier data

Create permuted version of our ALSPAC-G2 data.
This swaps two points in each day, that have at least a 1mmol/L difference.

```bash
sh permuteSequences.sh
```


## Run GLU on artificial outlier data

```bash
qsub jobpermuted.sh
```





