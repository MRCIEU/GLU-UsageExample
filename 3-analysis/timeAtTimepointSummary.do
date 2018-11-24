

* Get median, iqr, range of the number of weeks gestation / postnatal.
* This is for the text in the GLU paper.


local dataDir : env PROJECT_DATA


do loaddata "`dataDir'" "MAIN-PREG"

summ gestation if mytimepoint == 1, detail

summ gestation if mytimepoint == 2, detail



* summarise number of weeks postnatal for timepoints 3 and 4


summ num_weeks_postnatal if mytimepoint == 3, detail

summ num_weeks_postnatal if mytimepoint == 4, detail

