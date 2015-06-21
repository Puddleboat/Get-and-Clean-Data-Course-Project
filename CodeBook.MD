# Getting and Cleaning Data
# Course Project

## Code Book

## Description of Variables

The script `run_analysis.R`performs the 5 steps described in the course project's definition.

* First, all the matching data is merged using the `rbind()` function. With the same methoed the files having the same number of columns which contain correlating data.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `averages_data.txt`, and uploaded to this repository.

## Variables

* `xtrain`, `ytrain`, `xtest`, `ytest`, `subjecttrain` and `subjecttest` contain the data from the downloaded files.
* `xdata`, `ydata` and `subjectdata` merge the previous datasets to further analysis.
* `features` contains the correct names for the `xdata` dataset, which are applied to the column names stored in `meanstdfeatures`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `alldata` merges `xdata`, `ydata` and `subjectdata` in a big dataset.
* Finally, `averagesdata` contains the relevant averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()` and ease the development.