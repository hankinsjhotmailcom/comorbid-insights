# csv2other.pl
# Convert csv file to another delimeter

my $output_delim = shift;
# Default output delimeter is newline
if (!defined($output_delim)) { $output_delim = "\n"; }
# 
my $within_quotes = '';
while (<>)
{
  # Scan input one character at a time
  while (/(.)/g)
  {
    # Toggle within-quotes flag everytime we see a quote
    if ($1 eq '"') { $within_quotes = !$within_quotes; next; }
    # If we scanned a comma and we're not with quotations, print output delimeter 
    if (($1 eq ',') && (!$within_quotes)) { print "$output_delim"; }
    # Otherwise print what we scanned
    else { print $1;}
  }
}
