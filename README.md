# comorbid-insights

# Description

# Installation

# Usage

## Aggregate and unpivot 2018-2020 data from CDC files
./sum_unpivot.pl > _comorbids_unpivot.csv

# Create file to store CDC column names
head -1 2014-2018.csv | ./csv2other.pl | (i=1; while read l; do echo $i $l; i=$((i+1)); done) > headers.txt

# Move the date column to column 1 (as req'd by shell script in next step)
cat _comorbids_unpivot.csv | awk 'BEGIN{FS=",";OFS=","}{print $2,$1,$3}' > _comorbids_unpivot2.csv

# Pivot data and restore CDC column names
./pivot.sh _comorbids_unpivot2.csv | (IFS=,; while read col x y z; do colname=`grep "^$col " headers.txt`; echo -e "$colname\t$x\t$y\t$z"; done)  > comorbids.tsv

# Manually load comorbids.tsv into spreadsheet.  (This step could generate an HTML table instead and display it on a page.)

