#!/usr/bin/perl

open(IN,"DBP_cerebellum_ASOP.txt") or die "Could not open the file:$!\n";

open(OUT,">DBP_cerebellum_ASOP_scaled.txt") or die "Could not create the file:$!\n";

while(<IN>)
{
	chomp;
	unless(/^Accession/)
	{
		@line=(split /\,/);
		for($i=1;$i<scalar(@line);$i++)
		{
			if($line[$i] eq "")
			{
				#print "$line[$i]\t";
				#print "$line[0]\t";
				$line[$i]= 0;
				#print "$line[$i]\t\n";
			}
			if($i==1)
			{
				$line_max=$line[$i];
			}
			if($line[$i] >= $line_max)
			{
				$line_max=$line[$i];
			}
		}
		print OUT "$line[0]";
		for($i=1;$i<scalar(@line);$i++)
		{
			if($line[$i] eq "")
			{
				#print "santosh$line[$i]\t";
				#print "santosh$line[0]\t";
				$line[$i]=0;
				#print "santosh$line[$i]\t";
				$new_value= ($line[$i]/$line_max)*100;
				#print "santosh$new_value\t\n";
			}
			$new_value= ($line[$i]/$line_max)*100;
			print OUT ",$new_value";
		}
		print OUT "\n";
	}
	else
	{
		print OUT "$_\n";
	}
}
