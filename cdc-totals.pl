# cdc-totals.pl

my $cdc_file = shift;
# Each row in cdc comorbid file contains a month's data.  Supply a filter, like 'United States,2018' to get U.S. totals for every month in 2018.
my $filter = shift;
my $year = `echo $filter | cut -d, -f2`;
chomp $year;

# Print totals using column #s (7-17) instead of column names
for (7..17)
{
  my $n = `grep "$filter" $cdc_file | cut -d, -f$_ | awk '{sum+=\$0}END{print sum}'`;
  print "$_,$year,$n";
}
