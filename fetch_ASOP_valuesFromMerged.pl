#!/usr/bin/perl

$infile=$ARGV[0]; #ASOP file
$outfile=$ARGV[1]; #output file

open(IN,"$infile") or die "Could not open the file:$!\n";

while(<IN>)
{
	chomp;
	unless(/^Accession/)
	{
		($id,$pvalue)=(split /\t/)[0,2];
		unless($pvalue eq "NA")
		{
			$hash{$id}.="";
		}
	}
}

open(IN,"DBP_TMT_cerebellum_all9_QN_BC.txt") or die "Could not open the file:$!\n";
open(OUT,">$outfile") or die "Could not create the file:$!\n";

while(<IN>)
{
	chomp;
	unless(/^Accession/)
	{
		($id1)=(split /\,/)[0];
		if(exists $hash{$id1})
		{
			print OUT "$_\n";
		}
	}
	else
	{
		print OUT "$_\n";
	}
}
