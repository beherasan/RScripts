#!/usr/bin/perl
#
#
open(IN,"augustus_gene_k50_10000_more.gtf") or die "Could not open the file:$!\n";

$flag=0;
while(<IN>)
{
	chomp;
	if(/\# protein sequence/)
	{
		$flag=1;
	}
	if(/\# end gene/)
	{
		$flag=0;
		$id=$_;
		$id=~s/\# end//g;
		$seq=~s/\# //g;
		$seq=~m/\[([A-Z]+)\]/;
		print ">$id\n$1\n";
		$seq="";
	}
	if($flag == 1)
	{
		$seq.=$_;
	}
}
