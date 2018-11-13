#!/usr/bin/perl

$infile=$ARGV[0];

open(IN,"$infile") or die "Could not open the file:$!\n";

print "Accession\tfc\tpvalue\n";

while(<IN>)
{
	chomp;
	($id,$fc,$pvalue)=(split /\t/)[0,1,2];
	unless($id eq "Accession")
	{
		unless($pvalue eq "NaN")
		{
			if($fc >= 1.2 && $pvalue <= 0.05)
			{
				print "$id\t$fc\t$pvalue\n";
			}
			elsif($fc <= 0.84 && $pvalue <= 0.05)
			{
				print "$id\t$fc\t$pvalue\n";
			}
		}
	}
}
