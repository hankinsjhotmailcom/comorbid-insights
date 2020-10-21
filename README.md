### comorbid-insights

## Description
A transformation (pivot) of CDC comorbidity data using shell scripting.

## Usage

#### Download CDC data files
2014-2018
https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/3yf8-kanr

2019-2020
https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/muzy-jte6

#### Total and extract CDC data for 2018-2020 using column numbers
(perl cdc-totals.pl Weekly_Counts_of_Deaths_by_State_and_Select_Causes__2014-2018.csv 'United States,2018'; perl cdc-totals.pl Weekly_Counts_of_Deaths_by_State_and_Select_Causes__2019-2020.csv 'United States,2019'; perl cdc-totals.pl Weekly_Counts_of_Deaths_by_State_and_Select_Causes__2019-2020.csv 'United States,2020') > temp.csv

#### Create file mapping CDC column names to column numbers
head -1 Weekly_Counts_of_Deaths_by_State_and_Select_Causes__2019-2020.csv | perl csv2other.pl | (i=1; while read l; do echo $i $l; i=$((i+1)); done) > headers.txt

#### Pivot data and restore CDC column names
bash pivot.sh temp.csv | (IFS=,; while read col x y z; do colname=`grep "^$col " headers.txt`; echo -e "$colname\t$x\t$y\t$z"; done)  > comorbids.tsv

Load comorbids.tsv into spreadsheet.

