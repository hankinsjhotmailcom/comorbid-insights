# Pivot data such that
#     A B C
#     D B F
# becomes
#       B
#     A C
#     D F
#
# Column 2 moves to header

# Input csv file
input=$1

# Load row values
i=1
cat $input | cut -d, -f1 | sort -u > /tmp/_rows$$
while read x; do
  rows[i]=$x
  i=$((i+1))
done < /tmp/_rows$$

# Load column values
i=1
cat $input | cut -d, -f2 | sort -u > /tmp/_cols$$
while read x; do
  cols[i]=$x
  i=$((i+1))
done < /tmp/_cols$$

# Load row-column "cell" values
declare -A data
IFS=,
while read row col val; do
  data[${row}_${col}]=$val
done < $input

# Print header row
echo -n ,
for col in ${cols[@]}; do
  echo -n "$col,"
done
echo

# Print data rows
for row in ${rows[@]}; do
  echo -n "$row,"
  for col in ${cols[@]}; do
    echo -n "${data[${row}_${col}]},"
  done
  echo
done

