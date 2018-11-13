#!/usr/bin/perl

open(IN,"DBP_TMT_cerebellum_all9_QN_BC.txt") or die "Could not open the file:$!\n";

while(<IN>)
{
	chomp;
	@all=(split /\,/);
	$sum1=$sum2=$count1=$count2=0;
	for($i=1;$i<scalar(@all);$i++)
	{
		$v=$all[$i];
## Start and End Age group 1st and 9th
=start
		if($i >= 25 && $i<= 27)
		{
			$sum1+=$v;
			unless($v == 0)
			{
				$count1++;
			}	
		}
		elsif($i >= 1 and $i <= 24)
		{
			$sum2+=$v;
			unless($v == 0)
			{
				$count2++;
			}
		}
=cut
## Age groups in the middle 2nd to 8th
#=start
		if($i >= 1 && $i <= 21)
		{
			$sum2+=$v;
			unless($v == 0)
			{
				$count2++;
			}
		}
		elsif($i >= 22 && $i <= 24)
		{
			$sum1+=$v;
			unless($v == 0)
			{
				$count1++;
			}
		}
		elsif($i >= 25 and $i <= 27)
		{
			$sum2+=$v;
			unless($v == 0)
			{
				$count2++;
			}
		}
#=cut
	}
	unless($count1 == 0)
	{
		$av1=$sum1/$count1;
	}
	else
	{
		$av1=0;
	}
	unless($count2 == 0)
	{
		$av2=$sum2/$count2;
	}
	else
	{
		$av2=0;
	}
	if($av1 !=0 && $av2 !=0)
	{
		$fc=$av1/$av2;
	}
	elsif($av1 == 0)
	{
		$fc= -($av2); 
	}
	else
	{
		$fc = $av1;
	}	
	#print "\n";
	if($all[0] eq "Accession")
	{
		print "$all[0]\tfc\n";
	}
	else
	{
		print "$all[0]\t$fc\n";
	}
}
