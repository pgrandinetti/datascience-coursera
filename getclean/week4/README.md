## Getting and Cleaning Data - Course Project

This file is shipped as part of the final assignment for the John Hopkins University class _Getting and Cleaning Data_ (offered via Coursera).

Usage of the code in this repository is subject to the Coursera Honor Code.


# Assignment explained

The course project is divided into five steps, that correspond to five different sections in the script `run_analysis.R`.

  1. Part I loads two different data sets (training and test set) from the disk and merge them in a single data.table structure.
  2. Part II takes the output of Part I and extracts from it the columns corresponding to either _std_ or _mean_ operations, by using regex.
  3. Part III uses the training and test labels, along with their descriptive name, loads both from disk and matches each entry with the related name.
  4. PART IV labels the data set computed in Part II with the descriptive names computed in Part III.
  5. Part V builds a tidy data set by extracting average values of each column for the groups identified by the pair (activity, subject).

Two more points are worth noticing:

  - Part I preceded by the settings about the path to the data in the disk, and can be modified by the user in order to reproduce the analysis.
  - To reproduce the entire analysis in 1-click, the script can be run with `source("run_analysis.R")`, and it will store the resulting data set into a file indicated by the variable `fOut` (created at the top of the script, currently set to `./result.txt`).
