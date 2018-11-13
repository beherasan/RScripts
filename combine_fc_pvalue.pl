#!/usr/bin/perl

$infile1=$ARGV[0]; # fc file
$infile2=$ARGV[1]; # pvalue file

open(IN1,"$infile1") or die "Could not open the file:$!\n";

while(<IN1>)
{
	chomp;
	unless(/^Accession/)
	{
		($id,$fc)=(split /\t/)[0,1];
		$hash{$id}="$fc";
	}
}

close IN1;

open(IN2,"$infile2") or die "Could not open the file:$!\n";

print "Accession\tfc\tpvalue\n";
while(<IN2>)
{
	chomp;
	($id1,$pvalue)=(split /\"/)[1,3];
	if(exists $hash{$id1})
	{
		print "$id1\t$hash{$id1}\t$pvalue\n";
	}
}

close IN2;
